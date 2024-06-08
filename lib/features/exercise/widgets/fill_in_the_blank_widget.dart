import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/exercise/controller/exercise_controller.dart';
import 'package:flutter_englearn/features/exercise/provider/exercise_provider.dart';
import 'package:flutter_englearn/model/answer.dart';
import 'package:flutter_englearn/model/explanation_question.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FillInTheBlankWidget extends ConsumerStatefulWidget {
  const FillInTheBlankWidget({
    super.key,
    required this.height,
    required this.questionId,
    required this.questionURl,
    required this.updateCurrentIndex,
    required this.inCreaseCorrectAnswerCount,
    required this.addExplanationQuestion,
    required this.makeFor,
  });

  final double height;
  final int questionId;
  final String questionURl;
  final Function() updateCurrentIndex;
  final Function() inCreaseCorrectAnswerCount;
  final Function(ExplanationQuestion) addExplanationQuestion;
  final String makeFor;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FillInTheBlankWidgetState();
}

class _FillInTheBlankWidgetState extends ConsumerState<FillInTheBlankWidget> {
  Future<Answer> _fetchAnswer() async {
    return await ref
        .watch(exerciseServiceProvider)
        .getAnswer(widget.questionURl);
  }

  String? correctAnswer;
  String? explanation;

  void changeQuestion(String question) async {
    int correctAnswerStreak = ref.watch(userProgressProvider);
    List<String> correctAnswers = correctAnswer!.split('/');
    if (correctAnswers.contains(controller.text.trim())) {
      ref.read(userProgressProvider.notifier).state = correctAnswerStreak + 1;
      await saveAnswerQuestion(
          context, ref, widget.questionId, widget.makeFor, true);
      widget.inCreaseCorrectAnswerCount();
    } else {
      ref.read(userProgressProvider.notifier).state = 0;
      await saveAnswerQuestion(
          context, ref, widget.questionId, widget.makeFor, false);
    }
    widget.addExplanationQuestion(
      ExplanationQuestion(
          question: question,
          questionImage: null,
          answer: correctAnswer!,
          answerImage: null,
          selectedAnswer: controller.text.trim(),
          selectedAnswerImage: null,
          explanation: explanation,
          isCorrect: correctAnswers.contains(controller.text.trim())),
    );
    widget.updateCurrentIndex();
    controller.clear();

    correctAnswerStreak = ref.watch(userProgressProvider);

    if (correctAnswerStreak % 5 == 0) {
      showCorrectAnswerStreakPopup(context, correctAnswerStreak);
    }
  }

  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Điền từ còn thiếu vào chỗ trống',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: SizedBox(
            // height: widget.height * 0.75,
            child: FutureBuilder<Answer>(
              future: _fetchAnswer(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error fetching questions!: ${snapshot.error}'),
                  );
                }
                Answer answer = snapshot.data!;
                correctAnswer = answer.correctAnswer;
                explanation = answer.explanation;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 233, 233, 233),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: BoxConstraints(
                        minHeight: 120,
                        maxHeight: widget.height * 0.30,
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                answer.question,
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Câu trả lời: ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      controller: controller,
                                      onSubmitted: (value) {
                                        changeQuestion(answer.question);
                                      },
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          changeQuestion(answer.question);
                        },
                        child: const Text('Tiếp tục'),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
