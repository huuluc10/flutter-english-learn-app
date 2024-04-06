import 'dart:convert';

class MainUserInfoResponse {
  String username;
 
  String urlAvatar;
  int streak;
  int experience;

  MainUserInfoResponse({
    required this.username,
    required this.urlAvatar,
    required this.streak,
    required this.experience,
  });

  factory MainUserInfoResponse.fromMap(Map<String, dynamic> map) {
    return MainUserInfoResponse(
      username: map['username'] as String,
      urlAvatar: map['urlAvatar'] as String,
      streak: int.parse(map['streak'].toString()),
      experience: int.parse(map['experience'].toString()),
    );
  }

  factory MainUserInfoResponse.fromJson(String source) =>
      MainUserInfoResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
