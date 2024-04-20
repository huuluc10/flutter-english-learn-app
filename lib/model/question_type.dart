import 'dart:convert';

class QuestionType {
  int questionTypeId;

  String questionTypeName;
  QuestionType({
    required this.questionTypeId,
    required this.questionTypeName,
  });

  factory QuestionType.fromMap(Map<String, dynamic> map) {
    return QuestionType(
      questionTypeId: map['questionTypeId'] as int,
      questionTypeName: map['questionTypeName'] as String,
    );
  }

  factory QuestionType.fromJson(String source) =>
      QuestionType.fromMap(json.decode(source) as Map<String, dynamic>);
}
