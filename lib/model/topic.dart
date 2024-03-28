import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Topic {
  int topicId;
  String topicName;

  Topic({
    required this.topicId,
    required this.topicName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'topicId': topicId,
      'topicName': topicName,
    };
  }

  factory Topic.fromMap(Map<String, dynamic> map) {
    return Topic(
      topicId: map['topicId'] as int,
      topicName: map['topicName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Topic.fromJson(String source) =>
      Topic.fromMap(json.decode(source) as Map<String, dynamic>);
}
