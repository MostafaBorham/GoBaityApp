part of 'cubit_user.dart';

@immutable
abstract class UserState {
  const UserState();
}

class UserInitial extends UserState {}
/// register states
class UserRegisteringState extends UserState {}
class UserRegisteredState extends UserState {
  final UserResponseEntity userResponseEntity;
  const UserRegisteredState({
    required this.userResponseEntity,
  });
}
class RegisteringUserFailedState extends UserState {
  final String message;

  const RegisteringUserFailedState({
    required this.message,
  });
}

///login states
class UserLoginingState extends UserState {}
class UserLoggedInState extends UserState{
  final UserResponseEntity userResponseEntity;
  const UserLoggedInState(this.userResponseEntity);
}
class LoginUserFailedState extends UserState {
  final String message;

  const LoginUserFailedState({
    required this.message,
  });
}

///check user states
class NewUserState extends UserState {}
class AlreadyLoggedInState extends UserState {
  final UserModel user;

  const AlreadyLoggedInState({
    required this.user,
  });
}

///user location states
class UpdatingUserLocation extends UserState {
  final String message;
  const UpdatingUserLocation({required this.message});
}
class UpdatedUserLocation extends UserState {
  final UserResponseEntity userResponseEntity;
  const UpdatedUserLocation({required this.userResponseEntity});
}
class UpdatingUserLocationFailed extends UserState {
  final String message;

  const UpdatingUserLocationFailed({required this.message});
}

///save user address states
class UserSavingAddressState extends UserState {}
class UserSavedAddressState extends UserState {
  final AddressResponseEntity addressResponseEntity;
  const UserSavedAddressState({
    required this.addressResponseEntity,
  });
}
class UserFailedSaveAddressState extends UserState {
  final String message;

  const UserFailedSaveAddressState({
    required this.message,
  });
}

///add to favourites states
class AddingToFavouritesState extends UserState {}
class AddedToFavouritesState extends UserState {
  final FavouriteResponseEntity favouriteResponseEntity;
  const AddedToFavouritesState({
    required this.favouriteResponseEntity,
  });
}
class FailedAddToFavouritesState extends UserState {
  final String message;

  const FailedAddToFavouritesState({
    required this.message,
  });
}

///send otp states
class SendingOtpState extends UserState {}
class SendedOtpState extends UserState {
  final SendOtpResponseEntity sendOtpResponseEntity;
  const SendedOtpState({
    required this.sendOtpResponseEntity,
  });
}
class FailedSendOtpState extends UserState {
  final String message;

  const FailedSendOtpState({
    required this.message,
  });
}

///send otp states
class CheckingOtpState extends UserState {}
class CheckedOtpState extends UserState {
  final CheckOtpResponseEntity checkOtpResponseEntity;
  const CheckedOtpState({
    required this.checkOtpResponseEntity,
  });
}
class FailedCheckOtpState extends UserState {
  final String message;

  const FailedCheckOtpState({
    required this.message,
  });
}