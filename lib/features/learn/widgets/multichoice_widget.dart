import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/learn/widgets/answer_choice_widget.dart';
import 'package:flutter_englearn/model/answer.dart';
import 'package:flutter_englearn/model/answer_choice.dart';
import 'package:flutter_englearn/model/lesson_question_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MultichoiceWidget extends ConsumerWidget {
  const MultichoiceWidget({
    super.key,
    required this.height,
    required this.question,
    required this.updateCurrentIndex,
    required this.inCreaseCorrectAnswerCount,
  });

  final double height;
  final Question question;
  final Function() updateCurrentIndex;
  final Function() inCreaseCorrectAnswerCount;

  Future<Answer> _fetchAnswer(int questionId) async {
    return await Future.delayed(
        const Duration(seconds: 0),
        () => Answer(
              answers: [
                AnswerChoice(
                    text: 'Answer 1 2 Answer 1 Answer 1 Answer 1Answer 1'),
                AnswerChoice(text: 'Answer 2'),
                AnswerChoice(text: 'Answer 3'),
                AnswerChoice(text: 'Answer 4'),
              ],
              correctAnswer: 'Answer 2',
              explanation: null,
            ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const Text(
          'Chọn đáp án đúng',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: SizedBox(
            height: height * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 233, 233, 233),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: BoxConstraints(
                    minHeight: 150,
                    maxHeight: height * 0.25,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        question.questionContent,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    left: 10,
                    bottom: 5,
                    right: 10,
                  ),
                  child: SizedBox(
                    height: height * 0.46,
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: FutureBuilder<Answer>(
                        future: _fetchAnswer(question.questionId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text('Error'),
                            );
                          }
                          Answer answer = snapshot.data!;
                          return AnswerChoiceWidget(
                            answer: answer,
                            updateCurrentIndex: updateCurrentIndex,
                            increaseCorrectAnswerCount:
                                inCreaseCorrectAnswerCount,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
