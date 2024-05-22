import 'dart:convert';

class AnswerQuestionRequest {
  int questionId;
  bool isCorrect;
  String makeFor;

  AnswerQuestionRequest({
    required this.questionId,
    required this.isCorrect,
    this.makeFor = 'LESSON',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'questionId': questionId,
      'correct': isCorrect,
      'makeFor': makeFor,
    };
  }

  String toJson() => json.encode(toMap());
}
