import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yallabaity/application/app_localization.dart';
import 'package:yallabaity/presentation/resources/assets_manager.dart';
import 'package:yallabaity/presentation/resources/colors_manager.dart';
import 'package:yallabaity/presentation/resources/constants_manager.dart';

class CustomIconButton extends StatelessWidget {
  late String _asset;
  Color? _color;

  Function()? _onTap;
  CustomIconButton(
      {super.key, required String asset,
        Color color=ColorsManager.eerieBlack,
      double height = 15,
      double width = 15,
      Function()? onTap}) {
    _onTap = onTap;
    _asset = asset;

    _color=color;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _onTap,
      child: SvgPicture.asset(
        _asset,
        fit: BoxFit.fill,
        matchTextDirection: true,
        color: _color,
      ),
    );
  }
}
