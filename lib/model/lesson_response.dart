// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LessonResponse {
  int lessonId;
  String lessonName;
  int topicId;
  int content;
  int lessonExperience;
  int levelId;
  String completed;
  String contentURL;
  String levelName;

  LessonResponse({
    required this.lessonId,
    required this.lessonName,
    required this.topicId,
    required this.content,
    required this.lessonExperience,
    required this.levelId,
    required this.completed,
    required this.contentURL,
    required this.levelName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lessonId': lessonId,
      'lessonName': lessonName,
      'topicId': topicId,
      'content': content,
      'lessonExperience': lessonExperience,
      'levelId': levelId,
      'completed': completed,
      'contentURL': contentURL,
      'levelName': levelName,
    };
  }

  factory LessonResponse.fromMap(Map<String, dynamic> map) {
    return LessonResponse(
      lessonId: map['lessonId'] as int,
      lessonName: map['lessonName'] as String,
      topicId: map['topicId'] as int,
      content: map['content'] as int,
      lessonExperience: map['lessonExperience'] as int,
      levelId: map['levelId'] as int,
      completed: map['completed'] as String,
      contentURL: map['contentURL'] as String,
      levelName: map['levelName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LessonResponse.fromJson(String source) =>
      LessonResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
