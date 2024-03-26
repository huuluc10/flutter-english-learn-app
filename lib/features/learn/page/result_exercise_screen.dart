import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/learn/page/lesson_homepage_screen.dart';
import 'package:flutter_englearn/utils/widgets/line_gradient_background_widget.dart';

class ResultExerciseScreen extends StatelessWidget {
  const ResultExerciseScreen({
    super.key,
    required this.correctAnswerCount,
    required this.totalQuestionCount,
  });

  static const routeName = '/result-exercise-screen';

  final int correctAnswerCount;
  final int totalQuestionCount;

  int caculateResult() {
    return int.parse(
        ((correctAnswerCount / totalQuestionCount) * 100).toStringAsFixed(0));
  }

  String getComment() {
    if (caculateResult() >= 80) {
      return 'Hãy duy trì nhé! Bạn rất giỏi!';
    } else if (caculateResult() >= 60) {
      return 'Tốt lắm! Bạn cần cố gắng hơn nữa!';
    } else if (caculateResult() >= 50) {
      return 'Cố gắng hơn nữa bạn nhé!';
    } else {
      return 'Kết quả không tốt!\nBạn phải cố gắng để cải thiện kết quả!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          leading: null,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
        ),
        body: LineGradientBackgroundWidget(
            child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Kết quả bài tập',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Bạn đã trả lời đúng $correctAnswerCount câu trong tổng $totalQuestionCount câu',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'Số điểm của bạn là ${caculateResult()}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                getComment(),
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('Tiếp tục học tập'),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
