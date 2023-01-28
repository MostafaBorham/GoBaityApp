import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yallabaity/presentation/resources/assets_manager.dart';
import '../resources/colors_manager.dart';
import '../resources/constants_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

class LocationItem extends StatelessWidget {
  const LocationItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppHeight.s15 * Constants.height),
      margin: EdgeInsets.symmetric(horizontal: AppWidth.s27 * Constants.width),
      decoration: BoxDecoration(
          color: ColorsManager.antiFlashWhite,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(AppWidth.s15 * Constants.width),
              bottomRight: Radius.circular(AppWidth.s15 * Constants.width))),
      child: Row(// set widgets horizontally
        children: [
          SizedBox(
            width: AppWidth.s23 * Constants.width,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
                border: Border.all(color: ColorsManager.maximumPurple, width: 1),
                color: ColorsManager.white,
                shape: BoxShape.circle),
            child: Padding(
              padding: EdgeInsets.all(AppWidth.s3 * Constants.width),
              child: Image.asset(AssetsManager.redMark,)
            ),
          ),
          SizedBox(
            width: AppWidth.s15 * Constants.width,
          ),
          Text(
            AppStrings.translate(AppStrings.useMyCurrentLocation),
            style: getMediumStyle(fontSize: AppWidth.s13 * Constants.width),
          ),
        ],
      ),
    );
  }
}
