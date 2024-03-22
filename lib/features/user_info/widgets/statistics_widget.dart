import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/user_info/widgets/statistics_item_widget.dart';

class StatisticsWidget extends StatelessWidget {
  const StatisticsWidget({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            StatisticsItemWidget(
              width: width,
              icon: 'assets/star.png',
              title: 'Cấp độ',
              value: 'Beginner',
            ),
            StatisticsItemWidget(
              width: width,
              icon: 'assets/experience.png',
              title: 'Kinh nghiệm',
              value: '100',
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
              value: '100',
            ),
            StatisticsItemWidget(
              width: width,
              icon: 'assets/exam.png',
              title: 'Bài thi',
              value: '100',
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
              value: '100',
            ),
            StatisticsItemWidget(
              width: width,
              icon: 'assets/fire.png',
              title: 'Ngày',
              value: '7',
            ),
          ],
        ),
      ],
    );
  }
}
