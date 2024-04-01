import 'dart:convert';

import 'package:flutter_englearn/model/response/dictionary_api_meanings_definitions.dart';

class Meaning {
  String partOfSpeech;
  List<Definitions> definitions;
  List<String>? synonyms;
  List<String>? antonyms;

  Meaning({
    required this.partOfSpeech,
    required this.definitions,
    required this.synonyms,
    required this.antonyms,
  });

  factory Meaning.fromMap(Map<String, dynamic> map) {
    return Meaning(
      partOfSpeech: map['partOfSpeech'] as String,
      definitions: List<Definitions>.from(map['definitions']
              ?.map((x) => Definitions.fromMap(x as Map<String, dynamic>))
          as Iterable),
      synonyms: List<String>.from(map['synonyms'] as Iterable),
      antonyms: List<String>.from(map['antonyms'] as Iterable),
    );
  }

  factory Meaning.fromJson(String source) =>
      Meaning.fromMap(json.decode(source) as Map<String, dynamic>);
}
