import 'package:flutter/material.dart';
import 'package:flutter_englearn/common/utils/utils.dart';
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.of(questionTypes).map(
        (e) {
          if (e.questionTypeName == TypeQuestion.multipleChoice) {
            return MultichoiceExerciseWidget(lessonId: lessonId);
          } else if (e.questionTypeName == TypeQuestion.fillInBlank) {
            return FillInTheBlankExerciseWidget(lessonId: lessonId);
          } else if (e.questionTypeName ==
              TypeQuestion.sentenceTransformation) {
            return SenntenceTransformExcerciseWidget(lessonId: lessonId);
          } else if (e.questionTypeName == TypeQuestion.sentenceUnscramble) {
            return SentenceUnscrambleExerciseWidget(lessonId: lessonId);
          } else if (e.questionTypeName == TypeQuestion.listening) {
            return ListeningExerciseWidget(lessonId: lessonId);
          } else {
            return SpeakingExerciseWidget(lessonId: lessonId);
          }
        },
      ).toList(),
    );
  }
}
