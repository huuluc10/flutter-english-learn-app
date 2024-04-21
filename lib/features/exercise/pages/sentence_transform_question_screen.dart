import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/exercise/controller/exercise_controller.dart';
import 'package:flutter_englearn/features/exercise/widgets/sentence_widget.dart';
import 'package:flutter_englearn/model/explanation_question.dart';
import 'package:flutter_englearn/model/response/question_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SentenceTransformQuestionScreen extends ConsumerStatefulWidget {
  const SentenceTransformQuestionScreen({
    super.key,
    required this.lessonId,
  });

  static const String routeName = '/sentence-transform-question-screen';
  final int lessonId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SentenceTransformQuestionScreenState();
}

class _SentenceTransformQuestionScreenState
    extends ConsumerState<SentenceTransformQuestionScreen> {
  Future<List<QuestionResponse>> _fetchQuestions() async {
    return await fetchQuestions(
      ref,
      widget.lessonId,
      (totalQuestionCount) {
        _totalQuestionCount = totalQuestionCount;
      },
    );
  }

  void inCreaseCorrectAnswerCount() {
    _correctAnswerCount++;
  }

  void addExplanationQuestion(ExplanationQuestion explanationQuestion) {
    _explanationQuestions.add(explanationQuestion);
  }

  int _correctAnswerCount = 0;
  int _totalQuestionCount = 0;

  final List<ExplanationQuestion> _explanationQuestions = [];
  ValueNotifier<int> currentIndexQuestion = ValueNotifier<int>(0);
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
        body: FutureBuilder<List<QuestionResponse>>(
          future: _fetchQuestions(),
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
            return ValueListenableBuilder<int>(
              valueListenable: currentIndexQuestion,
              builder: (context, value, child) => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: LinearPercentIndicator(
                        lineHeight: 22.0,
                        percent: value / snapshot.data!.length,
                        center: Text(
                          "${value / snapshot.data!.length * 100}%",
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
                  SentenceWidget(
                    isUnscrambl: false,
                    height: height,
                    questionURL: snapshot.data![value].answerFileURL,
                    updateCurrentIndex: () {
                      updateCurrentIndexQuestion(
                        context,
                        () {
                          setState(() {
                            currentIndexQuestion.value++;
                          });
                        },
                        value,
                        _totalQuestionCount,
                        [
                          _correctAnswerCount,
                          _totalQuestionCount,
                          _explanationQuestions,
                        ],
                      );
                    },
                    inCreaseCorrectAnswerCount: inCreaseCorrectAnswerCount,
                    addExplanationQuestion: addExplanationQuestion,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
