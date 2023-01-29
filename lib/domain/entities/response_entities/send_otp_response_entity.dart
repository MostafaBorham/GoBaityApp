import 'package:yallabaity/domain/entities/requests_entites/user_entity.dart';
import 'package:yallabaity/domain/entities/response_entities/response_entity.dart';

class SendOtpResponseEntity extends ResponseEntity{
  int? data;
  SendOtpResponseEntity({bool? state, String? message,this.data})
      : super(state: state, message: message);
}