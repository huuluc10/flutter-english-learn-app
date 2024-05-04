import 'dart:convert';

class ExamResponse {
  int examId;
  int topicId;
  String examName;
  int examExperience;
  String examLevel;
  double examResult;
  int examTimeWithSecond;

  ExamResponse({
    required this.examId,
    required this.topicId,
    required this.examName,
    required this.examExperience,
    required this.examLevel,
    required this.examResult,
    required this.examTimeWithSecond,
  });

  factory ExamResponse.fromMap(Map<String, dynamic> map) {
    return ExamResponse(
      examId: map['examId'] as int,
      topicId: map['topicId'] as int,
      examName: map['examName'] as String,
      examExperience: map['examExperience'] as int,
      examLevel: map['level'] as String,
      examResult: map['examResult'] as double,
      examTimeWithSecond: map['examTimeWithSecond'] as int,
    );
  }

  factory ExamResponse.fromJson(String source) =>
      ExamResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
