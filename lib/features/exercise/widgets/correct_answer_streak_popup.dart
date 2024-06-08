import 'package:flutter/material.dart';

class CorrectAnswerStreakPopup extends StatefulWidget {
  final int streakCount;
  const CorrectAnswerStreakPopup({Key? key, required this.streakCount}) : super(key: key);

  @override
  State<CorrectAnswerStreakPopup> createState() => _CorrectAnswerStreakPopupState();
}

class _CorrectAnswerStreakPopupState extends State<CorrectAnswerStreakPopup>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              offset: const Offset(2, 4),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Chúc mừng!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Bạn đã trả lời đúng ${widget.streakCount} câu liên tiếp!',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Đóng popup
                },
                child: const Text('Tiếp tục học tập'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}