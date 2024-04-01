// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_englearn/model/response/dictionary_api_license_response.dart';
import 'package:flutter_englearn/model/response/dictionary_api_meanings.dart';
import 'package:flutter_englearn/model/response/dictionary_api_phonetics_response.dart';

class DictionaryAPIWordResponse {
  String word;
  String? phonetic;
  List<Phonetics>? phonetics;
  List<Meaning>? meanings;
  License? license;
  List<String>? sourceUrls;

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
      phonetic: map['phonetic'] != null ? map['phonetic'] as String : null,
      phonetics: map['phonetics'] != null
          ? List<Phonetics>.from(
              map['phonetics'].map<Phonetics?>(
                (x) => Phonetics.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      meanings: map['meanings'] != null
          ? List<Meaning>.from(
              map['meanings'].map<Meaning?>(
                (x) => Meaning.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      license: map['license'] != null
          ? License.fromMap(map['license'] as Map<String, dynamic>)
          : null,
      sourceUrls: map['sourceUrls'] != null
          ? List<String>.from(map['sourceUrls'])
          : null,
    );
  }

  factory DictionaryAPIWordResponse.fromJson(String source) =>
      DictionaryAPIWordResponse.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
