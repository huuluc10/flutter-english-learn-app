import 'dart:convert';

class MissionResponse {
  int missionId;
  String missionName;
  String missionContent;
  int missionExperience;
  bool isDone;

  MissionResponse({
    required this.missionId,
    required this.missionName,
    required this.missionContent,
    required this.missionExperience,
    required this.isDone,
  });

  factory MissionResponse.fromMap(Map<String, dynamic> map) {
    return MissionResponse(
      missionId: map['missionId'] as int,
      missionName: map['missionName'] as String,
      missionContent: map['missionContent'] as String,
      missionExperience: map['missionExperience'] as int,
      isDone: map['isDone'] as bool,
    );
  }

  factory MissionResponse.fromJson(String source) =>
      MissionResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
