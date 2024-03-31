// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_englearn/model/response/dictionary_api_license_response.dart';

class Phonetics {
  String text;
  String audio;
  String sourceUrl;
  License license;

  Phonetics({
    required this.text,
    required this.audio,
    required this.sourceUrl,
    required this.license,
  });

  factory Phonetics.fromMap(Map<String, dynamic> map) {
    return Phonetics(
      text: map['text'] as String,
      audio: map['audio'] as String,
      sourceUrl: map['sourceUrl'] as String,
      license: License.fromMap(map['license'] as Map<String, dynamic>),
    );
  }

  factory Phonetics.fromJson(String source) =>
      Phonetics.fromMap(json.decode(source) as Map<String, dynamic>);
}
