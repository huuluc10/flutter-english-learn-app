import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/exercise/provider/exercise_provider.dart';
import 'package:flutter_englearn/model/answer.dart';
import 'package:flutter_englearn/model/explanation_question.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListeningWidget extends ConsumerStatefulWidget {
  const ListeningWidget({
    super.key,
    required this.height,
    required this.questionURL,
    required this.updateCurrentIndex,
    required this.inCreaseCorrectAnswerCount,
    required this.addExplanationQuestion,
  });

  final double height;
  final String questionURL;
  final Function() updateCurrentIndex;
  final Function() inCreaseCorrectAnswerCount;
  final Function(ExplanationQuestion) addExplanationQuestion;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ListeningWidgetState();
}

class _ListeningWidgetState extends ConsumerState<ListeningWidget> {
  Future<Answer> _fetchAnswer() async {
    return ref
        .watch(exerciseServiceProvider)
        .getAnswer(widget.questionURL);
  }

  String _selectedAnswer = '';
  String? correctAnswer;
  String? explanation;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Luyện nghe tiếng Anh',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: SizedBox(
            height: widget.height * 0.8,
            child: FutureBuilder<Answer>(
                future: _fetchAnswer(),
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
                  Answer answer = snapshot.data!;
                  correctAnswer = answer.correctAnswer;
                  explanation = answer.explanation;

                  // Remove word is chosen
                  if (_selectedAnswer != '') {
                    answer.answers.removeWhere(
                        (element) => element.text == _selectedAnswer);
                  }
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
                          minHeight: 150,
                          maxHeight: widget.height * 0.25,
                        ),
                        child: Column(
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      answer.question,
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
                            const Divider(
                              color: Colors.black,
                              height: 20,
                              thickness: 1,
                              indent: 20,
                              endIndent: 20,
                            ),
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    'Từ bạn nghe được:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selectedAnswer = '';
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: _selectedAnswer != ''
                                        ? Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              _selectedAnswer,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                          ],
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
                          height: widget.height * 0.28,
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: GridView.count(
                              crossAxisCount: 3,
                              childAspectRatio: 3.2,
                              mainAxisSpacing: 5,
                              children: List.of(
                                answer.answers.map(
                                  (e) {
                                    return InkWell(
                                      onTap: () {
                                        if (_selectedAnswer == '') {
                                          setState(() {
                                            _selectedAnswer = e.text!;
                                          });
                                        }
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 5),
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Center(
                                          child: Text(
                                            e.text!,
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
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_selectedAnswer == '') {
                              // show SnackBar
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Vui lòng chọn câu trả lời',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  backgroundColor:
                                      Color.fromARGB(255, 233, 233, 233),
                                ),
                              );
                            } else {
                              if (_selectedAnswer == correctAnswer) {
                                widget.inCreaseCorrectAnswerCount();
                              } else {
                                widget.addExplanationQuestion(
                                  ExplanationQuestion(
                                    question: answer.question,
                                    answer: correctAnswer!,
                                    answerImage: answer.questionImage,
                                    explanation: explanation,
                                  ),
                                );
                              }
                              widget.updateCurrentIndex();
                            }
                          },
                          child: const Text('Tiếp tục'),
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ),
      ],
    );
  }
}
