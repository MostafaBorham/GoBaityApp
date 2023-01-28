import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'application/app_localization.dart';

class MyLocalizationConfiguration extends StatelessWidget {
  final Widget child;
  const MyLocalizationConfiguration({Key? key,required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: AppLocalization.supportedLocales,
      path: AppLocalization.translationPath,
      fallbackLocale: AppLocalization.defaultLocale,
      saveLocale: true,
      child: child,
    );
  }
}