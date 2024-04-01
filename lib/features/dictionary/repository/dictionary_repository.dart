import 'dart:convert';

import 'package:en_vi_dic/en_vi_dic.dart';
import 'package:flutter_englearn/model/response/dictionary_api_word_response.dart';
import 'package:flutter_englearn/utils/const/base_header_http.dart';
import 'package:http/http.dart' as http;

class DictionaryRepository {

  Future<Vocabulary?> getWordsFromEnViDic(String text) async {
    Map<String, String> headers = BaseHeaderHttp.headers;
    final uri = Uri.https('api.dictionaryapi.dev', 'api/v2/entries/en/cal');
    print(uri.authority);
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final List jsonResponse = jsonDecode(response.body) as List;
        print(jsonResponse
            .map((wordJson) => DictionaryAPIWordResponse.fromJson(wordJson))
            .toList());
      } else {
        throw Exception('Failed to load words from API');
      }

    try {
      if (!EnViDic().hasInit) {
        await EnViDic().init();
      }
      return EnViDic().lookUp(text);
    } catch (e) {
      return null;
    }
  }
}
