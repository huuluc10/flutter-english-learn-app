import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/auth/pages/welcome_screen.dart';
import 'package:flutter_englearn/features/user_info/repository/user_info_repository.dart';
import 'package:flutter_englearn/model/request/change_password_request.dart';
import 'package:flutter_englearn/model/response/user_info_response.dart';
import 'package:flutter_englearn/model/result_return.dart';
import 'dart:developer';

import 'package:flutter_englearn/utils/helper/helper.dart';

class UserInfoService {
  final UserInfoRepository userInfoRepository;

  UserInfoService({required this.userInfoRepository});

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
}
