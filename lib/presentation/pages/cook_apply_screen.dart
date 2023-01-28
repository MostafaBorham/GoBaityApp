import 'package:flutter/material.dart';
import 'package:yallabaity/network_layer/models/item_model.dart';
import 'package:yallabaity/presentation/resources/assets_manager.dart';
import 'package:yallabaity/presentation/resources/colors_manager.dart';
import 'package:yallabaity/presentation/resources/constants_manager.dart';
import 'package:yallabaity/presentation/resources/styles_manager.dart';
import 'package:yallabaity/presentation/resources/values_manager.dart';
import 'package:yallabaity/presentation/widgets/circular_icon_button.dart';
import 'package:yallabaity/presentation/widgets/custom_tile_%20button.dart';
import 'package:yallabaity/presentation/widgets/custom_button.dart';
import 'package:yallabaity/presentation/widgets/single_select_drop_down_menu.dart';
import 'package:yallabaity/presentation/widgets/custom_title.dart';
import 'package:yallabaity/presentation/widgets/phone_textfield.dart';
import 'package:yallabaity/presentation/resources/routes_manager.dart';

class CookApplyScreen extends StatelessWidget {
  const CookApplyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Stack(
          children: [
            SizedBox(
              height: AppHeight.s280*Constants.height,
              width: double.maxFinite,
              child: Image.asset(
                AssetsManager.loginFood,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: AppHeight.s280*Constants.height,
              decoration:
                  BoxDecoration(color: ColorsManager.black.withOpacity(0.32)),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset(AssetsManager.gobaity1,
                    height: AppWidth.s170*Constants.width,
                    width: AppWidth.s170 * Constants.width),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Padding(
                padding: EdgeInsets.only(
                  top: AppHeight.s45*Constants.height,
                  left: Constants.margin,
                ),
                child: CircularIconButton(
                  asset: AssetsManager.back,
                  color: ColorsManager.white,
                  ontap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: AppHeight.s126*Constants.height),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorsManager.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50),
                  ),
                ),
                child: Column(//set widgets vertically
                  children: [
                    SizedBox(
                      height: AppHeight.s31 * Constants.height,
                    ),
                    CustomTitle(text: 'Apply to be a provider'),
                    SizedBox(
                      height: AppHeight.s38 * Constants.height,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppWidth.s33 * Constants.width),
                      child: _buildInputFormField(context),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildInputFormField(BuildContext context) => Form(
          child: Column(//set widgets vertically
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PhoneTextField(),
          SizedBox(
            height: AppHeight.s19*Constants.height,
          ),
          SingleSelectDropDownMenu(
            title: 'City',
            list: [
              ItemModel(title: 'Cairo'),
              ItemModel(title: 'Giza'),
              ItemModel(title: 'Bani sweef'),
              ItemModel(title: 'Ismaily'),
              ItemModel(title: 'Cairo'),
              ItemModel(title: 'Giza'),
              ItemModel(title: 'Bani sweef'),
              ItemModel(title: 'Ismaily'),
              ItemModel(title: 'Cairo'),
              ItemModel(title: 'Giza'),
              ItemModel(title: 'Bani sweef'),
              ItemModel(title: 'Ismaily'),
              ItemModel(title: 'Cairo'),
              ItemModel(title: 'Giza'),
              ItemModel(title: 'Bani sweef'),
              ItemModel(title: 'Ismaily'),
              ItemModel(title: 'Cairo'),
              ItemModel(title: 'Giza'),
              ItemModel(title: 'Bani sweef'),
              ItemModel(title: 'Ismaily'),
            ],
            onSelectedItem: (size) {},
          ),
          SizedBox(
            height: AppHeight.s20 * Constants.height,
          ),
          SingleSelectDropDownMenu(
            title: 'Gender',
            list: [
              ItemModel(title: 'Male'),
              ItemModel(title: 'Girl'),
            ],
            onSelectedItem: (size) {},
          ),
          SizedBox(
            height: AppHeight.s20 * Constants.height,
          ),
          CustomTileButton(text: 'Your Location on map'),
          SizedBox(
            height: AppHeight.s20 * Constants.height,
          ),
          CustomTileButton(text: 'Upload ID photos'),
          SizedBox(
            height: AppHeight.s20 * Constants.height,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppWidth.s20 * Constants.width),
            child: TextButton(
              child: Text(
                '2 photos front and back',
                style: getMediumStyle(
                    color: ColorsManager.gray,
                    fontSize: AppWidth.s14 * Constants.width),
              ),
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  minimumSize: Size(0, 0)),
              onPressed: () {},
            ),
          ),
          SizedBox(
            height: AppHeight.s20 * Constants.height,
          ),
          Row(// set widgets horizontally
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topRight,
                children: [
                  Container(
                    height: AppWidth.s66 * Constants.width,
                    width: AppWidth.s66 * Constants.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                     ),
                    child: Image.asset(
                      'assets/images/nid.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    right: -10,
                    top: -10,
                    child: CircularIconButton(
                      radius: AppWidth.s34 * Constants.width / 2,
                      asset: AssetsManager.decrease,
                      assetColor: ColorsManager.jasper,
                    ),
                  )
                ],
              ),
              SizedBox(
                width: AppWidth.s24*Constants.width,
              ),
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topRight,
                children: [
                  Container(
                    height: AppWidth.s66*Constants.width,
                    width: AppWidth.s66*Constants.width,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(11)),
                    child: Image.asset(
                      'assets/images/nid.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    right: -10,
                    top: -10,
                    child: CircularIconButton(
                      radius: AppWidth.s34*Constants.width / 2,
                      asset: AssetsManager.decrease,
                      assetColor: ColorsManager.jasper,
                    ),
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: AppHeight.s30 * Constants.height,
          ),
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              text: 'Send for review',
              onPressed: () =>
                  Navigator.of(context).pushNamed(Routes.addFoodRoute),
            ),
          ),
          SizedBox(
            height: AppHeight.s100 * Constants.height,
          ),
        ],
      ));
}
