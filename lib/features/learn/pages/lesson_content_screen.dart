import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/learn/controller/learn_controller.dart';
import 'package:flutter_englearn/features/learn/provider/learn_provider.dart';
import 'package:flutter_englearn/features/learn/widgets/rating_widget.dart';
import 'package:flutter_englearn/features/learn/widgets/youtube_player_widget.dart';
import 'package:flutter_englearn/model/lesson_content.dart';
import 'package:flutter_englearn/common/widgets/future_builder_error_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LessonContentScreen extends ConsumerStatefulWidget {
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
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LessonContentScreenState();
}

class _LessonContentScreenState extends ConsumerState<LessonContentScreen>
    with SingleTickerProviderStateMixin {
  void _showRatingDialog(int lessonId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return RatingDialog(lessonId: lessonId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
              future: fetchLessonContent(context, ref, widget.url),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return FutureBuilderErrorWidget(
                    error: snapshot.error.toString(),
                  );
                } else {
                  final lessonContent = snapshot.data;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lessonContent!.title,
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  textBaseline: TextBaseline.alphabetic,
                                  fontSize: 32,
                                ),
                        textAlign: TextAlign.justify,
                      ),
                      if (lessonContent.description != null)
                        Text(
                          lessonContent.description!,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
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
                            if (content.imageUrl != null)
                              Center(
                                child: CachedNetworkImage(
                                  imageUrl: content.imageUrl!,
                                ),
                              ),
                            if (content.videoUrl != null)
                              YoutubePlayerWidget(url: content.videoUrl!),
                            if (content.text != null)
                              Text(
                                content.text!,
                                style: Theme.of(context).textTheme.bodyLarge,
                                textAlign: TextAlign.justify,
                              ),
                            const SizedBox(height: 8),
                            if (content.example != null &&
                                content.example!.isNotEmpty) ...[
                              Text(
                                'Ví dụ:',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                textAlign: TextAlign.left,
                              ),
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
                            ],
                            const SizedBox(height: 16),
                          ],
                        ),
                      widget.isCompleted == "No"
                          ? Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  ref
                                      .watch(learnServiceProvider)
                                      .markLessonAsLearned(
                                    context,
                                    widget.lessonId,
                                    () {
                                      _showRatingDialog(widget.lessonId);
                                      widget.onMarkAsLearned();
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
                              ),
                            )
                          : Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  _showRatingDialog(widget.lessonId);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                ),
                                child: const Text(
                                  "Đánh giá bài học",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
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
