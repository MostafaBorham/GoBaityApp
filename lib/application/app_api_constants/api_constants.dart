class ApiConstants {
  ApiConstants._internal();
  static const int success = 200;
  static const String fullUrl = 'https://yallabety.azurewebsites.net';
  static const String baseUrl = 'yallabety.azurewebsites.net';
  static const String api='/api/';
  static const String googleApisUrl= 'maps.googleapis.com';
  static const String placesAutoCompleteEntity= 'maps/api/place/autocomplete/json';
  static const String googleApiKey= "AIzaSyCyZZrPNBurhaJpstx3RWRGC6QwBVM_Qos";
  static const String subUsersEntity = '/UsersAddreses';
  static const String foodsEntity = '${api}foods';
  static const String citiesEntity = '${api}Governorates';
  static const String loginSubEntity = 'Login';
  static const String categoriesEntity = '${api}categories';
  static const String sizesEntity = '${api}sizes';
  static const String likeEntity = 'like';
  static const String adsEntity = '${api}ads';
  static const String usersEntity = '${api}Users';
  static const String basketEntity = '/Baskets/Single';
  static const String providerEntity = '${api}Foods/Provider';
  static const String locationSubEntity = 'UpdateLatLng';
  static const String userCategoriesEntity = '${api}Categories/GetUsedByProvider';
  static const String googleMapsBaseUrl = 'maps.googleapis.com';
  static const String googleMapsAutoCompleteApi = '/maps/api/place/autocomplete/json';
  static const String favouriteEntity = '/favorite/';
  static const String sendOtpEntity = '/SendOTP';
  static const String checkOtpEntity = 'CheckOTP/';
}
