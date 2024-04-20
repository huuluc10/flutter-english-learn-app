// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_englearn/model/answer_choice.dart';

class Answer {
  String question;
  String? questionImage;
  List<AnswerChoice> answers;
  String? correctAnswer;
  String? correctImage;
  String? explanation;

  Answer({
    required this.question,
    this.questionImage,
    required this.answers,
    this.correctAnswer,
    this.correctImage,
    this.explanation,
  });

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      question: map['question'] as String,
      questionImage: map['question_image'] != null
          ? map['question_image'] as String
          : null,
      answers: List<AnswerChoice>.from(
        (map['answers']).map<AnswerChoice>(
          (x) => AnswerChoice.fromMap(x as Map<String, dynamic>),
        ),
      ),
      correctAnswer: map['correct_answer'] as String,
      correctImage:
          map['correct_image'] != null ? map['correct_image'] as String : null,
      explanation:
          map['explanation'] != null ? map['explanation'] as String : null,
    );
  }

  factory Answer.fromJson(String source) =>
      Answer.fromMap(json.decode(source) as Map<String, dynamic>);
}
