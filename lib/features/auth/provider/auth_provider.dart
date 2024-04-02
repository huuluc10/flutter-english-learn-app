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
  return authController.getJWT();
});

final isJWTExistProvider = FutureProvider((ref) async {
  final authController = ref.watch(authServiceProvicer);
  return authController.isJWTExist();
});
