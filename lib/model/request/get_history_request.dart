import 'dart:convert';

class GetHistoryLearnRequest {
  String username;
  String topicId;

  GetHistoryLearnRequest({
    required this.username,
    required this.topicId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'topicId': topicId,
    };
  }

  String toJson() => json.encode(toMap());
}
