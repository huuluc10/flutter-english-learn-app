import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/user_info/widgets/statistics_item_widget.dart';
import 'package:flutter_englearn/model/response/user_info_response.dart';
import 'package:flutter_englearn/model/result_return.dart';

class StatisticsWidget extends StatelessWidget {
  const StatisticsWidget({
    super.key,
    required this.width,
    required this.info,
  });

  final double width;

  final Map<String, Object> info;

  @override
  Widget build(BuildContext context) {
    final userInfo = info['userInfo'] as UserInfoResponse;
    ResultReturn countHistoryLearnedLesson =
        info['countHistoryLearnedLesson'] as ResultReturn;
    ResultReturn countLessonExercisesDone =
        info['countLessonExercisesDone'] as ResultReturn;
    ResultReturn countExamExercisesDone =
        info['countExamExercisesDone'] as ResultReturn;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            StatisticsItemWidget(
              width: width,
              icon: 'assets/star.png',
              title: 'Cấp độ',
              value: userInfo.level,
            ),
            StatisticsItemWidget(
              width: width,
              icon: 'assets/experience.png',
              title: 'Kinh nghiệm',
              value: userInfo.experience.toString(),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            StatisticsItemWidget(
              width: width,
              icon: 'assets/lesson.png',
              title: 'Bài học',
              value: countHistoryLearnedLesson.data.toString(),
            ),
            StatisticsItemWidget(
              width: width,
              icon: 'assets/exam.png',
              title: 'Bài thi',
              value: countExamExercisesDone.data.toString(),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            StatisticsItemWidget(
              width: width,
              icon: 'assets/exercise.png',
              title: 'Bài tập',
              value: countLessonExercisesDone.data.toString(),
            ),
            StatisticsItemWidget(
              width: width,
              icon: 'assets/fire.png',
              title: 'Ngày',
              value: userInfo.streak.toString(),
            ),
          ],
        ),
      ],
    );
  }
}
