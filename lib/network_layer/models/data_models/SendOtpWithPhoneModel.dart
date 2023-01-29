import 'package:yallabaity/domain/entities/requests_entites/favourite_entity.dart';
import 'package:yallabaity/domain/entities/requests_entites/send_otp_entity.dart';
class SendOtpModel extends SendOtpEntity {
  SendOtpModel({
    int? userPhone
  }) : super(
      userPhone: userPhone
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userPhone'] = userPhone;
    return data;
  }
  toEntity()=>this;
}