import 'package:flutter/material.dart';
import 'package:yallabaity/network_layer/models/order_model.dart';
import 'package:yallabaity/presentation/resources/assets_manager.dart';
import 'package:yallabaity/presentation/resources/colors_manager.dart';
import 'package:yallabaity/presentation/resources/constants_manager.dart';
import 'package:yallabaity/presentation/resources/strings_manager.dart';
import 'package:yallabaity/presentation/resources/styles_manager.dart';
import 'package:yallabaity/presentation/resources/values_manager.dart';

import 'package:yallabaity/presentation/widgets/custom_appbar.dart';
import 'package:yallabaity/presentation/widgets/custom_filled_checkbox.dart';
import 'package:yallabaity/presentation/widgets/custom_tile_%20button.dart';
import 'package:yallabaity/presentation/widgets/custom_button.dart';
import 'package:yallabaity/presentation/widgets/icon_button.dart';
import 'package:yallabaity/presentation/widgets/search.dart';

import '../widgets/custom_checkbox.dart';

class ProviderOrdersScreen extends StatefulWidget {
  ProviderOrdersScreen({Key? key}) : super(key: key);

  @override
  State<ProviderOrdersScreen> createState() => _ProviderOrdersScreenState();
}

class _ProviderOrdersScreenState extends State<ProviderOrdersScreen> {
  List<ProviderOrdersModel> list = [
    ProviderOrdersModel(clientName: 'Mohamed Ghitany', ordersList: [
      OrderModel(
          asset: 'assets/images/food2.png',
          foodName: 'Molokheya & Chicken',
          location: 'Cairo, maadi',
          quantity: 2,
          totalPrice: '200.00',
          sizes: '1 Small 1 Larg'),
    ]),
    ProviderOrdersModel(clientName: 'Mohamed Ghitany', ordersList: [
      OrderModel(
          asset: 'assets/images/food2.png',
          foodName: 'Molokheya & Chicken',
          location: 'Cairo, maadi',
          quantity: 2,
          totalPrice: '200.00',
          sizes: '1 Small 1 Larg'),
      OrderModel(
          asset: 'assets/images/food2.png',
          foodName: 'Molokheya & Chicken',
          location: 'Cairo, maadi',
          quantity: 2,
          totalPrice: '200.00',
          sizes: '1 Small 1 Larg'),
      OrderModel(
          asset: 'assets/images/food2.png',
          foodName: 'Molokheya & Chicken',
          location: 'Cairo, maadi',
          quantity: 2,
          totalPrice: '200.00',
          sizes: '1 Small 1 Larg'),
    ]),
    ProviderOrdersModel(clientName: 'Mohamed Ghitany', ordersList: [
      OrderModel(
          asset: 'assets/images/food2.png',
          foodName: 'Molokheya & Chicken',
          location: 'Cairo, maadi',
          quantity: 2,
          totalPrice: '200.00',
          sizes: '1 Small 1 Larg'),
      OrderModel(
          asset: 'assets/images/food2.png',
          foodName: 'Molokheya & Chicken',
          location: 'Cairo, maadi',
          quantity: 2,
          totalPrice: '200.00',
          sizes: '1 Small 1 Larg'),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        prefix: CustomIconButton(
          asset: AssetsManager.back,
          color: ColorsManager.white,
          height: AppWidth.s20*Constants.width,
          width: AppWidth.s11*Constants.width,
          onTap: () {},
        ),
        title: AppStrings.translate(AppStrings.orders),
        backgroundColor: ColorsManager.maximumPurple,
        showBackgroundImage: true,
      ),
      body: Column(//set widgets vertically
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: AppHeight.s19*Constants.height,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Constants.margin),
            child: Search(
              hintText: 'Search ',
            ),
          ),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: list.length,

              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => _buildOrderItem(index),

              separatorBuilder: (BuildContext context, int index) => Stack(
                alignment: Alignment.center,
                children: [
                  Divider(
                    color: ColorsManager.platinum,
                    thickness: 7,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: Constants.margin),
                    child: AnimatedContainer(
                      width: list[index].nSelected>0?double.maxFinite: 0 ,
                      height: list[index].nSelected>0?AppWidth.s56*Constants.width: 0,
                      duration: Duration(milliseconds: 500),
                      child: CustomButton(
                        text: 'Conifrm for delivery',
                        onPressed: () {},
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildOrderItem(int itemIndex) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Constants.margin,
        ),
        child: Column(//set widgets vertically
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: AppHeight.s37*Constants.height,
            ),
            Text(
              'Ordered By',
              style: getSemiBoldStyle(
                  color: ColorsManager.eerieBlack, fontSize: AppWidth.s17*Constants.width),
            ),
            SizedBox(
              height: AppHeight.s4*Constants.height,
            ),
            Text(
              list[itemIndex].clientName!,
              style: getMediumStyle(
                  color: ColorsManager.maximumPurple, fontSize: AppWidth.s12*Constants.width),
            ),
            SizedBox(
              height: AppHeight.s54*Constants.height,
            ),
            ListView.separated(
              itemCount: list[itemIndex].ordersList!.length,
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) => Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,// is used to clip the internal child widget of container when u define border radius,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            width: 2,
                            color: ColorsManager.black.withOpacity(0.07))),
                    child: Column(//set widgets vertically
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: AppWidth.s133*Constants.width,
                          width: double.maxFinite,
                          child: Image.asset(
                            list[itemIndex].ordersList![index].asset!,
                          ),
                        ),
                        SizedBox(
                          height: AppHeight.s12*Constants.height,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Constants.margin),
                          child: Column(//set widgets vertically
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                list[itemIndex].ordersList![index].foodName!,
                                style: getSemiBoldStyle(
                                    color: ColorsManager.black,
                                    fontSize: AppWidth.s15*Constants.width),
                              ),
                              SizedBox(
                                height: AppHeight.s10*Constants.height,
                              ),
                              Row(// set widgets horizontally
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(//set widgets vertically
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'location',
                                        style: getMediumStyle(
                                            fontSize: AppWidth.s12*Constants.width,
                                            color: ColorsManager.graniteGray),
                                      ),
                                      Text(
                                        list[itemIndex]
                                            .ordersList![index]
                                            .location!,
                                        style: getMediumStyle(
                                            fontSize: AppWidth.s12*Constants.width,
                                            color: ColorsManager.maximumPurple),
                                      ),
                                      SizedBox(
                                        height: AppHeight.s6*Constants.height,
                                      ),
                                      Text(
                                        'sizes',
                                        style: getMediumStyle(
                                            fontSize: AppWidth.s12*Constants.width,
                                            color: ColorsManager.graniteGray),
                                      ),
                                      Text(
                                        list[itemIndex]
                                            .ordersList![index]
                                            .sizes!,
                                        style: getMediumStyle(
                                            fontSize: AppWidth.s12*Constants.width,
                                            color: ColorsManager.maximumPurple),
                                      ),
                                    ],
                                  ),
                                  Column(//set widgets vertically
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Quanitity',
                                        style: getMediumStyle(
                                            fontSize: AppWidth.s12*Constants.width,
                                            color: ColorsManager.graniteGray),
                                      ),
                                      Text(
                                        list[itemIndex]
                                            .ordersList![index]
                                            .quantity!
                                            .toString(),
                                        style: getMediumStyle(
                                            fontSize: AppWidth.s12*Constants.width,
                                            color: ColorsManager.maximumPurple),
                                      ),
                                      SizedBox(
                                        height: AppHeight.s6*Constants.height,
                                      ),
                                      Text(
                                        'Total Price',
                                        style: getMediumStyle(
                                            fontSize: AppWidth.s12*Constants.width,
                                            color: ColorsManager.graniteGray),
                                      ),
                                      Text(
                                        list[itemIndex]
                                            .ordersList![index]
                                            .totalPrice!,
                                        style: getMediumStyle(
                                            fontSize: AppWidth.s16*Constants.width,
                                            color: ColorsManager.maximumPurple),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: AppHeight.s60*Constants.height,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned.fill(
                      bottom: -AppHeight.s15*Constants.height,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: CustomTileButton(
                          text: 'Select Order',
                          suffix: CustomFilledCheckBox(
                            height: AppWidth.s26*Constants.width,
                            width: AppWidth.s26*Constants.width,
                            borderRadius: AppWidth.s6*Constants.width,
                            isChecked:
                                list[itemIndex].ordersList![index].selected,
                            onCheck: (checked) {
                             debugPrint(checked.toString());

                              setState(() {
                                list[itemIndex].ordersList![index].selected =
                                    checked;
                                if (list[itemIndex]
                                        .ordersList![index]
                                        .selected ==
                                    true)
                                  list[itemIndex].nSelected++;
                                else
                                  list[itemIndex].nSelected--;
                              });
/*
                                setState(() {});
*/
                            },
                          ),
                        ),
                      ))
                ],
              ),
              separatorBuilder: (BuildContext context, int index) => SizedBox(
                height: AppHeight.s52*Constants.height,
              ),
            ),
            SizedBox(
              height: AppHeight.s52*Constants.height,
            ),
          ],
        ),
      );
}
