// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Question {
  int questionId;
  String questionContent;
  String questionType;
  int lessonId;
  String answerUrl;
  Question({
    required this.questionId,
    required this.questionContent,
    required this.questionType,
    required this.lessonId,
    required this.answerUrl,
  });

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      questionId: map['questionId'] as int,
      questionContent: map['questionContent'] as String,
      questionType: map['questionType'] as String,
      lessonId: map['lessonId'] as int,
      answerUrl: map['answerUrl'] as String,
    );
  }

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source) as Map<String, dynamic>);
}
