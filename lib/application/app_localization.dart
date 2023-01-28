import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:yallabaity/application/app_prefs.dart';
import 'package:yallabaity/injection_container.dart' as di;

abstract class AppLocalization {
  static const List<Locale> supportedLocales = [englishLocale, arabicLocale];
  static const Locale defaultLocale = englishLocale;
  static const String englishCode = 'en';
  static const String englishCountry = 'US';
  static const String arabicCode = 'ar';
  static const String arabicCountry = 'EG';
  static const Locale englishLocale = Locale(englishCode, englishCountry);
  static const Locale arabicLocale = Locale(arabicCode, arabicCountry);
  static const String translationPath = 'assets/translations';
  static String apiLocaleCode = apiEnglishLocaleCode;
  static String apiEnglishLocaleCode = '${englishCode}-${englishCountry}';
  static String apiArabicLocaleCode = '${arabicCode}-${arabicCountry}';

  static void setApiLocalCode(String langCode) {
    if (langCode == arabicCode) {
      apiLocaleCode = apiArabicLocaleCode;
    } else if (langCode == englishCode) {
      apiLocaleCode = apiEnglishLocaleCode;
    }
  }

  static changeLanguage(BuildContext context) {
    bool isEnglish = false;
    if (EasyLocalization.of(context)!.locale == AppLocalization.arabicLocale) {
      isEnglish = true;
    }
    di.getIt<AppPrefs>().setEnglishLanguage(isEnglish);
    Phoenix.rebirth(context);
  }

  static bool get isAppEnglish {
    return di.getIt<AppPrefs>().isAppEnglish;
  }
}
