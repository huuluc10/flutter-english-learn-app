import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/auth/pages/welcome_screen.dart';
import 'package:flutter_englearn/features/homepage/repository/homepage_repository.dart';
import 'package:flutter_englearn/features/user_info/service/user_info_service.dart';
import 'package:flutter_englearn/features/user_info/widgets/streak_congratulation_widget.dart';
import 'package:flutter_englearn/model/response/history_learn_topic_response.dart';
import 'dart:developer';

import 'package:flutter_englearn/model/response/main_user_info_request.dart';
import 'package:flutter_englearn/model/result_return.dart';
import 'package:flutter_englearn/common/helper/helper.dart';

class HomepageService {
  final HomepageRepository homepageRepository;
  final UserInfoService userInfoService;

  HomepageService(
      {required this.homepageRepository, required this.userInfoService});

  Future<List<HistoryLearnTopicResponse>> fetchTopic(
      BuildContext context) async {
    log("fetchTopic", name: "HomepageService");
    int newStreak = await userInfoService.updateStreak(context);

    int oldStreak = await homepageRepository.getStreak();

    if (newStreak > oldStreak) {
      await homepageRepository.setStreak(newStreak);
      showDialog(
        context: context,
        builder: (context) => StreakCongratulationWidget(
          oldStreak: oldStreak,
          newStreak: newStreak,
        ), // Widget chào mừng
      );
    }

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

  Future<String?> getEmail() async {
    return await homepageRepository.getEmail();
  }

  Future<void> setEmail(String email) async {
    await homepageRepository.setEmail(email);
  }

  Future<String?> getEmailFromAPI() async {
    String? email = await homepageRepository.getEmailFromAPI();

    if (email != null) {
      return await homepageRepository.getEmailFromAPI();
    }
    return email;
  }

  Future<String?> getLevel() async {
    return await homepageRepository.getLevel();
  }
}
