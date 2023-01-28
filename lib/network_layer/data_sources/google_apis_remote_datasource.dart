import 'package:dartz/dartz.dart';

import '../../application/app_api_constants/api_constants.dart';
import '../../application/app_failures/exception.dart';
import '../services/network_services.dart';

abstract class GoogleApisRemoteDataSource {
  Future<Unit> getPlaces(String placeName);
}

class GoogleApisImplWithHttp extends GoogleApisRemoteDataSource {
  final NetworkService networkService;
  GoogleApisImplWithHttp({required this.networkService});
  @override
  Future<Unit> getPlaces(String placeName) async {
    try {
      if (placeName.length > 1) {
        Map<String, dynamic> queryParameters = {'input': placeName, 'key': ApiConstants.googleApiKey};
        Map<String, dynamic> response = await networkService.get(
          baseUrl: ApiConstants.googleMapsBaseUrl,
          api: ApiConstants.googleMapsAutoCompleteApi,
          queryParams: queryParameters,
        );
      }

      return unit;
    } on ServerException {
      throw ServerException();
    } on InvalidRequestException {
      throw InvalidRequestException();
    }
  }
}
