import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/auth/pages/welcome_screen.dart';
import 'package:flutter_englearn/features/homepage/repository/homepage_repository.dart';
import 'package:flutter_englearn/features/user_info/service/user_info_service.dart';
import 'package:flutter_englearn/model/response/history_learn_topic_response.dart';
import 'dart:developer';

import 'package:flutter_englearn/model/response/main_user_info_request.dart';
import 'package:flutter_englearn/model/result_return.dart';
import 'package:flutter_englearn/utils/helper/helper.dart';

class HomepageService {
  final HomepageRepository homepageRepository;
  final UserInfoService userInfoService;

  HomepageService(
      {required this.homepageRepository, required this.userInfoService});

  Future<List<HistoryLearnTopicResponse>> fetchTopic(
      BuildContext context) async {
    log("fetchTopic", name: "HomepageService");
    await userInfoService.updateStreak(context);
    return await homepageRepository.fetchTopic();
  }

  Future<List<MainUserInfoResponse>> fetchLeaderboard(
      BuildContext context) async {
    log("fetchLeaderboard", name: "HomepageService");
    ResultReturn result = await homepageRepository.getLeaderboard();

    if (result.httpStatusCode == 401) {
      if (context.mounted) {
        showSnackBar(
            context, 'Phiên đăng nhập hết hạn, vui lòng đăng nhập lại!');
        Navigator.of(context).pushNamedAndRemoveUntil(
            WelcomeScreen.routeName, (Route<dynamic> route) => false);
      }
    }
    return result.data as List<MainUserInfoResponse>;
  }
}
