
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:yallabaity/application/app_localization.dart';
import 'package:yallabaity/application/app_prefs.dart';
import 'package:yallabaity/gobaity_app.dart';
import 'package:yallabaity/localization_configuration.dart';
import 'package:yallabaity/notification_api.dart';
import 'injection_container.dart' as di; // for dependancy inversion
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await NotificationApi.init();
  await EasyLocalization.ensureInitialized();///Localization install
  await NotificationApi.notificationsDetails(body: AppLocalization.isAppEnglish? 'welcome in gobaity ❤️❤️' : 'مرحيا بك فى جو بيتى ❤️❤️', title: di.getIt<AppPrefs>().isAppEnglish?'welcome' : 'مرحبا');
  runApp( Phoenix(child: const MyLocalizationConfiguration(child: GoBaityApp())));
}
