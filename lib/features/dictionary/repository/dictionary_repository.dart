import 'dart:convert';

import 'package:en_vi_dic/en_vi_dic.dart';
import 'package:flutter_englearn/model/response/dictionary_api_word_response.dart';
import 'package:flutter_englearn/common/utils/const/api_url.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class DictionaryRepository {
  Future<Vocabulary?> getWordsFromEnViDic(String text) async {
    try {
      if (!EnViDic().hasInit) {
        await EnViDic().init();
      }
      log("Get word from EnViDic: $text", name: "DictionaryRepository");
      return EnViDic().lookUp(text);
    } catch (e) {
      return null;
    }
  }

  Future<List<DictionaryAPIWordResponse>> getWordFromAPI(String text) async {
    log("Get word from API: $text", name: "DictionaryRepository");
    const authority = APIUrl.rootDictionaryAPI;
    final unencodedPath = APIUrl.pathDictionary + text;
    final uri = Uri.https(authority, unencodedPath);
    final response = await http.get(uri);

    List<DictionaryAPIWordResponse> words = [];

    if (response.statusCode == 200) {
      log('Load words from API successfully', name: 'DictionaryRepository');
      final List jsonResponse = jsonDecode(response.body);
      words = jsonResponse
          .map((item) => DictionaryAPIWordResponse.fromMap(item))
          .toList();
    } else {
      log('Failed to load words from API', name: 'DictionaryRepository');
    }
    return words;
  }
}
