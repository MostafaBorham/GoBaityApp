import 'package:yallabaity/domain/entities/response_entities/favourite_response_entity.dart';
import 'package:yallabaity/domain/entities/response_entities/send_otp_response_entity.dart';
import 'package:yallabaity/domain/entities/response_entities/user_response_entity.dart';
import 'package:yallabaity/network_layer/models/data_models/SendOtpWithPhoneModel.dart';
import 'package:yallabaity/network_layer/models/data_models/user_model.dart';

class SendOtpResponseModel extends SendOtpResponseEntity {
  SendOtpResponseModel({bool? state, String? message,int? data})
      : super(state: state, message: message,data: data);
  SendOtpResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    state = json['state'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['state'] = state;
    data['data'] = this.data;
    return data;
  }
}
