import 'dart:convert';

import 'package:flutter_englearn/common/helper/helper.dart';

class AnswerChoice {
  String? text;
  String? answerImage;
  AnswerChoice({
    required this.text,
    required this.answerImage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
    };
  }

  factory AnswerChoice.fromMap(Map<String, dynamic> map) {
    String? image;
    if (map['answer_image'] != null) {
      image = transformLocalURLMediaToURL(map['answer_image']);
    }
    return AnswerChoice(
      text: map['text'] == null ? null : map['text'] as String,
      answerImage: image,
    );
  }

  String toJson() => json.encode(toMap());

  factory AnswerChoice.fromJson(String source) =>
      AnswerChoice.fromMap(json.decode(source) as Map<String, dynamic>);
}
