import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:yallabaity/presentation/resources/colors_manager.dart';
import 'package:yallabaity/presentation/resources/constants_manager.dart';
import 'package:yallabaity/presentation/resources/strings_manager.dart';
import 'package:yallabaity/presentation/resources/styles_manager.dart';
import 'package:yallabaity/presentation/resources/values_manager.dart';
import 'package:yallabaity/presentation/widgets/custom_checkbox.dart';

class MyCurrentLocationDetails extends StatelessWidget {
  String? city;
  String? governorate;
  String? street;
  MyCurrentLocationDetails({this.governorate, this.city, this.street, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppHeight.s20 * Constants.height, horizontal: Constants.margin),
      decoration: BoxDecoration(
          color: ColorsManager.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: ColorsManager.black.withOpacity(0.07), offset: Offset(0, 0), blurRadius: 20)]),
      child: Column(//set widgets vertically
        children: [
          AutoSizeText(
      AppStrings.translate(AppStrings.useMyCurrentLocation),
            maxLines: 1,
            style: getMediumStyle(
              color: ColorsManager.davysGrey,
              fontSize: AppWidth.s14 * Constants.width,
            ),
          ),
          SizedBox(height: AppHeight.s9 * Constants.height),
          Row(// set widgets horizontally
            children: [
              Expanded(
                child: AutoSizeText(
                  '$city, $governorate',
                  maxLines: 1,
                  softWrap: true,
                  style: getMediumStyle(color: ColorsManager.black, fontSize: AppWidth.s16 * Constants.width),
                ),
              ),
              CustomCheckBox(
                isChecked: true,
                width: 22,
                height: 22,
              ),
            ],
          ),
          SizedBox(height: AppHeight.s9 * Constants.height),
          AutoSizeText(
            '$street',
            maxLines: 1,
            softWrap: true,
            style: getMediumStyle(color: ColorsManager.black.withOpacity(0.5), fontSize: AppWidth.s13 * Constants.width),
          ),
          SizedBox(height: AppHeight.s9 * Constants.height),
        ],
      ),
    );
  }
}
