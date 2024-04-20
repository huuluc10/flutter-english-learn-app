import 'dart:convert';

class QuestionResponse {
  int questionTypeId;
  String belongTo;
  int lessonId;
  int examId;
  String answerFileURL;

  QuestionResponse({
    required this.questionTypeId,
    required this.belongTo,
    required this.lessonId,
    required this.examId,
    required this.answerFileURL,
  });

  factory QuestionResponse.fromMap(Map<String, dynamic> map) {
    return QuestionResponse(
      questionTypeId: map['questionTypeId'] as int,
      belongTo: map['belongTo'] as String,
      lessonId: map['lessonId'] ?? 0,
      examId: map['examId'] ?? 0,
      answerFileURL: map['answerFileURL'] as String,
    );
  }

  factory QuestionResponse.fromJson(String source) =>
      QuestionResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
