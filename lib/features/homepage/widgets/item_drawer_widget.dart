import 'package:flutter/material.dart';

class ItemDrawerWidget extends StatelessWidget {
  const ItemDrawerWidget({
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);

  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 14,
        child: Image.asset(image),
      ),
      title: Text(title),
    );
  }
}
