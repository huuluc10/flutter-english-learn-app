// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Definitions {
  String definition;
  List<String> synonyms;
  List<String> antonyms;
  String example;

  Definitions({
    required this.definition,
    required this.synonyms,
    required this.antonyms,
    required this.example,
  });

  factory Definitions.fromMap(Map<String, dynamic> map) {
    return Definitions(
      definition: map['definition'] as String,
      synonyms: List<String>.from(map['synonyms'] as Iterable),
      antonyms: List<String>.from(map['antonyms'] as Iterable),
      example: map['example'] as String,
    );
  }

  factory Definitions.fromJson(String source) =>
      Definitions.fromMap(json.decode(source) as Map<String, dynamic>);
}
