import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/exercise/pages/listening_question_screen.dart';
import 'package:flutter_englearn/common/widgets/custom_alert_dialog.dart';

class ListeningExerciseWidget extends StatelessWidget {
  const ListeningExerciseWidget({
    super.key,
    required this.lessonId,
  });

  final int lessonId;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Bài tập nghe'),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CustomAlertDialog(
            content:
                'Bạn có muốn dành 5 phút để hoàn thành? Bạn không thể thoát trong quá trình làm.',
            onConfirm: () => Navigator.pushNamed(
              context,
              ListeningQuestionScreen.routeName,
              arguments: lessonId,
            ),
          ),
        );
      },
    );
  }
}
