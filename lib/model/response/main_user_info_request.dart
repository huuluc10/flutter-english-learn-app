import 'dart:convert';

class MainUserInfoResponse {
  String username;
  String fullName;
  String urlAvatar;
  int streak;
  int experience;
  String level;

  MainUserInfoResponse({
    required this.username,
    required this.fullName,
    required this.urlAvatar,
    required this.streak,
    required this.experience,
    required this.level,
  });

  factory MainUserInfoResponse.fromMap(Map<String, dynamic> map) {
    return MainUserInfoResponse(
      username: map['username'] as String,
      fullName: map['fullName'] as String,
      urlAvatar: map['urlAvatar'] as String,
      streak: int.parse(map['streak'].toString()),
      experience: int.parse(map['experience'].toString()),
      level: map['level'] as String,
    );
  }

  factory MainUserInfoResponse.fromJson(String source) =>
      MainUserInfoResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
