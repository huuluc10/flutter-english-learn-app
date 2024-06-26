import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/exercise/pages/result_exercise_screen.dart';
import 'package:flutter_englearn/features/exercise/provider/exercise_provider.dart';
import 'package:flutter_englearn/model/answer.dart';
import 'package:flutter_englearn/model/explanation_question.dart';
import 'package:flutter_englearn/model/response/question_response.dart';
import 'package:flutter_englearn/common/helper/helper.dart';
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

void updateCurrentIndexQuestion(
    BuildContext context,
    Function() refresh,
    Function increaseExpAfterExam,
    int currentIndex,
    int totalQuestion,
    List<Object> arguments) async {
  if (currentIndex < totalQuestion - 1) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      refresh();
    });
  } else {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      increaseExpAfterExam();
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
  WidgetRef ref,
  int questionId,
  String makeFor,
  String pronounce,
  Function inCreaseCorrectAnswerCount,
  Function addExplanationQuestion,
  Function updateCurrentIndex,
  Answer answer,
) async {
  String correctAnswer = answer.correctAnswer!;
  if (pronounce == '') {
    showSnackBar(context, 'Vui lòng nói từ bạn đã nghe');
  } else {
    if (pronounce.toLowerCase() == correctAnswer.toLowerCase()) {
      await saveAnswerQuestion(context, ref, questionId, makeFor, true);
      inCreaseCorrectAnswerCount();
    } else {
      await saveAnswerQuestion(context, ref, questionId, makeFor, false);
    }
    if (context.mounted) {
      addExplanationQuestion(
        ExplanationQuestion(
          question: answer.question,
          questionImage: answer.questionImage,
          answer: correctAnswer,
          answerImage: answer.correctImage,
          selectedAnswer: pronounce,
          selectedAnswerImage: null,
          explanation: answer.explanation,
          isCorrect: answer.questionImage == answer.correctImage &&
              correctAnswer == pronounce,
        ),
      );
      updateCurrentIndex();
    }
  }
}

Future<void> saveAnswerQuestion(
  BuildContext context,
  WidgetRef ref,
  int questionId,
  String makeFor,
  bool isCorrect,
) async {
  String? save = await ref
      .read(exerciseServiceProvider)
      .saveAnswerQuestion(questionId, makeFor, isCorrect);

  if (save != null) {
    logEvent('Save answer question success');
  } else {
    logEvent('Save answer question failed');
    if (context.mounted) {
      showSnackBar(context, 'Lưu câu trả lời thất bại');
    }
  }
}

Future<void> increaseExpAfterExam(BuildContext context, WidgetRef ref,
    int expOfExam, int correctAnswer, int totalQuestion) async {
  await ref.watch(exerciseServiceProvider).increaseExpAfterCompletingExam(
      context, expOfExam, correctAnswer, totalQuestion);
}
