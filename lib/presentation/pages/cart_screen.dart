import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yallabaity/domain/entities/requests_entites/food_entity.dart';
import 'package:yallabaity/network_layer/models/data_models/food_model.dart';
import 'package:yallabaity/presentation/resources/assets_manager.dart';
import 'package:yallabaity/presentation/resources/colors_manager.dart';
import 'package:yallabaity/presentation/resources/constants_manager.dart';
import 'package:yallabaity/presentation/resources/routes_manager.dart';
import 'package:yallabaity/presentation/resources/strings_manager.dart';
import 'package:yallabaity/presentation/resources/styles_manager.dart';
import 'package:yallabaity/presentation/resources/values_manager.dart';
import 'package:yallabaity/presentation/widgets/cart_item.dart';
import 'package:yallabaity/presentation/widgets/custom_appbar.dart';
import 'package:yallabaity/presentation/widgets/custom_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with TickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  Widget build(BuildContext context) {
    _animationController = AnimationController(vsync: this);

    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.translate(AppStrings.myBag),
        showBackgroundImage: true,
      ),
      bottomSheet: BottomSheet(
        animationController: _animationController,
        builder: (context) => Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,// is used to clip the internal child widget of container when u define border radius,
          height: AppHeight.s246*Constants.height,
          decoration: BoxDecoration(
              color: ColorsManager.maximumPurple,
              borderRadius: BorderRadius.circular(36)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Constants.margin),
            child: Column(//set widgets vertically
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: AppHeight.s30 * Constants.height,
                ),
                Row(// set widgets horizontally
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Subtotal',
                      style: getMediumStyle(
                          color: ColorsManager.white.withOpacity(0.8),
                          fontSize: AppWidth.s16 * Constants.width),
                    ),
                    Text(
                      '230.00 EGP',
                      style: getSemiBoldStyle(
                          color: ColorsManager.white.withOpacity(0.8),
                          fontSize: AppWidth.s16 * Constants.width),
                    ),
                  ],
                ),
                SizedBox(
                  height: AppHeight.s16*Constants.height,
                ),
                Row(// set widgets horizontally
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Delivery',
                      style: getMediumStyle(
                          color: ColorsManager.white.withOpacity(0.8),
                          fontSize: AppWidth.s16 * Constants.width),
                    ),
                    Text(
                      '15.00 EGP',
                      style: getSemiBoldStyle(
                          color: ColorsManager.white.withOpacity(0.8),
                          fontSize: AppWidth.s16 * Constants.width),
                    ),
                  ],
                ),
                SizedBox(
                  height: AppHeight.s16*Constants.height,
                ),
                Row(// set widgets horizontally
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'TOTAL',
                      style: getSemiBoldStyle(
                          color: ColorsManager.white.withOpacity(0.8),
                          fontSize: AppWidth.s18 * Constants.width),
                    ),
                    Text(
                      '230.00 EGP',
                      style: getSemiBoldStyle(
                          color: ColorsManager.white.withOpacity(0.8),
                          fontSize: AppWidth.s18 * Constants.width),
                    ),
                  ],
                ),
                SizedBox(
                  height: AppHeight.s24 * Constants.height,
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: CustomButton(
                    text: 'Checkout',
                    color: ColorsManager.white,
                    textColor: ColorsManager.maximumPurple,
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(Routes.clientLocationRoute);
                    },
                  ),
                ),
                SizedBox(
                  height: AppHeight.s24 * Constants.height,
                ),
              ],
            ),
          ),
        ),
        onClosing: () {},
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Constants.margin),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(//set widgets vertically
            children: [
              SizedBox(
                height: AppHeight.s53*Constants.height,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: FoodModel.all.length,
                itemBuilder: (context, index) => CartItem(
                  item: FoodModel.all[index],
                ),
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                  height: AppHeight.s53*Constants.height,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
