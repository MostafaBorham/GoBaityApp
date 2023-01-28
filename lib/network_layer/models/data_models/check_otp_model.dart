import 'package:yallabaity/domain/entities/requests_entites/check_otp_entity.dart';
import 'package:yallabaity/domain/entities/requests_entites/favourite_entity.dart';
import 'package:yallabaity/domain/entities/requests_entites/send_otp_entity.dart';
class CheckOtpModel extends CheckOtpEntity {
  CheckOtpModel({
    int? userPhone,
    int? code,
  }) : super(
      userPhone: userPhone,
    code: code
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    return data;
  }
  toEntity()=>this;
}