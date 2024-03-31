import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/homepage/repository/homepage_repository.dart';
import 'package:flutter_englearn/model/response/history_learn_topic_response.dart';

class HomepageService {
  final HomepageRepository homepageRepository;

  HomepageService({required this.homepageRepository});

  Future<List<HistoryLearnTopicResponse>> fetchTopic(BuildContext context) async {
    // show loader dialog
    return await homepageRepository.fetchTopic();
  }
}
