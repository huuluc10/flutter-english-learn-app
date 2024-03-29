import 'package:flutter/widgets.dart';
import 'package:flutter_englearn/features/auth/repository/auth_repository.dart';
import 'package:flutter_englearn/features/homepage/pages/home_screen.dart';
import 'package:flutter_englearn/model/login_request.dart';
import 'package:flutter_englearn/model/response/jwt_response.dart';
import 'package:flutter_englearn/utils/helper/helper.dart';

class AuthService {
  final AuthRepository authRepository;

  AuthService({
    required this.authRepository,
  });

  Future<bool> isJWTExist() async {
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

  Future<void> saveJWT(JwtResponse jwtResponse) async {
    await authRepository.saveJWT(jwtResponse);
  }

  Future<void> removeJWT() async {
    await authRepository.removeJWT();
  }

  Future<void> login(
      BuildContext context, String username, String password) async {
    LoginRequest body = LoginRequest(
      username: username,
      password: password,
    );
    final jwtResponse = await authRepository.login(body.toJson());
    if (jwtResponse == null) {
      showSnackBar(context, "Tài khoản hoặc mật khẩu không đúng!");
    } else {
      // Navigate to home screen
      Navigator.pushNamedAndRemoveUntil(
        context,
        HomeScreen.routeName,
        (route) => false,
      );
    }
  }
}
