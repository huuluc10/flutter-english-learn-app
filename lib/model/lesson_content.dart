import 'dart:convert';
import 'package:flutter_englearn/model/content.dart';

class LessconContent {
  final String title;
  final String? description;
  final List<Content> content;
  LessconContent({
    required this.title,
    required this.description,
    required this.content,
  });

  factory LessconContent.fromMap(Map<String, dynamic> map) {
    List<Content> content = [];
    for (var item in map['content']) {
      content.add(Content.fromMap(item as Map<String, dynamic>));
    }

    return LessconContent(
      title: map['title'] as String,
      description:
          map['description'] == null ? null : map['description'] as String?,
      content: content,
    );
  }

  factory LessconContent.fromJson(String source) =>
      LessconContent.fromMap(json.decode(source) as Map<String, dynamic>);
}
