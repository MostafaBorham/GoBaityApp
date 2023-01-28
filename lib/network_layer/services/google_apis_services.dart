import 'package:yallabaity/application/app_api_constants/api_constants.dart';
import 'package:yallabaity/application/app_constants/app_constants.dart';

import 'network_services.dart';

class GoogleApisServices {
  final NetworkService networkService;
  GoogleApisServices({required this.networkService});
  /*https://developers.google.com/maps/documentation/places/web-service/autocomplete*/
  findPlaces({required String placeName}) async {
    /* String autoCompleteApi =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&location=37.76999%2C-122.44696&radius=500&types=establishment&key=${ApiConstants.googleApiKey}';
  */
/*    String autoCompleteApi =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=${ApiConstants.googleApiKey}';*/
    Map<String, dynamic> queryParameters = {'input': placeName, 'key': ApiConstants.googleApiKey};
    if (placeName.length > 1) {
      Map<String, dynamic> response = await networkService.get(
        baseUrl: ApiConstants.googleMapsBaseUrl,
        api: ApiConstants.googleMapsAutoCompleteApi,
        queryParams: queryParameters,
      );
    }
  }
}
