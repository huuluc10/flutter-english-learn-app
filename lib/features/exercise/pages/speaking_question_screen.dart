import 'package:flutter/material.dart';
import 'package:flutter_englearn/common/utils/utils.dart';
import 'package:flutter_englearn/features/exercise/controller/exercise_controller.dart';
import 'package:flutter_englearn/features/exercise/widgets/speaking_widget.dart';
import 'package:flutter_englearn/model/explanation_question.dart';
import 'package:flutter_englearn/model/response/question_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SpeakingQuestionScreen extends ConsumerStatefulWidget {
  const SpeakingQuestionScreen({
    super.key,
    required this.questions,
  });

  static const String routeName = '/speaking-question-screen';

  final List<QuestionResponse> questions;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SpeakingQuestionScreenState();
}

class _SpeakingQuestionScreenState
    extends ConsumerState<SpeakingQuestionScreen> {
  List<QuestionResponse>? questions;

  void inCreaseCorrectAnswerCount() {
    _correctAnswerCount++;
  }

  void addExplanationQuestion(ExplanationQuestion explanationQuestion) {
    _explanationQuestions.add(explanationQuestion);
  }

  int _correctAnswerCount = 0;
  int _totalQuestionCount = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _totalQuestionCount = widget.questions.length;
      setState(() {});
    });
  }

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
        body: ValueListenableBuilder<int>(
          valueListenable: currentIndexQuestion,
          builder: (context, value, child) => Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: LinearPercentIndicator(
                        lineHeight: 22.0,
                        percent: value / widget.questions.length,
                        center: Text(
                          "${(value / widget.questions.length * 100).toStringAsFixed(2)} %",
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
                    updateCurrentIndex: () {
                      updateCurrentIndexQuestion(
                        context,
                        () {
                          currentIndexQuestion.value++;
                        },
                        value,
                        _totalQuestionCount,
                        [
                          _correctAnswerCount,
                          _totalQuestionCount,
                          _explanationQuestions,
                          TypeQuestion.speaking,
                        ],
                      );
                    },
                    questionId: widget.questions[value].questionId,
                    questionURL: widget.questions[value].answerFileURL,
                    inCreaseCorrectAnswerCount: inCreaseCorrectAnswerCount,
                    addExplanationQuestion: addExplanationQuestion,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
