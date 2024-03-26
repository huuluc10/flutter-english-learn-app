import 'package:flutter/material.dart';
import 'package:flutter_englearn/model/content.dart';
import 'package:flutter_englearn/model/example.dart';
import 'package:flutter_englearn/model/lesson_content.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LessonContentScreen extends ConsumerWidget {
  const LessonContentScreen({
    super.key,
    required this.lessonId,
  });

  static const String routeName = '/lesson-content-screen';
  final int lessonId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<LessconContent> fetchLessonContent(int lessonId) async {
      // ignore: unused_local_variable
      final response = await Future.delayed(
        const Duration(seconds: 1),
        () => LessconContent(
          title: 'Common Action - Hành Động Thông Dụng',
          description: 'Tiếp tục học các hành động thông dụng trong tiếng Anh',
          content: [
            Content(
              title: 'Close - Đóng',
              text:
                  '“Close” là động từ có nghĩa là di chuyển hai bên của một vật thể để chúng không còn cách xa nhau.',
              example: [
                Example(
                  original: 'I close the door when I leave.',
                  explanation: 'Tôi đóng cửa khi ra ngoài.',
                ),
                Example(
                  original: 'i close',
                  explanation: 'Tôi đóng.',
                )
              ],
              imageUrl: 'images/objects/common_action/close.png',
              videoUrl: null,
            ),
            Content(
              title: 'Open - Mở',
              text:
                  '“Open” là động từ có nghĩa là di chuyển hai bên của một vật thể để chúng cách xa nhau.',
              example: [
                Example(
                    original: 'I open the door when I come in.',
                    explanation: 'Tôi mở cửa khi vào trong.'),
              ],
              imageUrl: 'images/objects/common_action/open.png',
              videoUrl: null,
            ),
            Content(
              title: 'Give - Đưa',
              text:
                  '“Give” là động từ có nghĩa là chuyển một vật gì đó từ một người này sang người khác.',
              example: [
                Example(
                  original: 'I give you a book.',
                  explanation: 'Tôi đưa bạn một quyển sách.',
                ),
              ],
              imageUrl: null,
              videoUrl: null,
            )
          ],
        ),
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
              future: fetchLessonContent(lessonId),
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
                            Text(
                              content.text,
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
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (final example in content.example)
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
                            const SizedBox(height: 8),
                            if (content.imageUrl != null)
                              // Image.asset(
                              //   content.imageUrl!,
                              //   width: 200,
                              //   height: 200,
                              // ),
                              Text(content.imageUrl!),
                            const SizedBox(height: 8),
                            if (content.videoUrl != null)
                              TextButton(
                                onPressed: () {},
                                child: const Text('Watch video'),
                              ),
                          ],
                        ),
                      ElevatedButton(
                        onPressed: () {
                          //Todo: Mark lesson as learned
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: const Text("Đã học xong",
                            style: TextStyle(
                              color: Colors.white,
                            )),
                      )
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
