// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Example {
  String original;
  String explanation;
  Example({
    required this.original,
    required this.explanation,
  });



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'original': original,
      'explanation': explanation,
    };
  }

  factory Example.fromMap(Map<String, dynamic> map) {
    return Example(
      original: map['original'] as String,
      explanation: map['explanation'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Example.fromJson(String source) => Example.fromMap(json.decode(source) as Map<String, dynamic>);
}
