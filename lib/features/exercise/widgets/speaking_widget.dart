import 'package:flutter/material.dart';
import 'package:flutter_englearn/model/answer.dart';
import 'package:flutter_englearn/model/explanation_question.dart';
import 'package:flutter_englearn/model/lesson_question_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SpeakingWidget extends ConsumerWidget {
  const SpeakingWidget({
    super.key,
    required this.height,
    required this.question,
    required this.updateCurrentIndex,
    required this.inCreaseCorrectAnswerCount,
    required this.addExplanationQuestion,
  });

  final double height;
  final Question question;
  final Function() updateCurrentIndex;
  final Function() inCreaseCorrectAnswerCount;
  final Function(ExplanationQuestion) addExplanationQuestion;

  Future<Answer> _fetchAnswer(int questionId) async {
    return await Future.delayed(
        const Duration(seconds: 0),
        () => Answer(
              answers: [],
              correctAnswer: 'Answer 2',
              explanation:
                  'Explanation Answer 2 Explanation Answer 2.\nExplanation Answer 2 Explanation Answer 2  ',
            ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const Text(
          'Luyện nói tiếng Anh',
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
                    maxHeight: height * 0.20,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            question.questionContent,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.volume_up),
                          ),
                        ],
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
                          return Padding(
                            padding: const EdgeInsets.all(14),
                            child: Center(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          'Nhấn vào biểu tượng bên cạnh để nói',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.mic),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: RichText(
                                          text: TextSpan(
                                            text: 'Từ phát âm của bạn: ',
                                            style: DefaultTextStyle.of(context)
                                                .style,
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text:
                                                      '${answer.answers.isEmpty ? 'Chưa có' : answer.answers.first}',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.volume_up),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
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
