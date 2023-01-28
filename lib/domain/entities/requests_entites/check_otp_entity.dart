

import 'package:yallabaity/network_layer/models/data_models/SendOtpWithPhoneModel.dart';
import 'package:yallabaity/network_layer/models/data_models/favourite_model.dart';

import '../../../network_layer/models/data_models/user_model.dart';

class CheckOtpEntity {
  int? userPhone;
  int? code;

  CheckOtpEntity({
    this.userPhone,
    this.code
  });

  toModel()=>this as SendOtpModel;
}
