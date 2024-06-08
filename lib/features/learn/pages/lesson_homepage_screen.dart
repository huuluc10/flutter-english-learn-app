import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/learn/controller/learn_controller.dart';
import 'package:flutter_englearn/features/learn/pages/lesson_content_screen.dart';
import 'package:flutter_englearn/features/learn/widgets/list_type_exercise_widget.dart';
import 'package:flutter_englearn/model/question_type.dart';
import 'package:flutter_englearn/model/response/lesson_response.dart';
import 'package:flutter_englearn/common/widgets/future_builder_error_widget.dart';
import 'package:flutter_englearn/common/widgets/line_gradient_background_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LessonHomePageScreen extends ConsumerStatefulWidget {
  const LessonHomePageScreen({
    super.key,
    required this.topicId,
    required this.successRate,
    required this.level,
  });

  static const String routeName = '/lesson-homepage-screen';

  final int topicId;
  final double successRate;
  final String? level;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LessonHomePageScreenState();
}

class _LessonHomePageScreenState extends ConsumerState<LessonHomePageScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Cấp độ hiện tại của bạn là ${widget.level}'),
            content: const Text(
              'Để củng cố kiến thức và kỹ năng, bạn nên tiếp tục học các bài học cùng cấp độ. '
              'Điều này sẽ giúp bạn ôn tập và luyện tập hiệu quả hơn.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Đóng popup
                },
                child: const Text('Ok'),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
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
                        Text(
                          'Lý thuyết ${(widget.successRate * 100).toStringAsFixed(2)}%',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        FutureBuilder<List<LessonResponse>>(
                          future: getLessons(
                              context, ref, widget.topicId.toString()),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return FutureBuilderErrorWidget(
                                error: snapshot.error.toString(),
                              );
                            }
                            if (snapshot.hasData) {
                              return MediaQuery.removePadding(
                                context: context,
                                removeTop: true,
                                child: SizedBox(
                                  height: height - 180,
                                  child: ListView.builder(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      LessonResponse lessonResponse =
                                          snapshot.data![index];
                                      return ExpansionTile(
                                        title: Text(lessonResponse.lessonName),
                                        collapsedBackgroundColor:
                                            lessonResponse.completed == 'Yes'
                                                ? Colors.green[100]
                                                : Colors.white,
                                        backgroundColor:
                                            lessonResponse.completed == 'Yes'
                                                ? Colors.green[100]
                                                : Colors.white,
                                        subtitle: Text(
                                            '${lessonResponse.levelName} - ${lessonResponse.lessonExperience} kinh nghiệm'),
                                        leading:
                                            Image.asset('assets/theory.png'),
                                        expandedCrossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextButton(
                                                child: const Text('Lý thuyết'),
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                      context,
                                                      LessonContentScreen
                                                          .routeName,
                                                      arguments: [
                                                        lessonResponse.lessonId,
                                                        lessonResponse
                                                            .contentURL,
                                                        lessonResponse
                                                            .completed,
                                                        () {
                                                          setState(() {
                                                            lessonResponse
                                                                    .completed =
                                                                'Yes';
                                                          });
                                                        }
                                                      ]);
                                                },
                                              ),
                                              lessonResponse.completed == 'Yes'
                                                  ? const Icon(
                                                      Icons.check,
                                                      color: Colors.green,
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                          MediaQuery.removePadding(
                                            context: context,
                                            removeTop: true,
                                            child: FutureBuilder<
                                                List<QuestionType>>(
                                              future: getListExerciseOfLesson(
                                                context,
                                                ref,
                                                lessonResponse.lessonId,
                                              ),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const CircularProgressIndicator();
                                                }
                                                if (snapshot.hasError) {
                                                  return FutureBuilderErrorWidget(
                                                    error: snapshot.error
                                                        .toString(),
                                                  );
                                                }
                                                List<QuestionType>
                                                    questionTypes =
                                                    snapshot.data!;

                                                return ListTypeExerciseWidget(
                                                  lessonId:
                                                      lessonResponse.lessonId,
                                                  questionTypes: questionTypes,
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            return const CircularProgressIndicator();
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
