import 'package:yallabaity/domain/entities/requests_entites/user_entity.dart';
import 'package:http/http.dart' as http;
class UserModel extends UserEntity {
  UserModel({
    int? userId,
    String? userName,
    String? password,
    String? phone,
    String? image,
    bool? isProvider,
    String? address,
    int? governorateId,
    double? latitude,
    double? longitude,
    String? nationalIdcardFace,
    String? nationalIdcardBack,
    bool? isApproved,
    bool? isActive,
    bool? isDelete,
    String? governorate,

  }) : super(
            userId: userId,
            userName: userName,
            password: password,
            phone: phone,
            isProvider: isProvider,
            governorateId: governorateId,
            latitude: latitude,
            longitude: longitude,
            nationalIdcardFace: nationalIdcardFace,
            nationalIdcardBack: nationalIdcardBack,
            isApproved: isApproved,
            isActive: isActive,
            governorate: governorate,
            image: image,
            address: address,
            isDelete: isDelete);

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['UserName'];
    password = json['Password'];
    phone = json['Phone'];
    image = json['image'];
    isProvider = json['isProvider'];
    address = json['address'];
    governorateId = json['governorateId'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    nationalIdcardFace = json['nationalIdcardFace'];
    nationalIdcardBack = json['nationalIdcardBack'];
    isApproved = json['isApproved'];
    isActive = json['isActive'];
    isDelete = json['isDelete'];
    governorate = json['governorate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['UserName'] = userName;
    data['Password'] = password;
    data['Phone'] = phone;
    data['image'] = image;
    data['isProvider'] = isProvider;
    data['address'] = address;
    data['governorateId'] = governorateId;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['nationalIdcardFace'] = nationalIdcardFace;
    data['nationalIdcardBack'] = nationalIdcardBack;
    data['isApproved'] = isApproved;
    data['isActive'] = isActive;
    data['isDelete'] = isDelete;
    data['governorate'] = governorate;
    return data;
  }
  toMultiPart(http.MultipartRequest request)  {
    request.fields['UserId'] = userId!.toString();
    request.fields['UserName'] = userName!;
    request.fields['Password'] = password!;
    request.fields['Phone'] = phone!;
  }
  toEntity()=>this;
}

