import 'package:flutter/material.dart';
import 'package:flutter_englearn/common/utils/utils.dart';
import 'package:flutter_englearn/features/exercise/controller/exercise_controller.dart';
import 'package:flutter_englearn/features/exercise/provider/exercise_provider.dart';
import 'package:flutter_englearn/features/exercise/widgets/fill_in_the_blank_widget.dart';
import 'package:flutter_englearn/features/exercise/widgets/listening_widget.dart';
import 'package:flutter_englearn/features/exercise/widgets/multichoice_widget.dart';
import 'package:flutter_englearn/features/exercise/widgets/sentence_widget.dart';
import 'package:flutter_englearn/features/exercise/widgets/speaking_widget.dart';
import 'package:flutter_englearn/model/explanation_question.dart';
import 'package:flutter_englearn/model/response/question_response.dart';
import 'package:flutter_englearn/common/helper/helper.dart';
import 'package:flutter_englearn/common/widgets/future_builder_error_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class ExamScreen extends ConsumerStatefulWidget {
  const ExamScreen({
    super.key,
    required this.examId,
    required this.duration,
    required this.onMarkAsDone,
    required this.exp,
  });

  static const String routeName = '/exam-screen';

  final int examId;
  final int duration;
  final Function(double) onMarkAsDone;
  final int exp;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExamScreenState();
}

class _ExamScreenState extends ConsumerState<ExamScreen> {
  final CountDownController _controller = CountDownController();
  List<String> typeNameQuestions = [];
  List<QuestionResponse> questions = [];

  Future<List<QuestionResponse>> _fetchQuestions() async {
    if (questions.isNotEmpty) {
      return questions;
    } else {
      questions = await ref
          .watch(exerciseServiceProvider)
          .getExamQuestion(widget.examId);
      for (var i = 0; i < questions.length; i++) {
        await ref
            .watch(exerciseServiceProvider)
            .getQuestionType(questions[i].questionTypeId)
            .then((value) {
          typeNameQuestions.add(value);
        });
      }
      _correctAnswerCount = 0;
      _totalQuestionCount = questions.length;
      return questions;
    }
  }

  @override
  void dispose() {
    super.dispose();
    typeNameQuestions = [];
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
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return PopScope(
      canPop: false,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        extendBody: true,
        appBar: AppBar(
          leading: null,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: <Widget>[
            FutureBuilder<List<QuestionResponse>>(
              future: _fetchQuestions(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return FutureBuilderErrorWidget(
                    error: snapshot.error.toString(),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LinearPercentIndicator(
                                lineHeight: 22.0,
                                width: width - 100,
                                percent: value / snapshot.data!.length,
                                center: Text(
                                  "${(value / snapshot.data!.length * 100).toStringAsFixed(2)} %",
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
                              CircularCountDownTimer(
                                duration: widget.duration,
                                controller: _controller,
                                isReverse: true,
                                isReverseAnimation: true,
                                width: 50,
                                height: 50,
                                fillColor: Colors.blue,
                                ringColor: Colors.grey,
                                onComplete: () async {
                                  showSnackBar(context, 'Hết giờ làm bài!');
                                  for (var i = value;
                                      i < snapshot.data!.length;
                                      i++) {
                                    await saveAnswerQuestion(
                                        context,
                                        ref,
                                        snapshot.data![i].questionId,
                                        "EXAM",
                                        false);
                                  }
                                  clearSnackBar(context);
                                  updateCurrentIndexQuestion(
                                    context,
                                    ref,
                                    () {
                                      currentIndexQuestion.value =
                                          _totalQuestionCount - 1;
                                    },
                                    () async {
                                      await increaseExpAfterExam(
                                          context,
                                          ref,
                                          widget.exp,
                                          _correctAnswerCount,
                                          _totalQuestionCount);
                                    },
                                    _totalQuestionCount - 1,
                                    _totalQuestionCount,
                                    [
                                      _correctAnswerCount,
                                      _totalQuestionCount,
                                      [],
                                      TypeQuestion.fillInBlank
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      typeNameQuestions[value] == TypeQuestion.multipleChoice
                          ? MultichoiceWidget(
                              height: height,
                              updateCurrentIndex: () {
                                updateCurrentIndexQuestion(
                                  context,
                                  ref,
                                  () {
                                    currentIndexQuestion.value++;
                                  },
                                  () async {
                                    await increaseExpAfterExam(
                                        context,
                                        ref,
                                        widget.exp,
                                        _correctAnswerCount,
                                        _totalQuestionCount);
                                  },
                                  value,
                                  _totalQuestionCount,
                                  [
                                    _correctAnswerCount,
                                    _totalQuestionCount,
                                    [],
                                    TypeQuestion.multipleChoice,
                                  ],
                                );
                              },
                              inCreaseCorrectAnswerCount:
                                  inCreaseCorrectAnswerCount,
                              questionId: snapshot.data![value].questionId,
                              questionURL: snapshot.data![value].answerFileURL,
                              addExplanationQuestion: addExplanationQuestion,
                              makeFor: "EXAM",
                            )
                          : typeNameQuestions[value] == TypeQuestion.fillInBlank
                              ? FillInTheBlankWidget(
                                  height: height,
                                  updateCurrentIndex: () {
                                    updateCurrentIndexQuestion(
                                      context,
                                      ref,
                                      () {
                                        currentIndexQuestion.value++;
                                      },
                                      () async {
                                        await increaseExpAfterExam(
                                            context,
                                            ref,
                                            widget.exp,
                                            _correctAnswerCount,
                                            _totalQuestionCount);
                                      },
                                      value,
                                      _totalQuestionCount,
                                      [
                                        _correctAnswerCount,
                                        _totalQuestionCount,
                                        [],
                                        TypeQuestion.fillInBlank
                                      ],
                                    );
                                  },
                                  questionId: snapshot.data![value].questionId,
                                  questionURl:
                                      snapshot.data![value].answerFileURL,
                                  inCreaseCorrectAnswerCount:
                                      inCreaseCorrectAnswerCount,
                                  addExplanationQuestion:
                                      addExplanationQuestion,
                                  makeFor: "EXAM",
                                )
                              : typeNameQuestions[value] ==
                                      TypeQuestion.sentenceTransformation
                                  ? SentenceWidget(
                                      isUnscrambl: false,
                                      height: height,
                                      updateCurrentIndex: () {
                                        updateCurrentIndexQuestion(
                                          context,
                                          ref,
                                          () => currentIndexQuestion.value++,
                                          () async {
                                            await increaseExpAfterExam(
                                                context,
                                                ref,
                                                widget.exp,
                                                _correctAnswerCount,
                                                _totalQuestionCount);
                                          },
                                          value,
                                          _totalQuestionCount,
                                          [
                                            _correctAnswerCount,
                                            _totalQuestionCount,
                                            [],
                                            TypeQuestion.sentenceTransformation,
                                          ],
                                        );
                                      },
                                      questionId:
                                          snapshot.data![value].questionId,
                                      questionURL:
                                          snapshot.data![value].answerFileURL,
                                      inCreaseCorrectAnswerCount:
                                          inCreaseCorrectAnswerCount,
                                      addExplanationQuestion:
                                          addExplanationQuestion,
                                      makeFor: "EXAM",
                                    )
                                  : typeNameQuestions[value] ==
                                          TypeQuestion.sentenceUnscramble
                                      ? SentenceWidget(
                                          isUnscrambl: true,
                                          height: height,
                                          updateCurrentIndex: () {
                                            updateCurrentIndexQuestion(
                                              context,
                                              ref,
                                              () {
                                                currentIndexQuestion.value++;
                                              },
                                              () async {
                                                await increaseExpAfterExam(
                                                    context,
                                                    ref,
                                                    widget.exp,
                                                    _correctAnswerCount,
                                                    _totalQuestionCount);
                                              },
                                              value,
                                              _totalQuestionCount,
                                              [
                                                _correctAnswerCount,
                                                _totalQuestionCount,
                                                [],
                                                TypeQuestion.sentenceUnscramble,
                                              ],
                                            );
                                          },
                                          questionId:
                                              snapshot.data![value].questionId,
                                          questionURL: snapshot
                                              .data![value].answerFileURL,
                                          inCreaseCorrectAnswerCount:
                                              inCreaseCorrectAnswerCount,
                                          addExplanationQuestion:
                                              addExplanationQuestion,
                                          makeFor: "EXAM",
                                        )
                                      : typeNameQuestions[value] ==
                                              TypeQuestion.speaking
                                          ? SpeakingWidget(
                                              height: height,
                                              updateCurrentIndex: () {
                                                updateCurrentIndexQuestion(
                                                  context,
                                                  ref,
                                                  () {
                                                    currentIndexQuestion
                                                        .value++;
                                                  },
                                                  () async {
                                                    await increaseExpAfterExam(
                                                        context,
                                                        ref,
                                                        widget.exp,
                                                        _correctAnswerCount,
                                                        _totalQuestionCount);
                                                  },
                                                  value,
                                                  _totalQuestionCount,
                                                  [
                                                    _correctAnswerCount,
                                                    _totalQuestionCount,
                                                    [],
                                                    TypeQuestion.speaking,
                                                  ],
                                                );
                                              },
                                              questionId: snapshot
                                                  .data![value].questionId,
                                              questionURL: snapshot
                                                  .data![value].answerFileURL,
                                              inCreaseCorrectAnswerCount:
                                                  inCreaseCorrectAnswerCount,
                                              addExplanationQuestion:
                                                  addExplanationQuestion,
                                              makeFor: "EXAM",
                                            )
                                          : ListeningWidget(
                                              height: height,
                                              updateCurrentIndex: () {
                                                updateCurrentIndexQuestion(
                                                    context,
                                                    ref,
                                                    () => {
                                                          currentIndexQuestion
                                                              .value++
                                                        }, () async {
                                                  await increaseExpAfterExam(
                                                      context,
                                                      ref,
                                                      widget.exp,
                                                      _correctAnswerCount,
                                                      _totalQuestionCount);
                                                }, value, _totalQuestionCount, [
                                                  _correctAnswerCount,
                                                  _totalQuestionCount,
                                                  [],
                                                  TypeQuestion.listening,
                                                ]);
                                              },
                                              questionId: snapshot
                                                  .data![value].questionId,
                                              questionURL: snapshot
                                                  .data![value].answerFileURL,
                                              inCreaseCorrectAnswerCount:
                                                  inCreaseCorrectAnswerCount,
                                              addExplanationQuestion:
                                                  addExplanationQuestion,
                                              makeFor: "EXAM",
                                            ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
