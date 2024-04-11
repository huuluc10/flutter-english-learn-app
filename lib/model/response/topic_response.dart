// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

class TopicResponse {
  int topicId;
  String topicName;
  double successRate;

  TopicResponse({
    required this.topicId,
    required this.topicName,
    required this.successRate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'topicId': topicId,
      'topicName': topicName,
      'successRate': successRate,
    };
  }

  factory TopicResponse.fromMap(Map<String, dynamic> map) {
    return TopicResponse(
      topicId: map['topicId'] as int,
      topicName: map['topicName'] as String,
      successRate: map['successRate'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory TopicResponse.fromJson(String source) =>
      TopicResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
