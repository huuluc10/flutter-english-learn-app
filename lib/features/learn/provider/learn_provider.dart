import 'package:flutter_englearn/features/auth/provider/auth_provider.dart';
import 'package:flutter_englearn/features/learn/repository/learn_repository.dart';
import 'package:flutter_englearn/features/learn/service/learn_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final learnRepositoryProvider = Provider<LearnRepository>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return LearnRepository(authRepository: authRepository);
});

final learnServiceProvider = Provider<LearnService>((ref) {
  final learnRepository = ref.watch(learnRepositoryProvider);
  final authRepository = ref.watch(authRepositoryProvider);
  return LearnService(
    learnRepository: learnRepository,
    authRepository: authRepository,
  );
});
