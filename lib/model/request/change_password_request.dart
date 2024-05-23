import 'dart:convert';

class ChangePasswordRequest {
  String oldPassword;
  String newPassword;

  ChangePasswordRequest({
    required this.oldPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    };
  }

  String toJson() => json.encode(toMap());
}
