import 'dart:convert';

class UpdateInfoRequest {
  String username;
  String fullName;
  DateTime dateOfBirth;
  bool gender;
  String email;

  UpdateInfoRequest({
    required this.username,
    required this.fullName,
    required this.dateOfBirth,
    required this.gender,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'fullName': fullName,
      'dateOfBirth': dateOfBirth.millisecondsSinceEpoch,
      'gender': gender,
      'email': email,
    };
  }

  String toJson() => json.encode(toMap());
}
