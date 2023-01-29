

import 'package:yallabaity/network_layer/models/data_models/favourite_model.dart';

import '../../../network_layer/models/data_models/user_model.dart';

class FavouriteEntity {
  int? userId;
  int? foodId;

  FavouriteEntity({
    this.userId,
    this.foodId
  });

  toModel()=>this as FavouriteModel;


}
