import 'package:en_vi_dic/en_vi_dic.dart';

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
}
