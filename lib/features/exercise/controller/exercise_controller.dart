import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/exercise/pages/result_exercise_screen.dart';
import 'package:flutter_englearn/features/exercise/provider/exercise_provider.dart';
import 'package:flutter_englearn/model/answer.dart';
import 'package:flutter_englearn/model/explanation_question.dart';
import 'package:flutter_englearn/model/response/question_response.dart';
import 'package:flutter_englearn/utils/helper/helper.dart';
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

Future<List<QuestionResponse>> fetchListeningQuestions(
    WidgetRef ref, int lessonId, Function(int) updateTotalQuestion) async {
  List<QuestionResponse> elements = await ref
      .watch(exerciseServiceProvider)
      .getListListeningQuestion(lessonId);

  updateTotalQuestion(elements.length);
  return List.of(elements);
}

Future<List<QuestionResponse>> fetchSpeakingQuestions(
    WidgetRef ref, int lessonId, Function(int) updateTotalQuestion) async {
  List<QuestionResponse> elements = await ref
      .watch(exerciseServiceProvider)
      .getListSpeakingQuestion(lessonId);

  updateTotalQuestion(elements.length);
  return List.of(elements);
}

Future<List<QuestionResponse>> fetchExamQuestion(
    WidgetRef ref, int examId, Function(int) updateTotalQuestion) async {
  List<QuestionResponse> elements =
      await ref.watch(exerciseServiceProvider).getExamQuestion(examId);

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

List<String> getWordsTransform(String sentence) {
  List<String> words = sentence.split(' ');
  words.shuffle();
  return words;
}

List<String> getWordsUnscramble(String sentence) {
  List<String> words = sentence.split('/');
  words.shuffle();
  return words;
}

void logEvent(String eventDescription) {
  var eventTime = DateTime.now().toIso8601String();
  debugPrint('$eventTime $eventDescription');
}

void changeSpeakingQuestion(
  BuildContext context,
  String pronounce,
  Function inCreaseCorrectAnswerCount,
  Function addExplanationQuestion,
  Function updateCurrentIndex,
  Answer answer,
) {
  String correctAnswer = answer.correctAnswer!;
  if (pronounce == '') {
    showSnackBar(context, 'Vui lòng nói từ bạn đã nghe');
  } else {
    if (pronounce.toLowerCase() == correctAnswer.toLowerCase()) {
      inCreaseCorrectAnswerCount();
    } else {
      addExplanationQuestion(
        ExplanationQuestion(
          question: answer.question,
          questionImage: answer.questionImage,
          answer: correctAnswer,
          answerImage: answer.correctImage,
          explanation: answer.explanation,
        ),
      );
    }
    if (context.mounted) {
      updateCurrentIndex();
    }
  }
}

Future<void> saveAnswerQuestion(
  BuildContext context,
  WidgetRef ref,
  int questionId,
  bool isCorrect,
) async {
  String? save = await ref
      .read(exerciseServiceProvider)
      .saveAnswerQuestion(questionId, isCorrect);

  if (save != null) {
    logEvent('Save answer question success');
  } else {
    logEvent('Save answer question failed');
    if (context.mounted) {
      showSnackBar(context, 'Lưu câu trả lời thất bại');
    }
  }
}
