import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/exercise/pages/exam_question_screen.dart';
import 'package:flutter_englearn/features/exercise/provider/exercise_provider.dart';
import 'package:flutter_englearn/model/response/exam_response.dart';
import 'package:flutter_englearn/common/widgets/future_builder_error_widget.dart';
import 'package:flutter_englearn/common/widgets/line_gradient_background_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExamHomePageScreen extends ConsumerStatefulWidget {
   const ExamHomePageScreen({
    super.key,
    required this.topicId,
  });

  static const String routeName = '/exam-homepage-screen';

  final int topicId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExamHomePageScreenState();
}

class _ExamHomePageScreenState extends ConsumerState<ExamHomePageScreen> {

  Future<List<ExamResponse>> getExams() async {
      return await ref.watch(exerciseServiceProvider).getListExam(widget.topicId);
    }

 @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    

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
                          'Bài kiểm tra chủ đề',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        FutureBuilder<List<ExamResponse>>(
                          future: getExams(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError)
                              // ignore: curly_braces_in_flow_control_structures
                              return FutureBuilderErrorWidget(
                                error: snapshot.error.toString(),
                              );
                            if (snapshot.hasData) {
                              return MediaQuery.removePadding(
                                context: context,
                                removeTop: true,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    String examTime = (snapshot.data![index]
                                                .examTimeWithSecond /
                                            60)
                                        .toStringAsFixed(0);
                                    final String subtitle =
                                        '${snapshot.data![index].examLevel} - $examTime phút - ${snapshot.data![index].examExperience} kinh nghiệm';
                                    return ListTile(
                                      leading: Image.asset('assets/exam.png'),
                                      title:
                                          Text(snapshot.data![index].examName),
                                      subtitle: Text(subtitle),
                                      trailing:
                                          snapshot.data![index].examResult == 0
                                              ? null
                                              : SizedBox(
                                                  width: 80,
                                                  child: Text(
                                                    '${snapshot.data![index].examResult} điểm',
                                                    style: const TextStyle(
                                                        color: Colors.red),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                      onTap: () {
                                        if (snapshot.data![index].examResult ==
                                            0) {
                                          Navigator.pushNamed(
                                            context,
                                            ExamScreen.routeName,
                                            arguments: [
                                              snapshot.data![index].examId,
                                              snapshot.data![index]
                                                  .examTimeWithSecond,
                                                  (mark) {
                                                      setState(() {
                                                        snapshot.data![index].examResult = mark;
                                                      });
                                                    }
                                            ],
                                          );
                                        }
                                      },
                                    );
                                  },
                                ),
                              );
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
