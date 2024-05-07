// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_englearn/model/answer_choice.dart';
import 'package:flutter_englearn/common/utils/helper/helper.dart';

class Answer {
  String question;
  String? questionImage;
  List<AnswerChoice>? answers;
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
    String? questionImage;
    String? correctImage;
    if (map['question_image'] != null) {
      questionImage = transformLocalURLMediaToURL(map['question_image']);
    }
    if (map['correct_image'] != null) {
      correctImage = transformLocalURLMediaToURL(map['correct_image']);
    }
    return Answer(
      question: map['question'] as String,
      questionImage: questionImage,
      answers: map['answers'] != null
          ? List<AnswerChoice>.from(
              (map['answers']).map<AnswerChoice>(
                (x) => AnswerChoice.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      correctAnswer: map['correct_answer'] != null
          ? map['correct_answer'] as String
          : null,
      correctImage: correctImage,
      explanation:
          map['explanation'] != null ? map['explanation'] as String : null,
    );
  }

  factory Answer.fromJson(String source) =>
      Answer.fromMap(json.decode(source) as Map<String, dynamic>);
}
