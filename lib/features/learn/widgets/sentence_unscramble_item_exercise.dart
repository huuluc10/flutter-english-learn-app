import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/exercise/controller/exercise_controller.dart';
import 'package:flutter_englearn/features/exercise/pages/sentence_unscramble_question_screen.dart';
import 'package:flutter_englearn/common/widgets/custom_alert_dialog.dart';
import 'package:flutter_englearn/model/response/question_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SentenceUnscrambleExerciseWidget extends ConsumerStatefulWidget {
  const SentenceUnscrambleExerciseWidget({
    super.key,
    required this.lessonId,
  });

  final int lessonId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SentenceUnscrambleExerciseWidgetState();
}

class _SentenceUnscrambleExerciseWidgetState
    extends ConsumerState<SentenceUnscrambleExerciseWidget> {
  int _totalQuestionCount = 0;
  List<QuestionResponse> _questions = [];

  Future<List<QuestionResponse>> _fetchQuestions() async {
    return await fetchSentenceUnscrambleQuestions(
      ref,
      widget.lessonId,
      (totalQuestionCount) {
        _totalQuestionCount = totalQuestionCount;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _questions = await _fetchQuestions();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          child: const Text('Bài tập xếp từ thành câu'),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                content:
                    'Bạn có muốn dành 5 phút để hoàn thành? Bạn không thể thoát trong quá trình làm.',
                onConfirm: () => Navigator.pushNamed(
                  context,
                  SentenceUnscrambleQuestionScreen.routeName,
                  arguments: _questions,
                ),
              ),
            );
          },
        ),
        Text('$_totalQuestionCount câu hỏi')
      ],
    );
  }
}
