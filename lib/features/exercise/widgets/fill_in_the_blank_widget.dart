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

  String? correctAnswer;
  String? explanation;

  void changeQuestion(String question) {
    if (controller.text.isEmpty || controller.text.trim() == '') {
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
          backgroundColor: Color.fromARGB(255, 233, 233, 233),
        ),
      );
    } else {
      List<String> correctAnswers = correctAnswer!.split('/');
      if (correctAnswers.contains(controller.text.trim())) {
        widget.inCreaseCorrectAnswerCount();
      } else {
        widget.addExplanationQuestion(
          ExplanationQuestion(
            question: question,
            questionImage: null,
            answer: correctAnswer!,
            answerImage: null,
            explanation: explanation,
          ),
        );
      }
      widget.updateCurrentIndex();
      controller.clear();
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
