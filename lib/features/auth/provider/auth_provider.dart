import 'package:flutter_englearn/features/auth/repository/auth_repository.dart';
import 'package:flutter_englearn/features/auth/service/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository());

final authServiceProvicer = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthService(authRepository: authRepository);
});

final userDataAuthProvider = FutureProvider((ref) {
  final authController = ref.watch(authServiceProvicer);
  // delay 1s to get JWT
  Duration duration = const Duration(seconds: 1);
  Future.delayed(duration);
  return authController.getJWT();
});

final isJWTExistProvider = FutureProvider((ref) async {
  final authController = ref.watch(authServiceProvicer);
  Duration duration = const Duration(seconds: 5);
  await Future.delayed(duration);
  return authController.isJWTExist();
});
