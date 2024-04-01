import 'dart:convert';

import 'package:en_vi_dic/en_vi_dic.dart';
import 'package:flutter_englearn/model/response/dictionary_api_word_response.dart';
import 'package:flutter_englearn/utils/const/api_url.dart';
import 'package:flutter_englearn/utils/const/base_header_http.dart';
import 'package:http/http.dart' as http;

class DictionaryRepository {
  Future<Vocabulary?> getWordsFromEnViDic(String text) async {
    try {
      if (!EnViDic().hasInit) {
        await EnViDic().init();
      }
      return EnViDic().lookUp(text);
    } catch (e) {
      return null;
    }
  }

  Future<void> getWordFromAPI(String text) async {
    final authority = APIUrl.rootDictionaryAPI;
    final unencodedPath = APIUrl.pathDictionary + text;
    Map<String, String> headers = BaseHeaderHttp.headers;
    final uri = Uri.https(authority, unencodedPath);
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final List jsonResponse = jsonDecode(response.body);
      final List<DictionaryAPIWordResponse> words = jsonResponse
          .map((item) => DictionaryAPIWordResponse.fromMap(item))
          .toList();
      print(words[0].word);
    } else {
      throw Exception('Failed to load words from API');
    }
  }
}
