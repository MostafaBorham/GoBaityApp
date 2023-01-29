import 'package:yallabaity/presentation/resources/strings_manager.dart';

enum AppErrors {
  noErrors,
  images,
  title,
  street,
  buildingName,
  floor,
  apartmentNumber,
  description,
  sizes,
  price,
  tags,
  name,
  phoneInvalid,
  phoneEmpty,
  password,
  pinCodeEmpty,
  pinCodeInvalid,
  pinCodeNotMatch,


}

 Map<AppErrors, String> appErrorMessages = {
  AppErrors.noErrors: '',
  AppErrors.street: AppStrings.translate(AppStrings.streetError),
  AppErrors.buildingName: AppStrings.translate(AppStrings.buildingNameError),
  AppErrors.floor: AppStrings.translate(AppStrings.floorError),
  AppErrors.apartmentNumber: AppStrings.translate(AppStrings.apartmentNumberError),
  AppErrors.images: AppStrings.translate(AppStrings.imageError),
  AppErrors.title: AppStrings.translate(AppStrings.titleError),
  AppErrors.description: AppStrings.translate(AppStrings.descriptionError),
  AppErrors.tags: AppStrings.translate(AppStrings.tagsError),
  AppErrors.price: AppStrings.translate(AppStrings.priceError),
  AppErrors.name: AppStrings.translate(AppStrings.nameError),
  AppErrors.phoneInvalid: AppStrings.translate(AppStrings.invalidPhoneError),
  AppErrors.phoneEmpty: AppStrings.translate(AppStrings.phoneError),
  AppErrors.password: AppStrings.translate(AppStrings.invalidPasswordError),
  AppErrors.pinCodeEmpty: AppStrings.translate(AppStrings.sentCodeError),
  AppErrors.pinCodeInvalid: AppStrings.translate(AppStrings.invalidPinCodeError),
  AppErrors.pinCodeNotMatch: AppStrings.translate(AppStrings.notMatchPinCodeError),
};
