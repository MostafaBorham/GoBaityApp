import 'package:yallabaity/domain/entities/response_entities/check_otp_response_entity.dart';
import 'package:yallabaity/domain/entities/response_entities/favourite_response_entity.dart';
import 'package:yallabaity/domain/entities/response_entities/send_otp_response_entity.dart';
import 'package:yallabaity/domain/entities/response_entities/user_response_entity.dart';
import 'package:yallabaity/network_layer/models/data_models/SendOtpWithPhoneModel.dart';
import 'package:yallabaity/network_layer/models/data_models/user_model.dart';

class CheckOtpResponseModel extends CheckOtpResponseEntity {
  CheckOtpResponseModel({bool? state, String? message})
      : super(state: state, message: message,);
  CheckOtpResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['state'] = state;
    return data;
  }
}
