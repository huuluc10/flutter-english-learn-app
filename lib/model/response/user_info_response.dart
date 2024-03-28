// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_englearn/model/response/main_user_info_request.dart';

class UserInfoResponse extends MainUserInfoResponse {
  String fullName;
  DateTime dateOfBirth;
  String email;
  String level;

  UserInfoResponse({
    required super.username,
    required super.gender,
    required super.urlAvatar,
    required super.streak,
    required super.experience,
    required this.fullName,
    required this.dateOfBirth,
    required this.email,
    required this.level,
  });

  factory UserInfoResponse.fromMap(Map<String, dynamic> map) {
    return UserInfoResponse(
      username: map['username'] as String,
      gender: map['gender'] as bool,
      urlAvatar: map['urlAvatar'] as String,
      streak: map['streak'] as int,
      experience: map['experience'] as int,
      fullName: map['fullName'] as String,
      dateOfBirth:
          DateTime.fromMillisecondsSinceEpoch(map['dateOfBirth'] as int),
      email: map['email'] as String,
      level: map['level'] as String,
    );
  }

  factory UserInfoResponse.fromJson(String source) =>
      UserInfoResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
