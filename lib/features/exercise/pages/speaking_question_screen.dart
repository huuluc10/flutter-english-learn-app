import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/exercise/pages/result_exercise_screen.dart';
import 'package:flutter_englearn/features/exercise/widgets/speaking_widget.dart';
import 'package:flutter_englearn/model/explanation_question.dart';
import 'package:flutter_englearn/model/lesson_question_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SpeakingQuestionScreen extends ConsumerStatefulWidget {
  const SpeakingQuestionScreen({
    super.key,
    required this.lessonId,
  });

  static const String routeName = '/speaking-question-screen';

  final int lessonId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SpeakingQuestionScreenState();
}

class _SpeakingQuestionScreenState
    extends ConsumerState<SpeakingQuestionScreen> {
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
          _explanationQuestions,
        ],
      );
    }
  }

  void inCreaseCorrectAnswerCount() {
    _correctAnswerCount++;
  }

  void addExplanationQuestion(ExplanationQuestion explanationQuestion) {
    _explanationQuestions.add(explanationQuestion);
  }

  int _currentIndex = 0;
  int _correctAnswerCount = 0;
  int _totalQuestionCount = 0;
  List<ExplanationQuestion> _explanationQuestions = [];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
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
          children: [
            FutureBuilder<List<Question>>(
              future: _fetchQuestions(widget.lessonId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error'),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: LinearPercentIndicator(
                          lineHeight: 22.0,
                          percent: _currentIndex / snapshot.data!.length,
                          center: Text(
                            "${_currentIndex / snapshot.data!.length * 100}%",
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          barRadius: const Radius.circular(20),
                          backgroundColor: Colors.grey,
                          progressColor: Colors.blue,
                        ),
                      ),
                    ),
                    SpeakingWidget(
                      height: height,
                      question: snapshot.data![_currentIndex],
                      updateCurrentIndex: updateCurrentIndex,
                      inCreaseCorrectAnswerCount: inCreaseCorrectAnswerCount,
                      addExplanationQuestion: addExplanationQuestion,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
