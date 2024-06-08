import 'package:flutter_englearn/features/auth/provider/auth_provider.dart';
import 'package:flutter_englearn/features/homepage/controller/homepage_controller.dart';
import 'package:flutter_englearn/features/homepage/repository/homepage_repository.dart';
import 'package:flutter_englearn/features/homepage/service/homepage_service.dart';
import 'package:flutter_englearn/features/user_info/providers/user_info_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homepageRepositoryProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return HomepageRepository(authRepository: authRepository);
});

final homepageServiceProvider = Provider((ref) {
  final homepageRepository = ref.watch(homepageRepositoryProvider);
  final userInfoService = ref.watch(userInfoServiceProvider);
  return HomepageService(
    homepageRepository: homepageRepository,
    userInfoService: userInfoService,
  );
});

final openCountProvider =
    StateNotifierProvider<OpenCountProvider, int>((ref) => OpenCountProvider());

