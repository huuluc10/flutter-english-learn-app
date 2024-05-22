// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_englearn/model/topic.dart';
import 'package:flutter_englearn/common/helper/helper.dart';

class HistoryLearnTopicResponse extends Topic {
  double successRate;
  String imageUrl;

  HistoryLearnTopicResponse({
    required super.topicId,
    required super.topicName,
    required this.successRate,
    required this.imageUrl,
  });

  factory HistoryLearnTopicResponse.fromMap(Map<String, dynamic> map) {
    return HistoryLearnTopicResponse(
      topicId: map['topicId'] as int,
      topicName: map['topicName'] as String,
      successRate: map['successRate'] as double,
      imageUrl: transformLocalURLMediaToURL(map['imageUrl'] as String),
    );
  }

  factory HistoryLearnTopicResponse.fromJson(String source) =>
      HistoryLearnTopicResponse.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
