// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SignUpRequest {
  String username;
  String password;
  bool gender;
  String fullName;
  DateTime dateOfBirth;
  SignUpRequest({
    required this.username,
    required this.password,
    required this.gender,
    required this.fullName,
    required this.dateOfBirth,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'password': password,
      'gender': gender,
      'fullName': fullName,
      'dateOfBirth': dateOfBirth.millisecondsSinceEpoch,
    };
  }

  String toJson() => json.encode(toMap());
}
