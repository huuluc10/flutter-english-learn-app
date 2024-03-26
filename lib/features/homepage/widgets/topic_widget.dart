import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TopicWidget extends StatelessWidget {
  const TopicWidget({
    super.key,
    required this.nameTopic,
    required this.percent,
  });

  final String nameTopic;
  final double percent;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 248, 247, 247),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          children: [
            CircularPercentIndicator(
              radius: 60.0,
              lineWidth: 6.0,
              percent: percent,
              header: const Text(
                'Chủ đề',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              center: Stack(
                children: [
                  const Opacity(
                    opacity: 0.5,
                    child: Image(
                      image: AssetImage(
                        'assets/lesson.png',
                      ),
                    ),
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
              footer: Text(
                '${(percent * 100).toStringAsFixed(0)}%',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              backgroundColor: Colors.grey,
              progressColor: const Color.fromARGB(255, 31, 184, 0),
            ),
          ],
        ),
      ),
    );
  }
}
