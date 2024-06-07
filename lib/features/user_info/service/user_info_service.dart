import 'package:flutter/material.dart';
import 'package:flutter_englearn/common/provider/common_provider.dart';
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

import 'package:flutter_englearn/common/helper/helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInfoService {
  final UserInfoRepository userInfoRepository;
  final AuthRepository authRepository;

  UserInfoService({
    required this.userInfoRepository,
    required this.authRepository,
  });

  Future<int> changePassword(ChangePasswordRequest request) async {
    log('Change password', name: 'UserInfoService');

    String body = request.toJson();
    return await userInfoRepository.changePassword(body);
  }

  Future<UserInfoResponse> getUserInfo(
      BuildContext context, String username) async {
    ResultReturn result = await userInfoRepository.getInfo(username);
    log('Get user info', name: 'UserInfoService');

    if (result.httpStatusCode == 401) {
      if (context.mounted) {
        log('Token is expired', name: 'UserInfoService');
        Navigator.pushNamedAndRemoveUntil(
            context, WelcomeScreen.routeName, (route) => false);
      }
    }

    if (result.httpStatusCode == 400) {
      log('Get user info failed', name: 'UserInfoService');
      if (context.mounted) {
        showSnackBar(context, 'Get user info failed');
        Navigator.pop(context);
      }
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
      showSnackBar(context, 'Cập nhật thông tin thành công!');
    }
  }

  Future<void> addEmail(
    BuildContext context,
    String email,
    String username,
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
          arguments: [email, false, username]);
    }
  }

  Future<void> verifyCodeAddEmail(
    BuildContext context,
    String email,
    String otp,
    String username,
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

    UserInfoResponse userInfo = await getUserInfo(context, username);
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
                if (context.mounted)
                  {
                    Navigator.pop(context),
                    Navigator.pop(context),
                    Navigator.pop(context),
                    Navigator.pushNamed(
                      context,
                      MoreUserInfoScreen.routeName,
                      arguments: [true, userInfo],
                    ),
                  }
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

  Future<ResultReturn> countHistoryLearnedLesson(String username) {
    log('Count history learned lesson', name: 'UserInfoService');
    return userInfoRepository.countHistoryLearnedLesson(username);
  }

  Future<ResultReturn> getLessonExerciseDone(String username) {
    log('Get exercise lesson history', name: 'UserInfoService');
    return userInfoRepository.getLessonExerciseDone(username);
  }

  Future<ResultReturn> getExamExerciseDone(String username) {
    log('Get exercise exam history', name: 'UserInfoService');
    return userInfoRepository.getExamExerciseDone(username);
  }

  Future<ResultReturn> updateAvatar(
      BuildContext context, String imagePath) async {
    log('Update avatar', name: 'UserInfoService');
    return await userInfoRepository.changeAvatar(imagePath);
  }

  Future<void> updateStreak(BuildContext context) async {
    log('Update streak', name: 'UserInfoService');
    ResultReturn resultReturn = await userInfoRepository.updateStreak();

    if (resultReturn.httpStatusCode == 200) {
      log('Update streak successfully', name: 'UserInfoService');
    } else if (resultReturn.httpStatusCode == 401) {
      log('Token is expired', name: 'UserInfoService');
      if (!context.mounted) return;
      showSnackBar(
          context, 'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại!');
      Navigator.pushNamedAndRemoveUntil(
          context, WelcomeScreen.routeName, (route) => false);
    } else {
      log('Update streak failed', name: 'UserInfoService');
      if (!context.mounted) return;
      showSnackBar(context, 'Update streak failed');
    }
  }

  Future<String?> getAvatar(BuildContext context, WidgetRef ref) async {
    ResultReturn resultReturn = await userInfoRepository.getAvatar();

    if (resultReturn.httpStatusCode == 401) {
      log('Token is expired', name: 'UserInfoService');
      if (!context.mounted) return '';
      showSnackBar(
          context, 'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại!');
      Navigator.pushNamedAndRemoveUntil(
          context, WelcomeScreen.routeName, (route) => false);
      return '';
    } else if (resultReturn.httpStatusCode == 200) {
      log('Get avatar successfully', name: 'UserInfoService');
      ref
          .read(currentAvatarProvider.notifier)
          .update((state) => resultReturn.data);
      return resultReturn.data;
    } else {
      log('Get avatar failed', name: 'UserInfoService');
      return null;
    }
  }
}
