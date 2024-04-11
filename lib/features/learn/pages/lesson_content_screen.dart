import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/learn/provider/learn_provider.dart';
import 'package:flutter_englearn/model/lesson_content.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LessonContentScreen extends ConsumerWidget {
  const LessonContentScreen({
    super.key,
    required this.lessonId,
    required this.url,
    required this.isCompleted,
    required this.onMarkAsLearned,
  });

  static const String routeName = '/lesson-content-screen';
  final int lessonId;
  final String url;
  final String isCompleted;
  final Function() onMarkAsLearned;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<LessconContent> fetchLessonContent() async {
      final response = await ref.watch(learnServiceProvider).getLessonContent(
            context,
            url,
          );
      return response;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        height: MediaQuery.sizeOf(context).height,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: FutureBuilder<LessconContent>(
              future: fetchLessonContent(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final lessonContent = snapshot.data;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        lessonContent!.title,
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  textBaseline: TextBaseline.alphabetic,
                                  fontSize: 37,
                                ),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        lessonContent.description,
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
                                  fontSize: 16,
                                ),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 16),
                      for (final content in lessonContent.content)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            content.title == null
                                ? const SizedBox.shrink()
                                : Text(
                                    content.title!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                    textAlign: TextAlign.justify,
                                  ),
                            const SizedBox(height: 8),
                            if (content.text != null)
                              Text(
                                content.text!,
                                style: Theme.of(context).textTheme.bodyLarge,
                                textAlign: TextAlign.justify,
                              ),
                            const SizedBox(height: 8),
                            Text(
                              'Ví dụ:',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            if (content.example != null)
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (final example in content.example!)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '\u2022 ${example.original}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                  fontStyle: FontStyle.italic,
                                                ),
                                            textAlign: TextAlign.justify,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Giải thích: ${example.explanation}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                            textAlign: TextAlign.justify,
                                          ),
                                          const SizedBox(height: 8),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            if (content.imageUrl != null)
                              Center(
                                child: CachedNetworkImage(
                                  imageUrl: content.imageUrl!,
                                  width: 200,
                                  height: 200,
                                ),
                              ),
                            const SizedBox(height: 8),
                            if (content.videoUrl != null)
                              TextButton(
                                onPressed: () {},
                                child: const Text('Watch video'),
                              ),
                          ],
                        ),
                      isCompleted == "No"
                          ? ElevatedButton(
                              onPressed: () {
                                ref
                                    .watch(learnServiceProvider)
                                    .markLessonAsLearned(
                                  context,
                                  lessonId,
                                  () {
                                    onMarkAsLearned();
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                              child: const Text(
                                "Đánh dấu đã học xong",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                              child: const Text(
                                "Đã học xong",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
