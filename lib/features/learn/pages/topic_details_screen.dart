import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/exercise/pages/exam_homepage_screen.dart';
import 'package:flutter_englearn/features/learn/pages/lesson_homepage_screen.dart';
import 'package:flutter_englearn/features/learn/widgets/topic_item_details_widget.dart';
import 'package:flutter_englearn/model/topic_response.dart';
import 'package:flutter_englearn/utils/widgets/line_gradient_background_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopicDetailsScreen extends ConsumerWidget {
  const TopicDetailsScreen({
    super.key,
    required this.topicResponse,
  });
  static const String routeName = '/topic-details-screen';

  final TopicResponse topicResponse;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(topicResponse.topicName),
        backgroundColor: Colors.transparent,
      ),
      body: LineGradientBackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 10,
          ),
          child: SizedBox(
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 50),
                const Text(
                  'Chi tiết ',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    width: width,
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      children: [
                        TopicItemDetailsWidget(
                          image: 'assets/theory.png',
                          title: 'Lý thuyết',
                          subTitle: 'Đã học 0/10',
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              LessonHomePageScreen.routeName,
                              arguments: topicResponse.topicId,
                            );
                          },
                        ),
                        TopicItemDetailsWidget(
                          image: 'assets/exam.png',
                          title: 'Bài kiểm tra',
                          subTitle: 'Đã làm 0/10',
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              ExamHomePageScreen.routeName,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
