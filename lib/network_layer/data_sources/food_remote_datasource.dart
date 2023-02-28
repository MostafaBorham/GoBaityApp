import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:yallabaity/application/app_api_constants/api_constants.dart';
import 'package:yallabaity/application/app_failures/exception.dart';
/*
import 'package:yallabaity/network_layer/models/foods/food_post_model.dart';
*/
import 'package:http/http.dart' as http;
import 'package:yallabaity/application/extensions.dart';
import 'package:yallabaity/network_layer/models/data_models/food_model.dart';
import 'package:yallabaity/network_layer/models/data_models/food_post_model.dart';
import 'package:yallabaity/network_layer/models/data_models/foods_get_params_model.dart';
import 'package:yallabaity/network_layer/models/responses_model/food_view_and_order_response_model.dart';
import 'package:yallabaity/network_layer/models/responses_model/foods_response_model.dart';
import 'package:yallabaity/network_layer/services/network_services.dart';

import '../models/data_models/cook_get_params_model.dart';
import '../models/responses_model/cook_foods_response_model.dart';
import '../models/responses_model/response_model.dart';

abstract class FoodsRemoteDataSource {
  Future<ResponseModel> addFood(FoodPostModel food);
  Future<ResponseModel> updateFood(FoodModel food);

  Future<ResponseModel> deleteFood(int id);
  Future<FoodViewAndOrderResponseModel> getFood(int id);
  Future<FoodsResponseModel> getAll(
      {required FoodsGetParamsModel foodsGetParams});
  Future<CookFoodsResponseModel> getCookFoods(
      {required CookGetParamsModel cookGetParams});
}

class FoodRemoteWithHttp extends FoodsRemoteDataSource {
  final NetworkService networkService;
  FoodRemoteWithHttp({required this.networkService});
  @override
  Future<ResponseModel> addFood(FoodPostModel food) async {
/*    foodsService.addFood(
        entity: ApiConstants.foodsEntity + ApiConstants.add, food: food);*/
    Uri uri = Uri.https(
        ApiConstants.baseUrl, ApiConstants.foodsEntity, {'lang': 'en'});
    http.MultipartRequest request = http.MultipartRequest('Post', uri);
    debugPrint(uri.toString());
    await food.toMultiPart(request);
    final http.StreamedResponse response = await request.send();
    if (response.statusCode == ApiConstants.success) {
      String body = String.fromCharCodes(await response.stream.toBytes());
      debugPrint(body);
      ResponseModel responseModel =
          ResponseModel.fromJson(body.fromStringToJson);
      return responseModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ResponseModel> deleteFood(int id) async {
    // TODO: implement deleteFood
/*    http.Response response = await client.delete(
        Uri.https('${ApiConstants.foodsEntity}/$id'),
        headers: {'content-type': 'application-json'});
    if (response.statusCode == 200) {
      return unit;
    } else {
      throw ServerException();
    }*/
    throw Exception();
  }

  @override
  Future<FoodsResponseModel> getAll(
      {required FoodsGetParamsModel foodsGetParams}) async {
    try {
      Map<String, dynamic> foodsString = await networkService.get(
          api: ApiConstants.foodsEntity, queryParams: foodsGetParams.toJson());
      FoodsResponseModel foodsResponse =
          FoodsResponseModel.fromJson(foodsString);
      return foodsResponse;
    } on ServerException {
      throw ServerException();
    } on InvalidRequestException {
      throw InvalidRequestException();
    }
  }

  @override
  Future<ResponseModel> updateFood(FoodModel food) async {
/*    http.Response response = await client.patch(
        Uri.https(ApiConstants.foodsEntity + '${food.foodId}'),
        headers: {'content-type': 'application-json'},
        body: food.toJson());
    if (response.statusCode == 200) {
      return unit;
    } else {
      throw ServerException();
    }*/
    throw UnimplementedError();
  }

  @override
  Future<FoodViewAndOrderResponseModel> getFood(int id) async {
    try {
      Map<String, dynamic> foodsString =
          await networkService.get(api: "${ApiConstants.foodsEntity}/$id");
      FoodViewAndOrderResponseModel foodResponse =
          FoodViewAndOrderResponseModel.fromJson(foodsString);
      return foodResponse;
    } on ServerException {
      throw ServerException();
    } on InvalidRequestException {
      throw InvalidRequestException();
    }
  }

  @override
  Future<CookFoodsResponseModel> getCookFoods(
      {required CookGetParamsModel cookGetParams}) async {
    try {
      Map<String, dynamic> cookFoodsString = await networkService.get(
          api: ApiConstants.providerEntity,
          queryParams: cookGetParams.toJson());
      CookFoodsResponseModel cookFoodsResponse =
          CookFoodsResponseModel.fromJson(cookFoodsString);
      return cookFoodsResponse;
    } on ServerException {
      throw ServerException();
    } on InvalidRequestException {
      throw InvalidRequestException();
    }
  }
}
