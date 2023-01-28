import 'package:flutter/material.dart';
import 'package:yallabaity/presentation/resources/colors_manager.dart';
import 'package:yallabaity/presentation/resources/constants_manager.dart';
import 'package:yallabaity/presentation/resources/fonts_manager.dart';
import 'package:yallabaity/presentation/resources/strings_manager.dart';
import 'package:yallabaity/presentation/resources/styles_manager.dart';
import 'package:yallabaity/presentation/resources/values_manager.dart';

class ForgetPassword extends StatelessWidget {
  void Function()? _onTap;
  ForgetPassword({super.key, void Function()? onTap}) {
    _onTap = onTap;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _onTap,
      child: Text(
        AppStrings.translate(AppStrings.forgetPassword),
        style: getMediumStyle(
          color: ColorsManager.maximumPurple,
          fontSize: AppWidth.s13*Constants.width,
          textDecoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
