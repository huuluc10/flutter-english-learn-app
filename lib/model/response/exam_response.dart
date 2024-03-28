// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ExamResponse {
  int examId;
  String examName;
  int examExperience;
  int topicId;
  String examLevel;
  double examResult;

  ExamResponse({
    required this.examId,
    required this.examName,
    required this.examExperience,
    required this.topicId,
    required this.examLevel,
    required this.examResult,
  });

  factory ExamResponse.fromMap(Map<String, dynamic> map) {
    return ExamResponse(
      examId: map['examId'] as int,
      examName: map['examName'] as String,
      examExperience: map['examExperience'] as int,
      topicId: map['topicId'] as int,
      examLevel: map['examLevel'] as String,
      examResult: map['examResult'] as double,
    );
  }

  factory ExamResponse.fromJson(String source) =>
      ExamResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
