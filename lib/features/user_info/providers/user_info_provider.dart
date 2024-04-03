import 'package:flutter_englearn/features/auth/provider/auth_provider.dart';
import 'package:flutter_englearn/features/user_info/repository/user_info_repository.dart';
import 'package:flutter_englearn/features/user_info/service/user_info_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userInfoRepositoryProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return UserInfoRepository(authRepository: authRepository);
});

final userInfoServiceProvider = Provider((ref) {
  final userInfoRepository = ref.watch(userInfoRepositoryProvider);
  return UserInfoService(userInfoRepository: userInfoRepository);
});
