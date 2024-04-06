import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/auth/pages/adding_info_sign_up_screen.dart';
import 'package:flutter_englearn/features/auth/pages/login_screen.dart';
import 'package:flutter_englearn/features/auth/pages/otp_input_screen.dart';
import 'package:flutter_englearn/features/auth/pages/set_password_screen.dart';
import 'package:flutter_englearn/features/auth/pages/welcome_screen.dart';
import 'package:flutter_englearn/features/auth/repository/auth_repository.dart';
import 'package:flutter_englearn/features/homepage/pages/home_screen.dart';
import 'package:flutter_englearn/model/login_request.dart';
import 'package:flutter_englearn/model/request/reset_password_request.dart';
import 'package:flutter_englearn/model/request/sign_up_request.dart';
import 'package:flutter_englearn/model/request/verify_code_request.dart';
import 'package:flutter_englearn/model/response/jwt_response.dart';
import 'package:flutter_englearn/utils/helper/helper.dart';
import 'dart:developer';

class AuthService {
  final AuthRepository authRepository;

  AuthService({
    required this.authRepository,
  });

  Future<bool> isJWTExist() async {
    log("isJWTExist", name: "AuthService");
    final jwtResponse = await authRepository.getJWTCurrent();
    return jwtResponse != null;
  }

  Future<JwtResponse> getJWT() async {
    final jwtResponse = await authRepository.getJWTCurrent();
    if (jwtResponse == null) {
      log("JWT is null", name: "AuthService");
      throw Exception('JWT is null');
    }
    return jwtResponse;
  }

  Future<void> saveJWT(JwtResponse jwtResponse) async {
    log("saveJWT", name: "AuthService");
    await authRepository.saveJWT(jwtResponse);
  }

  Future<void> removeJWT() async {
    log("removeJWT", name: "AuthService");
    await authRepository.removeJWT();
  }

  Future<void> login(
      BuildContext context, String username, String password) async {
    LoginRequest body = LoginRequest(
      username: username,
      password: password,
    );
    log("login", name: "AuthService");
    final jwtResponse = await authRepository.login(body.toJson());
    if (jwtResponse == null) {
      if (!context.mounted) return;
      log("Username or password is incorrect", name: "AuthService");
      showSnackBar(context, "Tài khoản hoặc mật khẩu không đúng!");
    } else {
      // Navigate to home screen
      if (!context.mounted) return;
      log("Login successfully", name: "AuthService");
      Navigator.pushNamedAndRemoveUntil(
        context,
        HomeScreen.routeName,
        (route) => false,
      );
    }
  }

  Future<void> logout(BuildContext context) async {
    log("logout", name: "AuthService");
    bool result = await authRepository.logout();

    if (result) {
      if (!context.mounted) return;
      log("Logout successfully", name: "AuthService");
      Navigator.pushNamedAndRemoveUntil(
        context,
        WelcomeScreen.routeName,
        (route) => false,
      );
    } else {
      if (!context.mounted) return;
      log("Logout failed", name: "AuthService");
      showSnackBar(context, "Đăng xuất không thành công!");
    }
  }

  Future<void> signUp(BuildContext context, SignUpRequest request) async {
    log("signUp", name: "AuthService");
    final result = await authRepository.signUp(request.toJson());
    if (result == false) {
      if (!context.mounted) return;
      log("Sign up failed", name: "AuthService");
      showSnackBar(context, "Không đăng ký thành công! Vui lòng thử lại!");
    } else {
      if (!context.mounted) return;
      // Navigate to home screen
      log("Sign up successfully", name: "AuthService");
      Navigator.pushNamedAndRemoveUntil(
        context,
        LoginScreen.routeName,
        (route) => false,
      );
    }
  }

  Future<void> checkUsernameExists(
      BuildContext context, SignUpRequest request) async {
    log("checkUsernameExists", name: "AuthService");
    bool check = await authRepository.checkUsernameExists(request.username);

    if (check) {
      if (!context.mounted) return;
      log("Username already exists", name: "AuthService");
      showSnackBar(context, "Tên đăng nhập đã tồn tại!");
    } else {
      if (!context.mounted) return;
      log("Username is available", name: "AuthService");
      Navigator.pushNamedAndRemoveUntil(
          context, AddingInfoSignUpScreen.routeName, (route) => false,
          arguments: request);
    }
  }

  Future<void> resetPassword(BuildContext context, String email) async {
    log("resetPassword", name: "AuthService");
    bool check = await authRepository.checkEmailExists(email);

    if (!check) {
      if (!context.mounted) return;
      log("Email is not registered", name: "AuthService");
      showSnackBar(context, "Email này chưa được đăng ký! Vui lòng thử lại!");
    } else {
      if (!context.mounted) return;
      // show loader dialog
      log("Send OTP", name: "AuthService");
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      await authRepository.resetPassword(email).then((value) {
        if (value == false) {
          log("Send OTP failed", name: "AuthService");
          showSnackBar(
              context, "Gửi mã OTP không thành công! Vui lòng thử lại!");
        } else {
          log("Send OTP successfully", name: "AuthService");
          showSnackBar(context, "Gửi mã OTP thành công!");
        }
      });

      if (!context.mounted) return;
      // Close the loader dialog
      Navigator.pop(context); // Close the loader dialog

      // Navigate to OTP input screen
      log("Navigate to OTP input screen", name: "AuthService");
      Navigator.pushNamedAndRemoveUntil(
        context,
        OTPInputScreen.routeName,
        (route) => false,
        arguments: [email, true, null],
      );
    }
  }

  Future<void> verifyOTPResetPass(
    BuildContext context,
    String email,
    String otp,
  ) async {
    VerifyCodeRequest request = VerifyCodeRequest(
      email: email,
      code: otp,
    );
    log("verifyOTP", name: "AuthService");

    // show loader dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    await authRepository.verifyOTPResetPass(request.toJson()).then(
          (value) => {
            if (value == 'Code is correct')
              {
                showSnackBar(context, "Xác thực mã OTP thành công!"),
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  SetPasswordScreen.routeName,
                  (route) => false,
                  arguments: email,
                ),
              }
            else if (value == 'Code is incorrect')
              {
                log("OTP is incorrect", name: "AuthService"),
                Navigator.pop(context),
                showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        title: Text("Mã OTP không đúng! Vui lòng thử lại!"),
                      );
                    }),
              }
            else
              {
                log("OTP is expired", name: "AuthService"),
                Navigator.pop(context),
                showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        title: Text("Mã OTP đã hết hạn! Vui lòng thử lại!"),
                      );
                    }),
              }
          },
        );
  }

  Future<void> changeResetPassword(
      BuildContext context, String email, String password) async {
    log("changeResetPassword", name: "AuthService");
    // show loader dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    ResetPasswordRequest request = ResetPasswordRequest(
      email: email,
      newPassword: password,
    );

    Navigator.pop(context); // Close the loader dialog

    await authRepository.changeResetPassword(request.toJson()).then(
          (value) => {
            if (value)
              {
                log("Change password successfully", name: "AuthService"),
                showSnackBar(context, "Đổi mật khẩu thành công!"),
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  LoginScreen.routeName,
                  (route) => false,
                )
              }
            else
              {
                log("Change password failed", name: "AuthService"),
                showSnackBar(context, "Đổi mật khẩu không thành công!"),
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  WelcomeScreen.routeName,
                  (route) => false,
                )
              }
          },
        );
  }
}
