import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/exercise/provider/exercise_provider.dart';
import 'package:flutter_englearn/features/exercise/widgets/answer_choice_widget.dart';
import 'package:flutter_englearn/model/answer.dart';
import 'package:flutter_englearn/model/explanation_question.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MultichoiceWidget extends ConsumerWidget {
  const MultichoiceWidget({
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
  Widget build(BuildContext context, WidgetRef ref) {
    Future<Answer> fetchAnswer() {
      return ref.read(exerciseServiceProvider).getAnswer(questionURL);
    }

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
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: FutureBuilder<Answer>(
                  future: fetchAnswer(),
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
                            maxHeight: height * 0.25,
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
                                  const SizedBox(height: 3),
                                  if (answer.questionImage != null)
                                    Image.network(
                                      answer.questionImage!,
                                      fit: BoxFit.cover,
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
                            child: AnswerChoiceWidget(
                              answer: answer,
                              updateCurrentIndex: updateCurrentIndex,
                              increaseCorrectAnswerCount:
                                  inCreaseCorrectAnswerCount,
                              addExplanationQuestion:
                                  (ExplanationQuestion explanationQuestion) {
                                ExplanationQuestion explanation =
                                    explanationQuestion;
                                addExplanationQuestion(explanation);
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
        ),
      ],
    );
  }
}
