// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Definitions {
  String definition;
  List<String>? synonyms;
  List<String>? antonyms;
  String? example;

  Definitions({
    required this.definition,
    required this.synonyms,
    required this.antonyms,
    required this.example,
  });

  factory Definitions.fromMap(Map<String, dynamic> map) {
    return Definitions(
      definition: map['definition'] as String,
      synonyms:
          map['synonyms'] != null ? List<String>.from(map['synonyms']) : null,
      antonyms:
          map['antonyms'] != null ? List<String>.from(['antonyms']) : null,
      example: map['example'] != null ? map['example'] as String : null,
    );
  }

  factory Definitions.fromJson(String source) =>
      Definitions.fromMap(json.decode(source) as Map<String, dynamic>);
}
