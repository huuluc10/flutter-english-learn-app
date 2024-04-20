import 'dart:convert';

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
    return AnswerChoice(
      text: map['text'] == null ? null : map['text'] as String,
      answerImage:
          map['answerImage'] == null ? null : map['answerImage'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AnswerChoice.fromJson(String source) =>
      AnswerChoice.fromMap(json.decode(source) as Map<String, dynamic>);
}
