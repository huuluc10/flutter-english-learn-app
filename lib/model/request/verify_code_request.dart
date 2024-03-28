import 'dart:convert';

class VerifyCodeRequest {
  String email;
  String code;

  VerifyCodeRequest({
    required this.email,
    required this.code,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'code': code,
    };
  }

  String toJson() => json.encode(toMap());
}
