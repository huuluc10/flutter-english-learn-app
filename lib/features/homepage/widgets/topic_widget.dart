import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TopicWidget extends StatelessWidget {
  const TopicWidget({
    super.key,
    required this.nameTopic,
    required this.percent,
    required this.imageUrl,
  });

  final String nameTopic;
  final double percent;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 248, 247, 247),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Opacity(
              opacity: 0.63,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
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
                    center: Center(
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
          ),
        ],
      ),
    );
  }
}
