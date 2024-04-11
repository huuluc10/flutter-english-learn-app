// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TopicItemDetailsWidget extends StatelessWidget {
  const TopicItemDetailsWidget({
    Key? key,
    required this.title,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final String image;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Row(
            children: [
              Image.asset(
                image,
                width: 50,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                ],
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
