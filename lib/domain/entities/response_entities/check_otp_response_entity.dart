import 'package:yallabaity/domain/entities/requests_entites/user_entity.dart';
import 'package:yallabaity/domain/entities/response_entities/response_entity.dart';

class CheckOtpResponseEntity extends ResponseEntity{
  CheckOtpResponseEntity({bool? state, String? message})
      : super(state: state, message: message);
}