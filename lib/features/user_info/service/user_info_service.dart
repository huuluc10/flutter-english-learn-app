import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/auth/pages/otp_input_screen.dart';
import 'package:flutter_englearn/features/auth/pages/welcome_screen.dart';
import 'package:flutter_englearn/features/auth/repository/auth_repository.dart';
import 'package:flutter_englearn/features/user_info/pages/more_info_screen.dart';
import 'package:flutter_englearn/features/user_info/repository/user_info_repository.dart';
import 'package:flutter_englearn/model/request/change_password_request.dart';
import 'package:flutter_englearn/model/request/update_info_request.dart';
import 'package:flutter_englearn/model/request/verify_code_request.dart';
import 'package:flutter_englearn/model/response/user_info_response.dart';
import 'package:flutter_englearn/model/result_return.dart';
import 'dart:developer';

import 'package:flutter_englearn/utils/helper/helper.dart';

class UserInfoService {
  final UserInfoRepository userInfoRepository;
  final AuthRepository authRepository;

  UserInfoService({
    required this.userInfoRepository,
    required this.authRepository,
  });

  Future<int> changePassword(ChangePasswordRequest request) async {
    log('Change password', name: 'UserInfoService');
    String username = await userInfoRepository.getUsername();

    if (username.isEmpty) {
      return 401;
    }

    request.username = username;
    String body = request.toJson();
    return await userInfoRepository.changePassword(body);
  }

  Future<UserInfoResponse> getUserInfo(BuildContext context) async {
    ResultReturn result = await userInfoRepository.getInfo();
    log('Get user info', name: 'UserInfoService');

    if (result.httpStatusCode == 401) {
      log('Token is expired', name: 'UserInfoService');
      Navigator.pushNamedAndRemoveUntil(
          context, WelcomeScreen.routeName, (route) => false);
    }
    if (result.httpStatusCode == 400) {
      log('Get user info failed', name: 'UserInfoService');
      showSnackBar(context, 'Get user info failed');
      Navigator.pop(context);
    }

    log('Get user info successfully', name: 'UserInfoService');
    return result.data;
  }

  Future<void> updateUserInfo(
      BuildContext context, UpdateInfoRequest request) async {
    log('Update user info', name: 'UserInfoService');
    int resultUpdate = await userInfoRepository.updateInfo(request.toJson());

    if (resultUpdate == 401) {
      log('Token is expired', name: 'UserInfoService');
      if (!context.mounted) return;
      Navigator.pushNamedAndRemoveUntil(
          context, WelcomeScreen.routeName, (route) => false);
    } else if (resultUpdate == 400) {
      log('Update user info failed', name: 'UserInfoService');
      if (!context.mounted) return;
      showSnackBar(context, 'Update user info failed');
    } else {
      log('Update user info successfully', name: 'UserInfoService');
      if (!context.mounted) return;
      showSnackBar(context, 'Update user info successfully');
    }
  }

  Future<void> addEmail(
    BuildContext context,
    String email,
  ) async {
    log('Add email', name: 'UserInfoService');

    int resultAddEmail = await userInfoRepository.addEmail(email);

    if (resultAddEmail == 401) {
      log('Token is expired', name: 'UserInfoService');
      if (!context.mounted) return;
      Navigator.pushNamedAndRemoveUntil(
          context, WelcomeScreen.routeName, (route) => false);
    } else if (resultAddEmail == 400) {
      log('Send email failed', name: 'UserInfoService');
      if (!context.mounted) return;
      showSnackBar(context, 'Thay đổi email thất bại. Vui lòng thử lại!');
    } else if (resultAddEmail == 409) {
      log('Email is already taken', name: 'UserInfoService');
      if (!context.mounted) return;
      showSnackBar(
          context, 'Email này đã được sử dụng. Vui lòng chọn email khác!');
    } else {
      log('Send email successfully', name: 'UserInfoService');
      if (!context.mounted) return;
      Navigator.pushNamed(context, OTPInputScreen.routeName,
          arguments: [email, false]);
    }
  }

  Future<void> verifyCodeAddEmail(
    BuildContext context,
    String email,
    String otp,
  ) async {
    log('Verify code add email', name: 'UserInfoService');
    VerifyCodeRequest request = VerifyCodeRequest(
      email: email,
      code: otp,
    );

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

    UserInfoResponse userInfo = await getUserInfo(context);
    userInfo.email = email;
    UpdateInfoRequest updateInfoRequest =
        UpdateInfoRequest.fromResponse(userInfo);
    updateInfoRequest.email = email;

    await authRepository.verifyOTPResetPass(request.toJson()).then(
          (value) async => {
            if (value == 'Code is correct')
              {
                showSnackBar(context, "Xác thực mã OTP thành công!"),
                await updateUserInfo(context, updateInfoRequest),
                Navigator.pop(context),
                Navigator.pop(context),
                Navigator.pop(context),
                Navigator.pushNamed(
                  context,
                  MoreUserInfoScreen.routeName,
                  arguments: [true, userInfo],
                ),
              }
            else if (value == 'Code is incorrect')
              {
                log("OTP is incorrect", name: "AuthService"),
                Navigator.pop(context),
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Mã OTP không đúng! Vui lòng thử lại!"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Quay lại"),
                        ),
                      ],
                    );
                  },
                ),
              }
            else
              {
                log("OTP is expired", name: "AuthService"),
                Navigator.pop(context),
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Mã OTP đã hết hạn! Vui lòng thử lại!"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Quay lại"),
                        ),
                      ],
                    );
                  },
                ),
              }
          },
        );
  }

  Future<ResultReturn> countHistoryLearnedLesson() {
    log('Count history learned lesson', name: 'UserInfoService');
    return userInfoRepository.countHistoryLearnedLesson();
  }

  Future<ResultReturn> getLessonExerciseDone() {
    log('Get exercise lesson history', name: 'UserInfoService');
    return userInfoRepository.getLessonExerciseDone();
  }

  Future<ResultReturn> getExamExerciseDone() {
    log('Get exercise exam history', name: 'UserInfoService');
    return userInfoRepository.getExamExerciseDone();
  }
}
