import 'dart:convert';

import 'package:flutter_englearn/model/response/user_info_response.dart';

class UpdateInfoRequest {
  String fullName;
  DateTime dateOfBirth;
  bool gender;
  String? email;

  UpdateInfoRequest({
    required this.fullName,
    required this.dateOfBirth,
    required this.gender,
    required this.email,
  });

  UpdateInfoRequest.fromResponse(UserInfoResponse response)
      :
        fullName = response.fullName,
        dateOfBirth = response.dateOfBirth,
        gender = response.gender,
        email = response.email;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'dateOfBirth': dateOfBirth.millisecondsSinceEpoch,
      'gender': gender,
      'email': email,
    };
  }

  String toJson() => json.encode(toMap());
}
