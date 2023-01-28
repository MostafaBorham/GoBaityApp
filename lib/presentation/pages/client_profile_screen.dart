import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yallabaity/presentation/resources/assets_manager.dart';
import 'package:yallabaity/presentation/resources/colors_manager.dart';
import 'package:yallabaity/presentation/resources/constants_manager.dart';
import 'package:yallabaity/presentation/resources/routes_manager.dart';
import 'package:yallabaity/presentation/resources/strings_manager.dart';
import 'package:yallabaity/presentation/resources/styles_manager.dart';
import 'package:yallabaity/presentation/resources/values_manager.dart';
import 'package:yallabaity/presentation/pages/cart_screen.dart';
import 'package:yallabaity/presentation/widgets/custom_tile_%20button.dart';
import 'package:yallabaity/presentation/widgets/linear_gradient_body.dart';
import 'package:yallabaity/presentation/widgets/custom_appbar.dart';
import 'package:yallabaity/presentation/widgets/custom_button.dart';

class ClientProfileScreen extends StatelessWidget {
  const ClientProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearGradientBody(
      appbarTitle: AppStrings.translate(AppStrings.myProfile),
      onBackPressed: () {
        Navigator.of(context).pop();
      },
      onCartPressed: () {
        Get.to(() => CartScreen());
      },
      child: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: AppWidth.s31 * Constants.width),
          child: GestureDetector(
            child: Column(
              //set widgets vertically
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: AppHeight.s30 * Constants.height,
                ),
                Text(
                  'Mohamed Ghitany',
                  style: getSemiBoldStyle(
                      fontSize: AppWidth.s18 * Constants.width,
                      color: ColorsManager.maximumPurple),
                ),
                SizedBox(
                  height: AppHeight.s4 * Constants.height,
                ),
                Text(
                  '0107 387 3899',
                  style: getSemiBoldStyle(
                      fontSize: AppWidth.s14 * Constants.width,
                      color: ColorsManager.maximumPurple.withOpacity(0.71)),
                ),
                SizedBox(
                  height: AppHeight.s37 * Constants.height,
                ),
                Text(
                  '30.00 EGP',
                  style: getSemiBoldStyle(
                      fontSize: AppWidth.s18 * Constants.width,
                      color: ColorsManager.maximumPurple),
                ),
                SizedBox(
                  height: AppHeight.s54 * Constants.height,
                ),
                CustomTileButton(
                  text: AppStrings.translate(AppStrings.ordersHistory),
                  suffixAsset: AssetsManager.arrow,
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.ordersHistoryRoute);
                  },
                ),
                SizedBox(
                  height: AppHeight.s18 * Constants.height,
                ),
                CustomTileButton(
                  text: AppStrings.translate(AppStrings.savedItems),
                  suffixAsset: AssetsManager.arrow,
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.savedRoute);
                  },
                ),
                SizedBox(
                  height: AppHeight.s18 * Constants.height,
                ),
                CustomTileButton(
                  text: AppStrings.translate(AppStrings.accountInfo),
                  suffixAsset: AssetsManager.arrow,
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.accountInfoRoute);
                  },
                ),
                SizedBox(
                  height: AppHeight.s18 * Constants.height,
                ),
                CustomTileButton(
                  text: AppStrings.translate(AppStrings.languageTitle),
                  onTap: () {
                    Navigator.pushNamed(context, Routes.accountInfoRoute);
                  },
                  suffix: Text(
                    AppStrings.translate(AppStrings.language),
                    style: getSemiBoldStyle(
                      fontSize: AppWidth.s14 * Constants.width,
                      color: ColorsManager.pixiePowder,
                      textDecoration: TextDecoration.underline,
                    ),
                  ),
                  suffixAsset: AssetsManager.arrow,
                ),
                SizedBox(
                  height: AppHeight.s100 * Constants.height,
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: CustomButton(
                    text: AppStrings.translate(AppStrings.logout),
                    outlined: true,
                    onPressed: () {
                      Navigator.of(context)
                          .popUntil(ModalRoute.withName(Routes.homeRoute));
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
