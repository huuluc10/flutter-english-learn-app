import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/learn/widgets/fill_in_the_blank_item_exercise_widget.dart';
import 'package:flutter_englearn/features/learn/widgets/listening_exercise_item_widget.dart';
import 'package:flutter_englearn/features/learn/widgets/multichoice_exercies_item_widget.dart';
import 'package:flutter_englearn/features/learn/widgets/sentence_transform_exercise_item_widget.dart';
import 'package:flutter_englearn/features/learn/widgets/sentence_unscramble_item_exercise.dart';
import 'package:flutter_englearn/features/learn/widgets/speaking_item_widget.dart';
import 'package:flutter_englearn/model/question_type.dart';

class ListTypeExerciseWidget extends StatelessWidget {
  const ListTypeExerciseWidget({
    super.key,
    required this.lessonId,
    required this.questionTypes,
  });

  final List<QuestionType> questionTypes;
  final int lessonId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.of(questionTypes).map(
        (e) {
          if (e.questionTypeName == 'Multiple choice') {
            return MultichoiceExerciseWidget(
              lessonId: lessonId,
            );
          } else if (e.questionTypeName == 'Fill in the blank') {
            return FillInTheBlankExerciseWidget(
              lessonId: lessonId,
              isCompleted: 'no',
            );
          } else if (e.questionTypeName == 'Sentence transformation') {
            return SenntenceTransformExcerciseWidget(
              lessonId: lessonId,
              isCompleted: 'no',
            );
          } else if (e.questionTypeName == 'Sentence unscramble') {
            return SentenceUnscrambleExerciseWidget(
              lessonId: lessonId,
              isCompleted: 'no',
            );
          } else if (e.questionTypeName == 'Listening') {
            return ListeningExerciseWidget(
              lessonId: lessonId,
              isCompleted: 'no',
            );
          } else {
            return SpeakingExerciseWidget(
              lessonId: lessonId,
              isCompleted: 'no',
            );
          }
        },
      ).toList(),
    );
  }
}
