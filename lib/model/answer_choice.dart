import 'dart:convert';

class AnswerChoice {
  String text;
  AnswerChoice({
    required this.text,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
    };
  }

  factory AnswerChoice.fromMap(Map<String, dynamic> map) {
    return AnswerChoice(
      text: map['text'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AnswerChoice.fromJson(String source) =>
      AnswerChoice.fromMap(json.decode(source) as Map<String, dynamic>);
}
