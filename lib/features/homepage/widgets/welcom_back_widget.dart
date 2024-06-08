import 'package:flutter/material.dart';

class WelcomeBackWidget extends StatefulWidget {
  const WelcomeBackWidget({Key? key}) : super(key: key);

  @override
  State<WelcomeBackWidget> createState() => _WelcomeBackWidgetState();
}

class _WelcomeBackWidgetState extends State<WelcomeBackWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: const Text(
        'Chào mừng quay lại Englearn!',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          const Text(
            'Đừng bỏ lỡ cơ hội nâng cao kiến thức và chinh phục mục tiêu học tập của bạn!\nHãy thực hiện các nhiệm vụ hằng ngày và kiểm tra kiến thức của bạn ngay bây giờ!',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Đóng Popup Widget
                  // Mở khóa bài học hoặc khóa học
                },
                child: const Text('Tiếp tục học ngay'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
