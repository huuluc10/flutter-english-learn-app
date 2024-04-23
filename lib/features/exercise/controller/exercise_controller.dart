import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/exercise/pages/result_exercise_screen.dart';
import 'package:flutter_englearn/features/exercise/provider/exercise_provider.dart';
import 'package:flutter_englearn/model/response/question_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<List<QuestionResponse>> fetchMultipleChoiceQuestions(
    WidgetRef ref, int lessonId, Function(int) updateTotalQuestion) async {
  List<QuestionResponse> elements = await ref
      .watch(exerciseServiceProvider)
      .getListMultipleChoiceQuestion(lessonId);

  updateTotalQuestion(elements.length);
  return List.of(elements);
}

Future<List<QuestionResponse>> fetchFillInBlankQuestions(
    WidgetRef ref, int lessonId, Function(int) updateTotalQuestion) async {
  List<QuestionResponse> elements = await ref
      .watch(exerciseServiceProvider)
      .getListFillInBlankQuestion(lessonId);

  updateTotalQuestion(elements.length);
  return List.of(elements);
}

Future<List<QuestionResponse>> fetchSentenceUnscrambleQuestions(
    WidgetRef ref, int lessonId, Function(int) updateTotalQuestion) async {
  List<QuestionResponse> elements = await ref
      .watch(exerciseServiceProvider)
      .getListSentenceUnscrambleQuestion(lessonId);

  updateTotalQuestion(elements.length);
  return List.of(elements);
}

Future<List<QuestionResponse>> fetchSentenceTransformationQuestions(
    WidgetRef ref, int lessonId, Function(int) updateTotalQuestion) async {
  List<QuestionResponse> elements = await ref
      .watch(exerciseServiceProvider)
      .getListSentenceTransformationQuestion(lessonId);

  updateTotalQuestion(elements.length);
  return List.of(elements);
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
