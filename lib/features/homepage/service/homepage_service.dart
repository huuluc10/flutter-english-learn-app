import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/homepage/repository/homepage_repository.dart';
import 'package:flutter_englearn/model/response/history_learn_topic_response.dart';
import 'dart:developer';

class HomepageService {
  final HomepageRepository homepageRepository;

  HomepageService({required this.homepageRepository});

  Future<List<HistoryLearnTopicResponse>> fetchTopic(BuildContext context) async {
    log("fetchTopic", name: "HomepageService");
    return await homepageRepository.fetchTopic();
  }
}
