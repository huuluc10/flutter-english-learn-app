// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_englearn/model/example.dart';

class Content {
  String? title;
  String? text;
  List<Example>? example;
  String? imageUrl;
  String? videoUrl;
  Content({
    required this.title,
    required this.text,
    required this.example,
    required this.imageUrl,
    required this.videoUrl,
  });

  factory Content.fromMap(Map<String, dynamic> map) {
    List<Example> example = [];

    if (map['example'] == null) {
      example = [];
    } else
      for (var item in map['example']) {
        example.add(Example.fromMap(item as Map<String, dynamic>));
      }
    return Content(
      title: map['title'] == null ? null : map['title'],
      text: map['text'] == null ? null : map['text'],
      example: example,
      imageUrl: map['image_url'] == null ? null : map['image_url'],
      videoUrl: map['video_url'] == null ? null : map['video_url'],
    );
  }

  factory Content.fromJson(String source) =>
      Content.fromMap(json.decode(source) as Map<String, dynamic>);
}
