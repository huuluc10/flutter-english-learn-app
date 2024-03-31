import 'package:flutter_englearn/features/dictionary/repository/dictionary_repository.dart';
import 'package:flutter_englearn/features/dictionary/service/dictionary_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dictionaryRepositoryProvider = Provider((ref) {
  return DictionaryRepository();
});

final dictionaryServiceProvider = Provider((ref) {
  final dictionaryRepository = ref.watch(dictionaryRepositoryProvider);
  return DictionaryService(dictionaryRepository);
});
