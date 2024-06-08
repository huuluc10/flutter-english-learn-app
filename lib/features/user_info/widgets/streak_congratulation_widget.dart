import 'package:flutter/material.dart';

class StreakCongratulationWidget extends StatefulWidget {
  final int oldStreak;
  final int newStreak;
  const StreakCongratulationWidget({
    Key? key,
    required this.oldStreak,
    required this.newStreak,
  }) : super(key: key);

  @override
  State<StreakCongratulationWidget> createState() =>
      _StreakCongratulationWidgetState();
}

class _StreakCongratulationWidgetState extends State<StreakCongratulationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _opacityAnimation = Tween<double>(begin: 1, end: 0).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: const Text(
        'Tuyệt vời!',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final streakValue = _opacityAnimation.value * widget.oldStreak +
                  (1 - _opacityAnimation.value) * widget.newStreak;
              return RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Bạn đã học tập liên tục ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '${streakValue.toStringAsFixed(0)} ',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(
                      text: 'ngày!',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          const Text(
            'Hãy tiếp tục giữ vững chuỗi Streak của bạn!',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Đóng Popup Widget
              // Mở khóa bài học hoặc khóa học tiếp theo
            },
            child: const Text('Tiếp tục học'),
          ),
        ],
      ),
    );
  }
}
