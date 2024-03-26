// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_englearn/model/answer_choice.dart';

class Answer {
  List<AnswerChoice> answers;
  String correctAnswer;
  String? explanation;

  Answer({
    required this.answers,
    required this.correctAnswer,
    required this.explanation,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'answers': answers.map((x) => x.toMap()).toList(),
      'correct_answer': correctAnswer,
      'explanation': explanation,
    };
  }

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      answers: List<AnswerChoice>.from(
        (map['answers']).map<AnswerChoice>(
          (x) => AnswerChoice.fromMap(x as Map<String, dynamic>),
        ),
      ),
      correctAnswer: map['correct_answer'] as String,
      explanation:
          map['explanation'] != null ? map['explanation'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Answer.fromJson(String source) =>
      Answer.fromMap(json.decode(source) as Map<String, dynamic>);
}
