// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_englearn/model/content.dart';

class LessconContent {
  final String title;
  final String description;
  final List<Content> content;
  LessconContent({
    required this.title,
    required this.description,
    required this.content,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'content': content.map((x) => x.toMap()).toList(),
    };
  }

  factory LessconContent.fromMap(Map<String, dynamic> map) {
    return LessconContent(
      title: map['title'] as String,
      description: map['description'] as String,
      content: List<Content>.from((map['content'])),
    );
  }

  String toJson() => json.encode(toMap());

  factory LessconContent.fromJson(String source) =>
      LessconContent.fromMap(json.decode(source) as Map<String, dynamic>);
}
