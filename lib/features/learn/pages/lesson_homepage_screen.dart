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
  });

  static const String routeName = '/lesson-homepage-screen';

  final int topicId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LessonHomePageScreenState();
}

class _LessonHomePageScreenState extends ConsumerState<LessonHomePageScreen> {
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
                        const Text(
                          'Lý thuyết',
                          style: TextStyle(
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
                                        subtitle: Text(
                                            '${lessonResponse.levelName} - ${lessonResponse.lessonExperience} kinh nghiệm'),
                                        leading:
                                            Image.asset('assets/theory.png'),
                                        children: <Widget>[
                                          ListTile(
                                            title: const Text('Lý thuyết'),
                                            trailing:
                                                lessonResponse.completed ==
                                                        'Yes'
                                                    ? const Icon(
                                                        Icons.check,
                                                        color: Colors.green,
                                                      )
                                                    : null,
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  LessonContentScreen.routeName,
                                                  arguments: [
                                                    lessonResponse.lessonId,
                                                    lessonResponse.contentURL,
                                                    lessonResponse.completed,
                                                    () {
                                                      setState(() {
                                                        lessonResponse
                                                            .completed = 'Yes';
                                                      });
                                                    }
                                                  ]);
                                            },
                                          ),
                                          FutureBuilder<List<QuestionType>>(
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
                                                  error:
                                                      snapshot.error.toString(),
                                                );
                                              }
                                              List<QuestionType> questionTypes =
                                                  snapshot.data!;

                                              return ListTypeExerciseWidget(
                                                lessonId:
                                                    lessonResponse.lessonId,
                                                questionTypes: questionTypes,
                                              );
                                            },
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
