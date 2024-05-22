import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/exercise/controller/exercise_controller.dart';
import 'package:flutter_englearn/features/exercise/pages/multichoice_questions_screen.dart';
import 'package:flutter_englearn/common/widgets/custom_alert_dialog.dart';
import 'package:flutter_englearn/model/response/question_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MultichoiceExerciseWidget extends ConsumerStatefulWidget {
  const MultichoiceExerciseWidget({
    super.key,
    required this.lessonId,
  });

  final int lessonId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MultichoiceExerciseWidgetState();
}

class _MultichoiceExerciseWidgetState
    extends ConsumerState<MultichoiceExerciseWidget> {
  int _totalQuestionCount = 0;
  List<QuestionResponse> _questions = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _questions = await _fetchQuestions();
      setState(() {});
    });
  }

  Future<List<QuestionResponse>> _fetchQuestions() async {
    return await fetchMultipleChoiceQuestions(
      ref,
      widget.lessonId,
      (totalQuestionCount) {
        _totalQuestionCount = totalQuestionCount;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                content:
                    'Bạn có muốn dành 5 phút để hoàn thành? Bạn không thể thoát trong quá trình làm.',
                onConfirm: () => Navigator.pushNamed(
                  context,
                  MultichoiceQuestionScreen.routeName,
                  arguments: _questions,
                ),
              ),
            );
          },
          child: const Text('Bài tập trắc nghiệm'),
        ),
        Text('$_totalQuestionCount câu hỏi')
      ],
    );
  }
}
