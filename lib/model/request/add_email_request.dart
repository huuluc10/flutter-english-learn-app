// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AddEmailRequest {
  String username;
  String email;

  AddEmailRequest({
    required this.username,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
    };
  }

  String toJson() => json.encode(toMap());
}
