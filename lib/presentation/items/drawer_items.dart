import 'package:yallabaity/network_layer/models/item_model.dart';
import 'package:yallabaity/presentation/resources/assets_manager.dart';

import '../../presentation/resources/strings_manager.dart';

class DrawerItems {
  static ItemModel home = ItemModel(
      title: AppStrings.home, icon: AssetsManager.home);
  static ItemModel language = ItemModel(
      title: AppStrings.language,
      icon: AssetsManager.language);
  static ItemModel addFood = ItemModel(
      title: AppStrings.addFood, icon: AssetsManager.add);
  static ItemModel categories = ItemModel(
      title: AppStrings.categories,
      icon: AssetsManager.categories);
  static ItemModel profile =
      ItemModel(title: AppStrings.myProfile, icon: AssetsManager.profile);
  static ItemModel aboutUs =
      ItemModel(title: AppStrings.aboutUs, icon: AssetsManager.aboutUs);
  static ItemModel privacyAndPolicy = ItemModel(
      title: AppStrings.privacy, icon: AssetsManager.privacyAndPolicy);
  static ItemModel helpAndSupport = ItemModel(
      title: AppStrings.helpAndSupport, icon: AssetsManager.privacyAndPolicy);
  static ItemModel saved =
      ItemModel(title: AppStrings.saved, icon: AssetsManager.favourite);
/*
  static ItemModel settings =
      ItemModel(title: AppStrings.settings, icon: AssetsManager.settings);
*/

  static List<ItemModel> all = [
    addFood,
    profile,
    categories,
    saved,
    helpAndSupport,
    aboutUs,
    privacyAndPolicy,
    language,
  ];
}
