import 'package:en_vi_dic/en_vi_dic.dart';
import 'package:flutter_englearn/features/dictionary/repository/dictionary_repository.dart';

class DictionaryService {
  final DictionaryRepository _dictionaryRepository;

  DictionaryService(this._dictionaryRepository);

  Future<Vocabulary?> getWordEnViDic(String text) async {
    return _dictionaryRepository.getWordsFromEnViDic(text);
  }


}