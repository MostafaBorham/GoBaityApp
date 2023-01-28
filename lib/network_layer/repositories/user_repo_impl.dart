import 'package:dartz/dartz.dart';
import 'package:yallabaity/application/types.dart';
import 'package:yallabaity/application/app_failures/exception.dart';
import 'package:yallabaity/application/app_failures/failures.dart';
import 'package:yallabaity/application/network.dart';
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
import 'package:yallabaity/domain/repositories/user_repo.dart';
import 'package:yallabaity/network_layer/data_sources/user_local_datasource.dart';
import 'package:yallabaity/network_layer/data_sources/user_remote_datasource.dart';
import 'package:yallabaity/network_layer/models/data_models/address_model.dart';
import 'package:yallabaity/network_layer/models/data_models/location_model.dart';
import 'package:yallabaity/network_layer/models/data_models/user_model.dart';
import 'package:yallabaity/network_layer/models/responses_model/address_response_model.dart';
import 'package:yallabaity/network_layer/models/responses_model/check_otp_response_model.dart';
import 'package:yallabaity/network_layer/models/responses_model/favourite_response_model.dart';
import 'package:yallabaity/network_layer/models/responses_model/send_otp_with_phone_response_model.dart';
import 'package:yallabaity/network_layer/models/responses_model/user_response_model.dart';

import '../../domain/entities/requests_entites/user_entity.dart';

class UserRepoImpl extends UserRepo {
  final UserRemoteDataSource userRemoteDataSource;
  final UserLocalDataSource userLocalDataSource;
  final NetworkStatus networkStatus;
  UserRepoImpl({
    required this.userRemoteDataSource,
    required this.userLocalDataSource,
    required this.networkStatus,
  });

  @override
  Future<Either<Failure, UserResponseEntity>> register(UserEntity user) async {
    if (await networkStatus.isConnected) {
      try {
        UserResponseModel userResponseModel = await userRemoteDataSource.register(user.toModel());
        userLocalDataSource.cacheUser(userResponseModel.data);
        return Right(userResponseModel);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(OfflineFailure());
  }
  @override
  Future<Either<Failure, AddressResponseEntity>> saveUserAddress(AddressEntity address) async {
    if (await networkStatus.isConnected) {
      try {
        AddressResponseModel addressResponseModel = await userRemoteDataSource.saveUserAddress(address.toModel());
        if (addressResponseModel.state == true) {
          userLocalDataSource.cacheUserAddress(addressResponseModel.data);
          return Right(addressResponseModel);
        } else {
          throw left(InvalidRequestFailure());
        }
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(OfflineFailure());
  }

  @override
  Future<Either<Failure, UserResponseEntity>> updateLocation(LocationModel location) async {
    if (await networkStatus.isConnected) {
      try {
        UserResponseModel userResponseModel =
            await userRemoteDataSource.updateLocation(location, (userLocalDataSource.getCachedUser()).userId!);
        userLocalDataSource.cacheUser(userResponseModel.data);
        return Right(userResponseModel);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(OfflineFailure());
  }

  @override
  Future<Either<Unit, UserEntity>> getUser() async {
    try {
      UserModel user = userLocalDataSource.getCachedUser();
      return Right(user);
    } on EmptyCashException {
      return const Left(unit);
    }
  }

  @override
  Future<Either<Failure, CategoriesResponseEntity>> getUserCategories() {
    // TODO: implement getUserCategories
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserResponseEntity>> login({required String phone, required String password}) async {
    if (await networkStatus.isConnected) {
      try {
        UserResponseModel userResponseModel = await userRemoteDataSource.login(password: password, phone: phone);
        userLocalDataSource.cacheUser(userResponseModel.data);
        return Right(userResponseModel);
      } on ServerException {
        return Left(ServerFailure());
      }on InvalidRequestException{
        return Left(InvalidRequestFailure());
      }
    }
    return Left(OfflineFailure());
  }

  @override
  Future<Either<Failure, FavouriteResponseEntity>> addToFavourites(FavouriteEntity favourite) async{
    if (await networkStatus.isConnected) {
      try {
        FavouriteResponseModel favouriteResponseModel = await userRemoteDataSource.addToFavourites(favourite.toModel());
        if (favouriteResponseModel.state == true) {
          //userLocalDataSource.cacheUserAddress(favouriteResponseModel.data);
          return Right(favouriteResponseModel);
        } else {
          throw left(InvalidRequestFailure());
        }
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(OfflineFailure());
  }

  @override
  Future<Either<Failure, SendOtpResponseEntity>> sendOtp(SendOtpEntity sendOtpEntity) async{
    if (await networkStatus.isConnected) {
      try {
        SendOtpResponseModel sendOtpResponseModel = await userRemoteDataSource.sendOtp(sendOtpEntity.toModel());
        return Right(sendOtpResponseModel);
      } on ServerException {
        return Left(ServerFailure());
      }
      on InvalidRequestException {
        return Left(InvalidRequestFailure());
      }
    }
    return Left(OfflineFailure());
  }

  @override
  Future<Either<Failure, CheckOtpResponseEntity>> checkOtp(CheckOtpEntity checkOtpEntity) async{
    if (await networkStatus.isConnected) {
      try {
        CheckOtpResponseModel checkOtpResponseModel = await userRemoteDataSource.checkOtp(checkOtpEntity.toModel());
        return Right(checkOtpResponseModel);
      } on ServerException {
        return Left(ServerFailure());
      }
      on InvalidRequestException {
        return Left(InvalidRequestFailure());
      }
    }
    return Left(OfflineFailure());
  }
}
