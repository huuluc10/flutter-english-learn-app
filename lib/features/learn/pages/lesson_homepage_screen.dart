import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/learn/widgets/fill_in_the_blank_item_exercise_widget.dart';
import 'package:flutter_englearn/features/learn/pages/lesson_content_screen.dart';
import 'package:flutter_englearn/features/learn/widgets/listening_exercise_item_widget.dart';
import 'package:flutter_englearn/features/learn/widgets/multichoice_exercies_item_widget.dart';
import 'package:flutter_englearn/features/learn/widgets/sentence_unscramble_item_exercise.dart';
import 'package:flutter_englearn/features/learn/widgets/sentence_transform_exercise_item_widget.dart';
import 'package:flutter_englearn/features/learn/widgets/speaking_item_widget.dart';
import 'package:flutter_englearn/model/lesson_response.dart';
import 'package:flutter_englearn/utils/widgets/line_gradient_background_widget.dart';
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

    Future<List<LessonResponse>> getLessons() async {
      List<LessonResponse> lessons = [];

      lessons.add(LessonResponse(
        lessonId: 1,
        lessonName: 'Lesson 1',
        topicId: 1,
        content: 1,
        lessonExperience: 1,
        levelId: 1,
        completed: 'yes',
        contentURL: 'https://www.youtube.com/watch?v=1',
        levelName: 'Beginner',
      ));

      lessons.add(LessonResponse(
        lessonId: 2,
        lessonName: 'Lesson 2',
        topicId: 1,
        content: 2,
        lessonExperience: 2,
        levelId: 1,
        completed: 'yes',
        contentURL: 'https://www.youtube.com/watch?v=2',
        levelName: 'Beginner',
      ));

      lessons.add(LessonResponse(
        lessonId: 3,
        lessonName: 'Lesson 3',
        topicId: 1,
        content: 3,
        lessonExperience: 3,
        levelId: 1,
        completed: 'no',
        contentURL: 'https://www.youtube.com/watch?v=3',
        levelName: 'Beginner',
      ));

      lessons.add(LessonResponse(
        lessonId: 1,
        lessonName: 'Lesson 1',
        topicId: 1,
        content: 1,
        lessonExperience: 1,
        levelId: 1,
        completed: 'no',
        contentURL: 'https://www.youtube.com/watch?v=1',
        levelName: 'Beginner',
      ));

      lessons.add(LessonResponse(
        lessonId: 2,
        lessonName: 'Lesson 2',
        topicId: 1,
        content: 2,
        lessonExperience: 2,
        levelId: 1,
        completed: 'no',
        contentURL: 'https://www.youtube.com/watch?v=2',
        levelName: 'Beginner',
      ));

      lessons.add(LessonResponse(
        lessonId: 3,
        lessonName: 'Lesson 3',
        topicId: 1,
        content: 3,
        lessonExperience: 3,
        levelId: 1,
        completed: 'no',
        contentURL: 'https://www.youtube.com/watch?v=3',
        levelName: 'Beginner',
      ));

      lessons.add(LessonResponse(
        lessonId: 1,
        lessonName: 'Lesson 1',
        topicId: 1,
        content: 1,
        lessonExperience: 1,
        levelId: 1,
        completed: 'no',
        contentURL: 'https://www.youtube.com/watch?v=1',
        levelName: 'Beginner',
      ));

      lessons.add(LessonResponse(
        lessonId: 2,
        lessonName: 'Lesson 2',
        topicId: 1,
        content: 2,
        lessonExperience: 2,
        levelId: 1,
        completed: 'no',
        contentURL: 'https://www.youtube.com/watch?v=2',
        levelName: 'Beginner',
      ));

      lessons.add(LessonResponse(
        lessonId: 3,
        lessonName: 'Lesson 3',
        topicId: 1,
        content: 3,
        lessonExperience: 3,
        levelId: 1,
        completed: 'no',
        contentURL: 'https://www.youtube.com/watch?v=3',
        levelName: 'Beginner',
      ));

      return lessons;
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
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
                          future: getLessons(),
                          builder: (context, snapshot) {
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
                                      return ExpansionTile(
                                        title: Text(
                                            snapshot.data![index].lessonName),
                                        subtitle: Text(
                                            snapshot.data![index].levelName),
                                        leading:
                                            Image.asset('assets/theory.png'),
                                        children: <Widget>[
                                          ListTile(
                                            title: const Text('Lý thuyết'),
                                            trailing: snapshot.data![index]
                                                        .completed ==
                                                    'yes'
                                                ? const Icon(
                                                    Icons.check,
                                                    color: Colors.green,
                                                  )
                                                : null,
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  LessonContentScreen.routeName,
                                                  arguments: [
                                                    snapshot
                                                        .data![index].lessonId,
                                                    snapshot.data![index]
                                                            .completed ==
                                                        'yes',
                                                  ]);
                                            },
                                          ),
                                          MultichoiceExerciseWidget(
                                            lessonId:
                                                snapshot.data![index].lessonId,
                                            isCompleted: 'no',
                                          ),
                                          SenntenceTransformExcerciseWidget(
                                            lessonId:
                                                snapshot.data![index].lessonId,
                                            isCompleted: 'no',
                                          ),
                                          FillInTheBlankExerciseWidget(
                                            lessonId:
                                                snapshot.data![index].lessonId,
                                            isCompleted: 'no',
                                          ),
                                          SentenceUnscrambleExerciseWidget(
                                            lessonId:
                                                snapshot.data![index].lessonId,
                                            isCompleted: 'no',
                                          ),
                                          SpeakingExerciseWidget(
                                            lessonId:
                                                snapshot.data![index].lessonId,
                                            isCompleted: 'no',
                                          ),
                                          ListeningExerciseWidget(
                                            lessonId:
                                                snapshot.data![index].lessonId,
                                            isCompleted: 'no',
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
