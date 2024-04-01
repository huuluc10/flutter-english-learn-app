import 'package:en_vi_dic/en_vi_dic.dart';
import 'package:flutter_englearn/features/dictionary/repository/dictionary_repository.dart';
import 'package:flutter_englearn/model/response/dictionary_api_word_response.dart';
import 'dart:developer';

class DictionaryService {
  final DictionaryRepository _dictionaryRepository;

  DictionaryService(this._dictionaryRepository);

  Future<Vocabulary?> getWordEnViDic(String text) async {
    log("Get word from EnViDic: $text", name: "DictionaryService");
    return _dictionaryRepository.getWordsFromEnViDic(text);
  }

  Future<List<DictionaryAPIWordResponse>> getWordFromAPI(String text) async {
    log("Get word from API: $text", name: "DictionaryService");
    return _dictionaryRepository.getWordFromAPI(text);
  }
}
