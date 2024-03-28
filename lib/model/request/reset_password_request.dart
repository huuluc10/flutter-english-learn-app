import 'dart:convert';

class ResetPasswordRequest {
  String email;
  String newPassword;

  ResetPasswordRequest({
    required this.email,
    required this.newPassword,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': newPassword,
    };
  }

  String toJson() => json.encode(toMap());
}
