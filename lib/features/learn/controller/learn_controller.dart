import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/learn/provider/learn_provider.dart';
import 'package:flutter_englearn/model/lesson_content.dart';
import 'package:flutter_englearn/model/response/lesson_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<LessconContent> fetchLessonContent(
    BuildContext context, WidgetRef ref, String url) async {
  final response = await ref.watch(learnServiceProvider).getLessonContent(
        context,
        url,
      );
  return response;
}

Future<List<LessonResponse>> getLessons(
  BuildContext context,
  WidgetRef ref,
  String topicId,
) async {
  List<LessonResponse> lessons = await ref
      .watch(learnServiceProvider)
      .getListLessonOfTopic(context, topicId);

  return lessons;
}
