import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/user_info/widgets/statistics_item_widget.dart';
import 'package:flutter_englearn/model/response/user_info_response.dart';

class StatisticsWidget extends StatelessWidget {
  const StatisticsWidget({
    super.key,
    required this.width,
    required this.userInfo,
  });

  final double width;
  final UserInfoResponse userInfo;

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
              value: 'Chưa có',
            ),
            StatisticsItemWidget(
              width: width,
              icon: 'assets/exam.png',
              title: 'Bài thi',
              value: 'Chưa có',
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
              value: 'Chưa có',
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
