import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:yallabaity/application/app_api_constants/api_constants.dart';
import 'package:yallabaity/application/app_localization.dart';
import 'package:yallabaity/application/enums/app_languages.dart';
import 'package:yallabaity/application/extensions.dart';
import 'package:yallabaity/application/app_failures/exception.dart';
import 'package:http_parser/src/media_type.dart';
import 'package:yallabaity/application/extensions.dart';

import '../../application/app_failures/exception.dart';
import '../models/responses_model/response_model.dart';

enum RequestType {
  post,
  update,
}

class NetworkService {
  http.Client? client;
  NetworkService({required this.client});

  Future<Map<String, dynamic>> postOrUpdateMultipart(
      {
        RequestType type = RequestType.post,
      String baseUrl = ApiConstants.baseUrl,
      required String entity,
      required Map<String, dynamic> body,
      List<Map<String, dynamic>>? list,
      List<String>? images,
      Map<String, String>? query,
      AppLanguages language = AppLanguages.english}) async {
    String api = entity;
    Uri uri = Uri.https(
      ApiConstants.baseUrl,
      api,
    );
    debugPrint(uri.toString());
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'charset': 'utf-8',
      'Accept-Language': AppLocalization.apiLocaleCode
    };
    http.MultipartRequest request = http.MultipartRequest(type == RequestType.update ? 'PUT' : 'POST', uri);
    request.headers.addAll(header);
    debugPrint(uri.toString());
    for (String key in body.keys) {
      if (body[key] != null) {
        request.fields[key] = body[key]! is String ? body[key]! : body[key]!.toString();
      }
    }

    /* for (String key in body.keys) {
      request.fields[key] = jsonEncode(body[key]);
    }*/
/*    if (list != null) {
      for (Map<String, dynamic> item in list) {
        for (String key in item.keys) {
          request.files.add(http.MultipartFile.fromString(key, item[key].fromJsonToString));
        }
      }
    }
    if (images != null) {
      for (int index = 0; index < images.length; index++) {
        request.files.add(await http.MultipartFile.fromPath('images', images[index],
            filename: index.toString(), contentType: MediaType('image', 'jpg')));
      }
    }*/

    final http.StreamedResponse response = await request.send();
   debugPrint('status code+${response.statusCode}');
    if (response.statusCode == ApiConstants.success) {
      String body = String.fromCharCodes(await response.stream.toBytes());
     debugPrint(body);
/*      ResponseModel responseModel = ResponseModel.fromJson(body.fromStringToJson);
      if (responseModel.state!) {
        return body.fromStringToJson;
        throw InvalidRequestException();
      }*/
      return body.fromStringToJson;
    } else {
      throw ServerException();
    }
  }

  Future<Map<String, dynamic>> postOrUpdate({
    RequestType type = RequestType.post,
    String baseUrl = ApiConstants.baseUrl,
    required String api,
    required Map<String, dynamic> body,
    AppLanguages language = AppLanguages.english,
  }) async {
    Uri uri = Uri.https(
      ApiConstants.baseUrl,
      api,
    );
   debugPrint(uri.toString());
    /* make request */
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'charset': 'utf-8',
      'Accept-Language': AppLocalization.apiLocaleCode
    };
    http.Response response = (type == RequestType.post)
        ? await http.post(uri, body: body.fromJsonToString, headers: header)
        : await http.put(uri, body: body.fromJsonToString, headers: header);
   debugPrint(response.statusCode.toString());
   debugPrint(response.body);
    if (response.statusCode == ApiConstants.success) {
      String body = response.body;
      ResponseModel responseModel = ResponseModel.fromJson(body.fromStringToJson);
      return body.fromStringToJson;
    } else {
      throw ServerException();
    }
  }

  Future<Map<String, dynamic>> get({
    required String api,
    String baseUrl=ApiConstants.baseUrl,
    Map<String, dynamic>? queryParams,
    AppLanguages language = AppLanguages.english,
  }) async {
    Uri  uri = Uri.https(baseUrl, api, queryParams);
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'charset': 'utf-8',
      'Accept-Language': AppLocalization.apiLocaleCode
    };
    http.Response response = await client!.get(uri, headers: header);
    debugPrint(uri.toString());
    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    if (response.statusCode == ApiConstants.success) {
      String body = response.body;
      ResponseModel responseModel = ResponseModel.fromJson(body.fromStringToJson);
      return body.fromStringToJson;
    } else {
      throw ServerException();
    }
  }
}
