import 'package:shared_preferences/shared_preferences.dart';
import 'package:yallabaity/application/extensions.dart';
import 'package:yallabaity/network_layer/models/data_models/user_model.dart';

class AppPrefs {
  final SharedPreferences preferences;
  AppPrefs({required this.preferences});
  static const String prefsUsersKey = 'CACHED_USERS';
  static const String prefsLanguageKey = 'LANGUAGE';
  static const String prefsUsersAddressKey = 'CACHED_USERS_ADDRESS';
  static const String prefsLoggedInKey = "IS_LOGGED_IN";
  static const String prefsGetStatedKey = "GET_STARTED";
  static const String citiesKey = "cities";
  static const String prefsUserKey = "User id";
  Future<bool> get isUserLoggedIn async => preferences.getBool(prefsLoggedInKey) ?? false;
  Future<void> get setUserLoggedIn async => preferences.setBool(prefsLoggedInKey, true);
  bool get isAppEnglish => preferences.getBool(prefsLanguageKey) ?? false;
  Future<void>  setEnglishLanguage(bool isEnglish) async => await preferences.setBool(prefsLanguageKey, isEnglish);
  Future<void> get logout async => preferences.remove(prefsLoggedInKey);
  Future<bool> get getStartedPressed async => preferences.getBool(prefsGetStatedKey) ?? false;
  Future<UserModel?> get user async{
    String? cachedUser = preferences.getString(AppPrefs.prefsUsersKey);
    UserModel? userModel;
    if (cachedUser != null) userModel = UserModel.fromJson(cachedUser.fromStringToJson);
    return userModel;
  }
}
