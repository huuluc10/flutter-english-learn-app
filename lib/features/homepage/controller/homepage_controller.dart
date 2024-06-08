import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/homepage/provider/homepage_provider.dart';
import 'package:flutter_englearn/features/homepage/widgets/welcom_back_widget.dart';
import 'package:flutter_englearn/model/response/history_learn_topic_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<List<HistoryLearnTopicResponse>> getListTopic(
    BuildContext context, WidgetRef ref) async {
  final List<HistoryLearnTopicResponse> listTopic =
      await ref.watch(homepageServiceProvider).fetchTopic(context);
  final openCount = ref.read(openCountProvider);

  if (openCount == 0) {
    String? email = await ref.watch(homepageServiceProvider).getEmail();

    if (email == null || email.isEmpty || email == 'null') {
      email = await ref.watch(homepageServiceProvider).getEmailFromAPI();

      if (email != null && email.isNotEmpty) {
        await ref.watch(homepageServiceProvider).setEmail(email);
      } else {
        showAddEmailPopup(context, ref);
      }
    }
    // Hiển thị popup widget chào mừng
    showDialog(
      context: context,
      builder: (context) => const WelcomeBackWidget(), // Widget chào mừng
    );
  }
  // Cập nhật openCount
  ref.read(openCountProvider.notifier).increment(); // Cập nhật openCount
  return Future.value(listTopic);
}

class OpenCountProvider extends StateNotifier<int> {
  int get value => state;
  OpenCountProvider() : super(0);

  void increment() {
    state = state + 1;
  }
}

void showAddEmailPopup(BuildContext context, WidgetRef ref) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Thêm email vào tài khoản'),
        content: const Text(
          'Thêm email vào tài khoản ở màn hình thông tin tài khoản để bạn có thể khôi phục mật khẩu trong trường hợp quên.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Đóng popup
            },
            child: const Text('Bỏ qua'),
          ),
        ],
      );
    },
  );
}
