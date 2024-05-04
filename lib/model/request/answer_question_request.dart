import 'dart:convert';

class AnswerQuestionRequest {
  int questionId;
  bool isCorrect;

  AnswerQuestionRequest({
    required this.questionId,
    required this.isCorrect,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'questionId': questionId,
      'correct': isCorrect,
    };
  }

  String toJson() => json.encode(toMap());
}
