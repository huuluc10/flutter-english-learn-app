import 'package:flutter/material.dart';
import 'package:flutter_englearn/model/answer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerChoiceWidget extends ConsumerWidget {
  const AnswerChoiceWidget({
    super.key,
    required this.answer,
    required this.updateCurrentIndex,
    required this.inCreaseCorrectAnswerCount,
  });

  final Answer answer;
  final Function() updateCurrentIndex;
  final Function() inCreaseCorrectAnswerCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 1.3,
      mainAxisSpacing: 5,
      crossAxisSpacing: 5,
      shrinkWrap: true,
      children: List.generate(
        answer.answers.length,
        (index) => TextButton(
          onPressed: () {
            // TODO: call API to save answer
            if (answer.answers[index].text == answer.correctAnswer) {
              inCreaseCorrectAnswerCount();
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
          child: Text(
            answer.answers[index].text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
