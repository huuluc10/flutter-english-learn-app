import 'dart:convert';

class ChangePasswordRequest {
  String username;
  String oldPassword;
  String newPassword;

  ChangePasswordRequest({
    required this.username,
    required this.oldPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    };
  }

  String toJson() => json.encode(toMap());
}
