import 'dart:convert';

class AnswerQuestionRequest {
  String username;
  int questionId;
  bool isCorrect;

  AnswerQuestionRequest({
    required this.username,
    required this.questionId,
    required this.isCorrect,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'questionId': questionId,
      'isCorrect': isCorrect,
    };
  }

  String toJson() => json.encode(toMap());
}
