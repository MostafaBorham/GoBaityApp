import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:yallabaity/application/app_api_constants/api_constants.dart';
import 'package:yallabaity/application/extensions.dart';
import 'package:yallabaity/application/app_failures/exception.dart';
import 'package:yallabaity/network_layer/models/data_models/SendOtpWithPhoneModel.dart';
import 'package:yallabaity/network_layer/models/data_models/address_model.dart';
import 'package:yallabaity/network_layer/models/data_models/check_otp_model.dart';
import 'package:yallabaity/network_layer/models/data_models/favourite_model.dart';
import 'package:yallabaity/network_layer/models/data_models/location_model.dart';
import 'package:yallabaity/network_layer/models/data_models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:yallabaity/network_layer/models/responses_model/address_response_model.dart';
import 'package:yallabaity/network_layer/models/responses_model/categories_response_model.dart';
import 'package:yallabaity/network_layer/models/responses_model/check_otp_response_model.dart';
import 'package:yallabaity/network_layer/models/responses_model/favourite_response_model.dart';
import 'package:yallabaity/network_layer/models/responses_model/send_otp_with_phone_response_model.dart';
import 'package:yallabaity/network_layer/models/responses_model/user_response_model.dart';
import 'package:yallabaity/network_layer/services/network_services.dart';

abstract class UserRemoteDataSource {
  Future<UserResponseModel> register(UserModel user);
  Future<FavouriteResponseModel> addToFavourites(FavouriteModel favourite);
  Future<SendOtpResponseModel> sendOtp(SendOtpModel otpModel);
  Future<CheckOtpResponseModel> checkOtp(CheckOtpModel checkOtpModel);
  Future<AddressResponseModel> saveUserAddress(AddressModel address);
  Future<UserResponseModel> updateLocation(LocationModel location, int userId);
  Future<UserResponseModel> login({required String phone, required String password});
}

class UserImplWithHttp extends UserRemoteDataSource {
  final NetworkService networkService;
  UserImplWithHttp({required this.networkService});
  @override
  Future<UserResponseModel> register(UserModel user) async {
    Map<String, dynamic>? response =
        await networkService.postOrUpdateMultipart(entity: ApiConstants.usersEntity, body: user.toJson());
    return UserResponseModel.fromJson(response);
  }

  @override
  Future<UserResponseModel> updateLocation(LocationModel location, int userId) async {
    Map<String, dynamic> json = location.toJson();
    Map<String, dynamic> response = await networkService.postOrUpdate(
      type: RequestType.update,
      api: '${ApiConstants.usersEntity}/${ApiConstants.locationSubEntity}/${userId.toString()}',
      body: json,
    );
    if (response != null) {
     debugPrint(response.toString());
      return UserResponseModel.fromJson(response);
    }
    throw ServerException();
  }

  @override
  Future<UserResponseModel> login({required String phone, required String password}) async {
    Map<String, dynamic>? response = await networkService.postOrUpdate(
        api: '${ApiConstants.usersEntity}/${ApiConstants.loginSubEntity}', body: {'phone': phone, 'password': password});
    return UserResponseModel.fromJson(response);
  }

  @override
  Future<AddressResponseModel> saveUserAddress(AddressModel address) async{
    Map<String, dynamic>? response =
        await networkService.postOrUpdate(api: '${ApiConstants.usersEntity}${address.userId}${ApiConstants.subUsersEntity}',body: address.toJson(),);
    return AddressResponseModel.fromJson(response!);
  }

  @override
  Future<FavouriteResponseModel> addToFavourites(FavouriteModel favourite) async{
    Map<String, dynamic>? response =
        await networkService.postOrUpdate(api: '${ApiConstants.usersEntity}${favourite.userId}${ApiConstants.favouriteEntity}${favourite.foodId}',body: {});
    return FavouriteResponseModel.fromJson(response);
  }

  @override
  Future<SendOtpResponseModel> sendOtp(SendOtpModel otpModel) async{
    Map<String, dynamic>? response =
    await networkService.postOrUpdate(api: '${ApiConstants.usersEntity}${ApiConstants.sendOtpEntity}',body: otpModel.toJson());
    return SendOtpResponseModel.fromJson(response);
  }

  @override
  Future<CheckOtpResponseModel> checkOtp(CheckOtpModel checkOtpModel) async{
    Map<String, dynamic>? response =
        await networkService.postOrUpdate(api: '${ApiConstants.usersEntity}${ApiConstants.checkOtpEntity}${checkOtpModel.userPhone}',body: checkOtpModel.toJson());
    return CheckOtpResponseModel.fromJson(response);
  }
}
