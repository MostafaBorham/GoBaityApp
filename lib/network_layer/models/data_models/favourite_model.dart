import 'package:yallabaity/domain/entities/requests_entites/favourite_entity.dart';
class FavouriteModel extends FavouriteEntity {
  FavouriteModel({
    int? userId,
    int? foodId,
  }) : super(
      userId: userId,
    foodId: foodId
  );
  toEntity()=>this;
}