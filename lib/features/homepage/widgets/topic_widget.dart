import 'package:flutter/material.dart';

class TopicWidget extends StatelessWidget {
  const TopicWidget({super.key, required this.width, required this.nameTopic});

  final double width;
  final String nameTopic;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: width * 0.44,
      width: width * 0.44,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          children: [
            const Text(
              'Topic',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            Stack(
              children: [
                Image(
                  image: const AssetImage('assets/lesson.png'),
                  height: width * 2 / 7,
                  width: width * 2 / 7,
                ),
                Positioned(
                  bottom: 5,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      nameTopic,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
