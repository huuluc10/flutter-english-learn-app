import 'package:flutter/material.dart';
import 'package:flutter_englearn/utils/const/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AboutScreen extends ConsumerWidget {
  const AboutScreen({super.key});
  static const String routeName = '/about-screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Về EngLearn'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Image(
                  image: AssetImage('assets/englearn.png'),
                  width: 200.0,
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'EngLearn',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Phiên bản 1.0.0',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'EngLearn là một ứng dụng học tiếng Anh miễn phí giúp bạn cải thiện vốn từ vựng, ngữ pháp và kỹ năng nghe nói.',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Tác giả:',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Nguyễn Hữu Lực',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Liên hệ:',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'lucnguyenhuu91@email.com',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Tài nguyên:',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              _buildResourceItem('Ngôn ngữ lập trình:', 'Dart, Flutter'),
              _buildResourceItem('Framework:', 'Flutter SDK, Firebase'),
              _buildResourceItem('Thư viện:', listLibrary()),
              _buildResourceItem('Tài liệu:', [
                'https://flutter.dev/docs',
                'https://firebase.google.com/docs',
              ]),
              _buildResourceItem(
                'Cộng đồng:',
                'https://flutter.dev/community',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildResourceItem(String title, Object content) {
  if (content is List<String>) {
    return _buildResourceItemMultiple(title, content);
  } else {
    return _buildResourceItemSingle(title, content.toString());
  }
}

Widget _buildResourceItemSingle(String title, String content) {
  return Row(
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
        ),
      ),
      const SizedBox(width: 8.0),
      Text(
        content,
        softWrap: true,
        maxLines: 2,
        style: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.normal,
          color: Colors.blue,
        ),
      ),
    ],
  );
}

Widget _buildResourceItemMultiple(String title, List<String> content) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
        ),
      ),
      const SizedBox(height: 8.0),
      for (String item in content) _buildResourceItemSingle('', item),
    ],
  );
}
