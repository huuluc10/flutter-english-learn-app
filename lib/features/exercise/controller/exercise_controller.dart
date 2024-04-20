import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/exercise/pages/result_exercise_screen.dart';
import 'package:flutter_englearn/features/exercise/provider/exercise_provider.dart';
import 'package:flutter_englearn/model/response/question_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<List<QuestionResponse>> fetchQuestions(
    WidgetRef ref, int lessonId, Function(int) updateTotalQuestion) async {
  List<QuestionResponse> elements = await ref
      .watch(exerciseServiceProvider)
      .getListMultipleChoiceQuestion(lessonId);

  updateTotalQuestion(elements.length);
  return await Future.delayed(
      const Duration(seconds: 0), () => List.of(elements));
}

void updateCurrentIndexQuestion(BuildContext context, Function() refresh,
    int currentIndex, int totalQuestion, List<Object> arguments) {
  if (currentIndex < totalQuestion - 1) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      refresh();
    });
  } else {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushNamed(
        context,
        ResultExerciseScreen.routeName,
        arguments: arguments,
      );
    });
  }
}
