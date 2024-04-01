// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_englearn/model/response/dictionary_api_license_response.dart';

class Phonetics {
  String? text;
  String? audio;
  String? sourceUrl;
  License? license;

  Phonetics({
    required this.text,
    required this.audio,
    required this.sourceUrl,
    required this.license,
  });

  factory Phonetics.fromMap(Map<String, dynamic> map) {
    return Phonetics(
      text: map['text'] != null ? map['text'] as String : null,
      audio: map['audio'] != null ? map['audio'] as String : null,
      sourceUrl: map['sourceUrl'] != null ? map['sourceUrl'] as String : null,
      license: map['license'] != null
          ? License.fromMap(map['license'] as Map<String, dynamic>)
          : null,
    );
  }

  factory Phonetics.fromJson(String source) =>
      Phonetics.fromMap(json.decode(source) as Map<String, dynamic>);
}
