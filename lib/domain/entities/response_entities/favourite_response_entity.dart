import 'package:yallabaity/domain/entities/response_entities/response_entity.dart';

class FavouriteResponseEntity extends ResponseEntity{
  bool? data;
  FavouriteResponseEntity({bool? state, String? message, this.data})
      : super(state: state, message: message);
}