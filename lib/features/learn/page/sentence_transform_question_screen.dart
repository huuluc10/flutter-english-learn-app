import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/learn/page/result_exercise_screen.dart';
import 'package:flutter_englearn/model/explanation_question.dart';
import 'package:flutter_englearn/model/lesson_question_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SentenceTransformQuestionScreen extends ConsumerStatefulWidget {
  const SentenceTransformQuestionScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SentenceTransformQuestionScreenState();
}

class _SentenceTransformQuestionScreenState
    extends ConsumerState<SentenceTransformQuestionScreen> {
  Future<List<Question>> _fetchQuestions(int lessonId) async {
    List<Question> elements = [];
    for (int i = 0; i < 10; i++) {
      elements.add(Question(
        questionId: i,
        questionContent: 'Question $i',
        questionType: 'multichoice',
        lessonId: lessonId,
        answerUrl: 'Answer $i',
      ));
    }

    _totalQuestionCount = elements.length;
    return await Future.delayed(
        const Duration(seconds: 0), () => List.of(elements));
  }

  void updateCurrentIndex() {
    if (_currentIndex < _totalQuestionCount - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      Navigator.pushNamed(
        context,
        ResultExerciseScreen.routeName,
        arguments: [
          _correctAnswerCount,
          _totalQuestionCount,
        ],
      );
    }
  }

  void inCreaseCorrectAnswerCount() {
    _correctAnswerCount++;
  }

  int _currentIndex = 0;
  int _correctAnswerCount = 0;
  int _totalQuestionCount = 0;

  List<ExplanationQuestion> _explanationQuestions = [];
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          leading: null,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [],
        ),
      ),
    );
  }
}
