// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class JwtResponse {
  String token;
  String type;
  String username;
  List<String> roles;

  JwtResponse({
    required this.token,
    required this.username,
    required this.type,
    required this.roles,
  });

  factory JwtResponse.fromMap(Map<String, dynamic> map) {
    return JwtResponse(
      token: map['token'] as String,
      type: map['type'] as String,
      username: map['username'] as String,
      roles: List<String>.from((map['roles'] as List<dynamic>)),
    );
  }

  factory JwtResponse.fromJson(String source) =>
      JwtResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  // function check jwt or username or roles is empty
  bool isEmpty() {
    return token.isEmpty || username.isEmpty || roles.isEmpty;
  }

  @override
  String toString() {
    return 'JwtResponse(token: $token, type: $type, username: $username, roles: $roles)';
  }
}
