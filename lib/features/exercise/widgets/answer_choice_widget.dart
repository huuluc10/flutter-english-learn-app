import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/exercise/controller/exercise_controller.dart';
import 'package:flutter_englearn/features/exercise/provider/exercise_provider.dart';
import 'package:flutter_englearn/model/answer.dart';
import 'package:flutter_englearn/model/explanation_question.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_grid/responsive_grid.dart';

class AnswerChoiceWidget extends ConsumerWidget {
  const AnswerChoiceWidget({
    super.key,
    required this.questionId,
    required this.answer,
    required this.updateCurrentIndex,
    required this.increaseCorrectAnswerCount,
    required this.addExplanationQuestion,
    required this.makeFor,
  });

  final int questionId;
  final Answer answer;
  final Function() updateCurrentIndex;
  final Function() increaseCorrectAnswerCount;
  final Function(ExplanationQuestion) addExplanationQuestion;
  final String makeFor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ResponsiveGridList(
      desiredItemWidth: MediaQuery.of(context).size.width * 0.4,
      minSpacing: 10,
      children: List.generate(
        answer.answers!.length,
        (index) => TextButton(
          onPressed: () async {
            int correctAnswerStreak = ref.watch(userProgressProvider);

            if (answer.answers![index].text != null &&
                answer.answers![index].text == answer.correctAnswer) {
              ref.read(userProgressProvider.notifier).state =
                  correctAnswerStreak + 1;
              increaseCorrectAnswerCount();
              await saveAnswerQuestion(context, ref, questionId, makeFor, true);
            } else if (answer.answers![index].answerImage != null &&
                answer.answers![index].answerImage == answer.correctImage) {
              ref.read(userProgressProvider.notifier).state =
                  correctAnswerStreak + 1;
              increaseCorrectAnswerCount();
              await saveAnswerQuestion(context, ref, questionId, makeFor, true);
            } else {
              ref.read(userProgressProvider.notifier).state = 0;
              await saveAnswerQuestion(
                  context, ref, questionId, makeFor, false);
            }
            addExplanationQuestion(
              ExplanationQuestion(
                question: answer.question,
                questionImage: answer.questionImage,
                answer: answer.correctAnswer,
                answerImage: answer.correctImage,
                selectedAnswer: answer.answers![index].text,
                selectedAnswerImage: answer.answers![index].answerImage,
                explanation: answer.explanation,
                isCorrect: answer.answers![index].text ==
                        answer.correctAnswer &&
                    answer.answers![index].answerImage == answer.correctImage,
              ),
            );
            updateCurrentIndex();

            correctAnswerStreak = ref.watch(userProgressProvider);

            if (correctAnswerStreak % 5 == 0) {
              showCorrectAnswerStreakPopup(context, correctAnswerStreak);
            }
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
              : CachedNetworkImage(
                  imageUrl: answer.answers![index].answerImage!,
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
        ),
      ),
    );
  }
}
