// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AddFeedbackRequest {
  int lessonId;
  String text;

  AddFeedbackRequest({
    required this.lessonId,
    required this.text,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lessonId': lessonId,
      'text': text,
    };
  }

  String toJson() => json.encode(toMap());
}
