import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/exercise/pages/multichoice_questions_screen.dart';
import 'package:flutter_englearn/utils/widgets/custom_alert_dialog.dart';

class MultichoiceExerciseWidget extends StatelessWidget {
  const MultichoiceExerciseWidget({
    super.key,
    required this.lessonId,
    required this.isCompleted,
  });

  final int lessonId;
  final String isCompleted;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Bài tập trắc nghiệm'),
      trailing: isCompleted == 'true'
          ? const Icon(
              Icons.check,
              color: Colors.green,
            )
          : null,
      onTap: isCompleted == 'true'
          ? () {}
          : () {
              showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                  content:
                      'Bạn có muốn dành 5 phút để hoàn thành? Bạn không thể thoát trong quá trình làm.',
                  onConfirm: () => Navigator.pushNamed(
                    context,
                    MultichoiceQuestionScreen.routeName,
                    arguments: lessonId,
                  ),
                ),
              );
            },
    );
  }
}
