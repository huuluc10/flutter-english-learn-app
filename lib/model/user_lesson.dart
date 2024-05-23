// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserLesson {
  int lessonId;
  DateTime dateLearned;

  UserLesson({
    required this.lessonId,
    required this.dateLearned,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lessonId': lessonId,
      'dateLearned': dateLearned.millisecondsSinceEpoch,
    };
  }

  String toJson() => json.encode(toMap());
}
