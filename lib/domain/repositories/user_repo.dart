import 'package:dartz/dartz.dart';
import 'package:yallabaity/application/app_failures/failures.dart';
import 'package:yallabaity/domain/entities/requests_entites/address_entity.dart';
import 'package:yallabaity/domain/entities/requests_entites/check_otp_entity.dart';
import 'package:yallabaity/domain/entities/requests_entites/favourite_entity.dart';
import 'package:yallabaity/domain/entities/requests_entites/send_otp_entity.dart';
import 'package:yallabaity/domain/entities/response_entities/address_response_entity.dart';

import 'package:yallabaity/domain/entities/response_entities/categories_response_entity.dart';
import 'package:yallabaity/domain/entities/response_entities/check_otp_response_entity.dart';
import 'package:yallabaity/domain/entities/response_entities/favourite_response_entity.dart';
import 'package:yallabaity/domain/entities/response_entities/send_otp_response_entity.dart';
import 'package:yallabaity/domain/entities/response_entities/user_response_entity.dart';
import 'package:yallabaity/network_layer/models/data_models/address_model.dart';
import 'package:yallabaity/network_layer/models/data_models/location_model.dart';
import 'package:yallabaity/network_layer/models/data_models/user_model.dart';

import '../entities/requests_entites/user_entity.dart';


abstract class UserRepo {
 // Either<Failure,Unit> login(String phoneName)
  Future<Either<Failure,AddressResponseEntity>> saveUserAddress(AddressEntity address);
  Future<Either<Failure,SendOtpResponseEntity>> sendOtp(SendOtpEntity sendOtpEntity);
  Future<Either<Failure,CheckOtpResponseEntity>> checkOtp(CheckOtpEntity checkOtpEntity);
  Future<Either<Failure,FavouriteResponseEntity>> addToFavourites(FavouriteEntity favourite);
  Future<Either<Failure,UserResponseEntity>> register(UserEntity user);
  Future<Either<Failure,UserResponseEntity>> login({required String phone,required String password});
  Future<Either<Unit,UserEntity>> getUser();
 Future< Either<Failure,CategoriesResponseEntity>> getUserCategories();
  Future<Either<Failure,UserResponseEntity>> updateLocation(LocationModel location);
}