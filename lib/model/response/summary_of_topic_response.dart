import 'dart:convert';

class SummaryOfTopicResponse {
  String done;
  String total;

  SummaryOfTopicResponse({
    required this.done,
    required this.total,
  });

  factory SummaryOfTopicResponse.fromMap(Map<String, dynamic> map) {
    return SummaryOfTopicResponse(
      done: map['done'] as String,
      total: map['total'] as String,
    );
  }

  factory SummaryOfTopicResponse.fromJson(String source) =>
      SummaryOfTopicResponse.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
