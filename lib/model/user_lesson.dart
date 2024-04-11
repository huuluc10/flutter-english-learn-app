// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserLesson {
  String username;
  int lessonId;
  DateTime dateLearned;

  UserLesson({
    required this.username,
    required this.lessonId,
    required this.dateLearned,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'lessonId': lessonId,
      'dateLearned': dateLearned.millisecondsSinceEpoch,
    };
  }

  String toJson() => json.encode(toMap());
}
