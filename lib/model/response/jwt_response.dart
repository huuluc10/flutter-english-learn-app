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
      roles: List<String>.from((map['roles'] as List<String>)),
    );
  }

  factory JwtResponse.fromJson(String source) =>
      JwtResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
