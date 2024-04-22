import 'package:flutter/material.dart';
import 'package:flutter_englearn/model/answer.dart';
import 'package:flutter_englearn/model/explanation_question.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerChoiceWidget extends ConsumerWidget {
  const AnswerChoiceWidget({
    super.key,
    required this.answer,
    required this.updateCurrentIndex,
    required this.increaseCorrectAnswerCount,
    required this.addExplanationQuestion,
  });

  final Answer answer;
  final Function() updateCurrentIndex;
  final Function() increaseCorrectAnswerCount;
  final Function(ExplanationQuestion) addExplanationQuestion;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 1.3,
      scrollDirection: Axis.vertical,
      mainAxisSpacing: 5,
      crossAxisSpacing: 5,
      shrinkWrap: true,
      children: List.generate(
        answer.answers!.length,
        (index) => TextButton(
          onPressed: () {
            // TODO: call API to save answer

            if (answer.answers![index].text != null &&
                answer.answers![index].text == answer.correctAnswer) {
              increaseCorrectAnswerCount();
            } else if (answer.answers![index].answerImage != null &&
                answer.answers![index].answerImage == answer.correctImage) {
              increaseCorrectAnswerCount();
            } else {
              addExplanationQuestion(
                ExplanationQuestion(
                  question: answer.question,
                  answer: answer.correctAnswer,
                  answerImage: answer.correctImage,
                  explanation: answer.explanation,
                ),
              );
            }
            updateCurrentIndex();
          },
          style: TextButton.styleFrom(
            disabledBackgroundColor: Colors.white,
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: answer.answers![index].text != null
              ? Text(
                  answer.answers![index].text!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  answer.answers![index].answerImage!,
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
        ),
      ),
    );
  }
}
