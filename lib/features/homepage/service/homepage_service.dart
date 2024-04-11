import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/homepage/repository/homepage_repository.dart';
import 'package:flutter_englearn/features/user_info/service/user_info_service.dart';
import 'package:flutter_englearn/model/response/history_learn_topic_response.dart';
import 'dart:developer';

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
}
