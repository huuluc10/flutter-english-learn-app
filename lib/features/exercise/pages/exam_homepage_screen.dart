import 'package:flutter/material.dart';
import 'package:flutter_englearn/model/topic.dart';
import 'package:flutter_englearn/utils/widgets/line_gradient_background_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExamHomePageScreen extends ConsumerWidget {
  const ExamHomePageScreen({super.key});

  static const String routeName = '/exam-homepage-screen';

  Future<List<Topic>> getTopicsHasExam() async {
    return await Future.delayed(
      const Duration(seconds: 0),
      () => <Topic>[
        Topic(topicId: 1, topicName: 'Topic 1'),
        Topic(topicId: 2, topicName: 'Topic 2'),
        Topic(topicId: 3, topicName: 'Topic 3'),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
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
                        FutureBuilder<List<Topic>>(
                          future: getTopicsHasExam(),
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
                                            'Bài kiểm tra chủ đề ${index + 1}'),
                                        subtitle: Text(
                                            snapshot.data![index].topicName),
                                        leading: Image.asset('assets/exam.png'),
                                        children: <Widget>[
                                          ListTile(
                                            title:
                                                const Text('Mức độ Beginner'),
                                            onTap: () {},
                                          ),
                                          ListTile(
                                            title:
                                                const Text('Mức độ Elementary'),
                                            onTap: () {},
                                          ),
                                          ListTile(
                                            title: const Text(
                                                'Mức độ Pre-Intermediate'),
                                            onTap: () {},
                                          ),
                                          ListTile(
                                            title: const Text(
                                                'Mức độ Intermediate'),
                                            onTap: () {},
                                          ),
                                          ListTile(
                                            title:
                                                const Text('Mức độ Advanced'),
                                            onTap: () {},
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
