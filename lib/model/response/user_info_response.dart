// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_englearn/model/response/main_user_info_request.dart';

class UserInfoResponse extends MainUserInfoResponse {
  bool gender;
  DateTime dateOfBirth;
  String? email;
  

  UserInfoResponse({
    required super.username,
    required this.gender,
    required super.urlAvatar,
    required super.streak,
    required super.experience,
    required super.fullName,
    required this.dateOfBirth,
    required this.email,
    required super.level,
  });

  factory UserInfoResponse.fromMap(Map<String, dynamic> map) {
    return UserInfoResponse(
      username: map['username'] as String,
      gender: map['gender'] as bool,
      urlAvatar: map['urlAvatar'] as String,
      streak: int.parse(map['streak'].toString()),
      experience: int.parse(map['experience'].toString()),
      fullName: map['fullName'] as String,
      dateOfBirth: DateTime.parse(map['dateOfBirth']),
      email: map['email'] ?? '',
      level: map['level'] as String,
    );
  }

  factory UserInfoResponse.fromJson(String source) =>
      UserInfoResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
