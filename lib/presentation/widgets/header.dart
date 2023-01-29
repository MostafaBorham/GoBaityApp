import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:yallabaity/presentation/resources/assets_manager.dart';
import 'package:yallabaity/presentation/resources/colors_manager.dart';
import 'package:yallabaity/presentation/resources/constants_manager.dart';
import 'package:yallabaity/presentation/resources/values_manager.dart';
import 'package:yallabaity/presentation/widgets/circular_icon_button.dart';

class Header extends StatelessWidget {
  Function()? _onBackBtnPressed;
  Header({super.key, Function()? onBackBtnPressed}) {
    _onBackBtnPressed = onBackBtnPressed;
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppHeight.s280 * Constants.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Image.asset(
            AssetsManager.loginFood,
            fit: BoxFit.fill,
          ),
          ColoredBox(
            color: ColorsManager.black.withOpacity(0.23),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: AppWidth.s100 * Constants.width,
                width: AppWidth.s250* Constants.width,
                child: Image.asset(
                  AssetsManager.gobaity1,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          PositionedDirectional(
            top: 0,
            start: 0,
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                top: AppHeight.s45 * Constants.height,
                start: Constants.margin,
              ),
              child: CircularIconButton(
                asset: AssetsManager.back,
                color: ColorsManager.white,
                ontap: _onBackBtnPressed,
              ),
            ),
          )
        ],
      ),
    );
  }
}
