import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/exercise/provider/exercise_provider.dart';
import 'package:flutter_englearn/model/answer.dart';
import 'package:flutter_englearn/model/explanation_question.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FillInTheBlankWidget extends ConsumerStatefulWidget {
  const FillInTheBlankWidget({
    super.key,
    required this.height,
    required this.questionURl,
    required this.updateCurrentIndex,
    required this.inCreaseCorrectAnswerCount,
    required this.addExplanationQuestion,
  });

  final double height;
  final String questionURl;
  final Function() updateCurrentIndex;
  final Function() inCreaseCorrectAnswerCount;
  final Function(ExplanationQuestion) addExplanationQuestion;

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

  String? wordIsChosen;
  String? correctAnswer;
  String? explanation;

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
            height: widget.height * 0.75,
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
                if (wordIsChosen != null) {
                  answer.answers
                      .removeWhere((element) => element.text == wordIsChosen);
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
                                  InkWell(
                                    onTap: () => setState(() {
                                      wordIsChosen = null;
                                    }),
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: Text(
                                          wordIsChosen ?? '',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
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
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        left: 10,
                        bottom: 5,
                        right: 10,
                      ),
                      child: SizedBox(
                        height: widget.height * 0.28,
                        child: GridView.count(
                          crossAxisCount: 3,
                          childAspectRatio: 3.2,
                          mainAxisSpacing: 5,
                          children: List.of(
                            answer.answers[0].text!.split('/').map(
                              (e) {
                                return InkWell(
                                  onTap: () {
                                    if (wordIsChosen == null) {
                                      setState(() {
                                        wordIsChosen = e;
                                      });
                                    }
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
                        ),
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (wordIsChosen == null || wordIsChosen == '') {
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
                            if (wordIsChosen == correctAnswer) {
                              widget.inCreaseCorrectAnswerCount();
                            } else {
                              widget.addExplanationQuestion(
                                ExplanationQuestion(
                                  question: answer.question,
                                  answer: correctAnswer!,
                                  answerImage: null,
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
              },
            ),
          ),
        ),
      ],
    );
  }
}
