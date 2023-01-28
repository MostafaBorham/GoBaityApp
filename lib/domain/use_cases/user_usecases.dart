import 'package:dartz/dartz.dart';
import 'package:yallabaity/application/app_failures/failures.dart';
import 'package:yallabaity/domain/entities/requests_entites/check_otp_entity.dart';
import 'package:yallabaity/domain/entities/requests_entites/location_entity.dart';
import 'package:yallabaity/domain/entities/requests_entites/send_otp_entity.dart';
import 'package:yallabaity/domain/entities/requests_entites/user_entity.dart';
import 'package:yallabaity/domain/entities/response_entities/address_response_entity.dart';
import 'package:yallabaity/domain/entities/response_entities/categories_response_entity.dart';
import 'package:yallabaity/domain/entities/response_entities/check_otp_response_entity.dart';
import 'package:yallabaity/domain/entities/response_entities/favourite_response_entity.dart';
import 'package:yallabaity/domain/entities/response_entities/send_otp_response_entity.dart';
import 'package:yallabaity/domain/entities/response_entities/user_response_entity.dart';
import 'package:yallabaity/domain/repositories/user_repo.dart';
import 'package:yallabaity/network_layer/models/data_models/address_model.dart';
import 'package:yallabaity/network_layer/models/data_models/favourite_model.dart';
import 'package:yallabaity/network_layer/models/data_models/location_model.dart';
import 'package:yallabaity/network_layer/models/data_models/user_model.dart';

class UserUseCase {
  final UserRepo userRepo;

  const UserUseCase({
    required this.userRepo,
  });
  Future<Either<Failure, UserResponseEntity>> register(UserModel user) async => userRepo.register(user);
  Future<Either<Failure, AddressResponseEntity>> saveUserAddress(AddressModel address) async => userRepo.saveUserAddress(address);
  Future<Either<Failure, SendOtpResponseEntity>> sendOtp(SendOtpEntity sendOtpEntity) async => userRepo.sendOtp(sendOtpEntity);
  Future<Either<Failure, CheckOtpResponseEntity>> checkOtp(CheckOtpEntity checkOtpEntity) async => userRepo.checkOtp(checkOtpEntity);
  Future<Either<Failure, FavouriteResponseEntity>> addToFavourites(FavouriteModel favourite) async => userRepo.addToFavourites(favourite);
  Future<Either<Failure, UserResponseEntity>> login({required String phone, required String password}) async =>
      userRepo.login(phone: phone, password: password);
  Future<Either<Unit, UserEntity>> getUser() async => userRepo.getUser();

  Future<Either<Failure, UserResponseEntity>> updateLocation(LocationModel location) async => userRepo.updateLocation(location);
  /* Future<Either<Failure, CategoriesResponseEntity>> getUserCategories(int) async =>
      userRepo.getUserCategories();*/

}
