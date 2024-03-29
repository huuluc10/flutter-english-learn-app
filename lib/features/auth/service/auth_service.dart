import 'package:flutter_englearn/features/auth/repositories/auth_repository.dart';
import 'package:flutter_englearn/model/response/jwt_response.dart';

class AuthService {
  final AuthRepository authRepository;

  AuthService({
    required this.authRepository,
  });

  Future<bool> isAuth() async {
    final jwtResponse = await authRepository.getJWTCurrent();
    return jwtResponse != null;
  }

  Future<JwtResponse> getJWT() async {
    final jwtResponse = await authRepository.getJWTCurrent();
    if (jwtResponse == null) {
      throw Exception('JWT is null');
    }
    return jwtResponse;
  }
}
