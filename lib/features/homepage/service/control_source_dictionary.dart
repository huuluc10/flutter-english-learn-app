import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ControlSourceDictionary {
  enViDic,
  apiNetwork,
}

final controlSourceDictionary = StateProvider<ControlSourceDictionary>((ref) {
  return ControlSourceDictionary.enViDic;
});
