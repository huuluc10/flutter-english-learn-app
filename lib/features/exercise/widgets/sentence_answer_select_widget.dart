// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SentenceAnswerSelectWidget extends StatelessWidget {
  const SentenceAnswerSelectWidget({
    Key? key,
    required this.word,
    required this.onTap,
  }) : super(key: key);

  final String word;
  final Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(word),
      child: Container(
        margin: const EdgeInsets.only(left: 3),
        padding: const EdgeInsets.all(3),
        height: 50, // Add this
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: FittedBox(
            fit: BoxFit.cover,
            child: Text(
              word,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ),
      ),
    );
  }
}
