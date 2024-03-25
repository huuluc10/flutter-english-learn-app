// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_englearn/model/example.dart';

class Content {
  String? title;
  String text;
  List<Example> example;
  String? imageUrl;
  String? videoUrl;
  Content({
    required this.title,
    required this.text,
    required this.example,
    required this.imageUrl,
    required this.videoUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'text': text,
      'example': example.map((x) => x.toMap()).toList(),
      'image_url': imageUrl,
      'video_url': videoUrl,
    };
  }

  factory Content.fromMap(Map<String, dynamic> map) {
    return Content(
      title: map['title'] as String,
      text: map['text'] as String,
      example: List<Example>.from(
        (map['example'] as List<int>).map<Example>(
          (x) => Example.fromMap(x as Map<String, dynamic>),
        ),
      ),
      imageUrl: map['image_url'] as String,
      videoUrl: map['video_url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Content.fromJson(String source) =>
      Content.fromMap(json.decode(source) as Map<String, dynamic>);
}
