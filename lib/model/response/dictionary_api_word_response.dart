import 'dart:convert';

import 'package:flutter_englearn/model/response/dictionary_api_license_response.dart';
import 'package:flutter_englearn/model/response/dictionary_api_meanings.dart';
import 'package:flutter_englearn/model/response/dictionary_api_phonetics_response.dart';

class DictionaryAPIWordResponse {
  String word;
  String phonetic;
  List<Phonetics> phonetics;
  List<Meaning> meanings;
  License license;
  List<String> sourceUrls;

  DictionaryAPIWordResponse({
    required this.word,
    required this.phonetic,
    required this.phonetics,
    required this.meanings,
    required this.license,
    required this.sourceUrls,
  });

  factory DictionaryAPIWordResponse.fromMap(Map<String, dynamic> map) {
    return DictionaryAPIWordResponse(
      word: map['word'] as String,
      phonetic: map['phonetic'] as String,
      phonetics: List<Phonetics>.from(map['phonetics']
              ?.map((x) => Phonetics.fromMap(x as Map<String, dynamic>))
          as Iterable),
      meanings: List<Meaning>.from(map['meanings']
          ?.map((x) => Meaning.fromMap(x as Map<String, dynamic>))),
      license: License.fromMap(map['license'] as Map<String, dynamic>),
      sourceUrls: List<String>.from(map['sourceUrls'] as Iterable),
    );
  }

  factory DictionaryAPIWordResponse.fromJson(String source) =>
      DictionaryAPIWordResponse.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
