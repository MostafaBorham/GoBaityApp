import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yallabaity/presentation/resources/assets_manager.dart';
import 'package:yallabaity/presentation/resources/constants_manager.dart';

import '../resources/colors_manager.dart';

class CircularIconButton extends StatelessWidget {
  double? _radius;
  String? _asset;
  double? _height;
  double? _width;
  Color? _color;
  Color? _assetColor;
  Function()? _ontap;
  CircularIconButton({super.key,
    double radius = 20,
    required String asset,
    Color color = ColorsManager.cultured,
    Color assetColor = ColorsManager.maximumPurple,
    double? height,
    double? width,
    Function()? ontap,
  }) {
    _radius = radius;
    _asset = asset;
    _color = color;
    _ontap = ontap;
    _height = height;
    _width = width;
    _assetColor = assetColor;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _ontap,
      child: DecoratedBox(
        decoration: BoxDecoration(
            boxShadow: [
          BoxShadow(
              color: ColorsManager.black.withOpacity(0.11),
              offset: const Offset(0, 4),
              blurRadius: 14)
        ]),
        child: CircleAvatar(
          radius: _radius,
          backgroundColor: _color,
          child: SizedBox(
            width: _width,
            height: _height,
            child: SvgPicture.asset(
              _asset!,
              fit: BoxFit.cover,
              matchTextDirection: true,
              color: _assetColor,
            ),
          ),
        ),
      ),
    );
  }
}
