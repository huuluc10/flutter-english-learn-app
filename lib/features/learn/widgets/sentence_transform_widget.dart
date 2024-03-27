import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_englearn/model/answer.dart';
import 'package:flutter_englearn/model/explanation_question.dart';
import 'package:flutter_englearn/model/lesson_question_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SentenceTransformWidget extends ConsumerStatefulWidget {
  const SentenceTransformWidget({
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

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SentenceTransformWidgetState();
}

class _SentenceTransformWidgetState
    extends ConsumerState<SentenceTransformWidget> {
  Future<Answer> _fetchAnswer(int questionId) async {
    return await Future.delayed(
        const Duration(seconds: 0),
        () => Answer(
              answers: [],
              correctAnswer: 'xin chào',
              explanation:
                  'Explanation Answer 2 Explanation Answer 2.\nExplanation Answer 2 Explanation Answer 2  ',
            ));
  }

  List<String> getWords(String sentence) {
    return sentence.split(' ');
  }

  List<String> listWordIsChosen = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Sắp xếp từ để tạo thành câu đúng nghĩa',
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
            height: widget.height * 0.75,
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
                    maxHeight: widget.height * 0.30,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            widget.question.questionContent,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Row(
                            children: [
                              Text(
                                'Câu trả lời: ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                              ),
                              itemCount: listWordIsChosen.length,
                              itemBuilder: (context, index) {
                                String word = listWordIsChosen[index];
                                return Container(
                                  margin: const EdgeInsets.only(left: 3),
                                  padding: const EdgeInsets.all(3),
                                  height: 80, // Add this
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      word,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
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
                    height: widget.height * 0.35,
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: FutureBuilder<Answer>(
                        future: _fetchAnswer(widget.question.questionId),
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
                          List<String> words = getWords(answer.correctAnswer);
                          // Remove word is chosen
                          for (String word in listWordIsChosen) {
                            words.remove(word);
                          }

                          // Shuffle words
                          words.shuffle();

                          if (words.isEmpty) {
                            // Concat list word is chosen to create answer
                            String stringAnswer = listWordIsChosen.join(' ');
                            if (stringAnswer == answer.correctAnswer) {
                              widget.inCreaseCorrectAnswerCount();
                            } else {
                              widget.addExplanationQuestion(
                                ExplanationQuestion(
                                  question: widget.question.questionContent,
                                  answer: answer.correctAnswer,
                                  explanation: answer.explanation,
                                ),
                              );
                            }
                            widget.updateCurrentIndex();
                          }
                          return GridView.count(
                            crossAxisCount: 3,
                            childAspectRatio: 3,
                            children: List.of(
                              words.map(
                                (e) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        words.remove(e);
                                        listWordIsChosen.add(e);
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 5),
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: Text(
                                          e,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
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
