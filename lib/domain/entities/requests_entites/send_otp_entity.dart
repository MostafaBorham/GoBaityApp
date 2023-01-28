

import 'package:yallabaity/network_layer/models/data_models/SendOtpWithPhoneModel.dart';
import 'package:yallabaity/network_layer/models/data_models/favourite_model.dart';

import '../../../network_layer/models/data_models/user_model.dart';

class SendOtpEntity {
  int? userPhone;

  SendOtpEntity({
    this.userPhone
  });

  toModel()=>this as SendOtpModel;
}
