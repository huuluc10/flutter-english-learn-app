import 'package:flutter/material.dart';

class ItemDrawerWidget extends StatelessWidget {
  const ItemDrawerWidget({
    Key? key,
    required this.title,
    required this.image,
    required this.routeName,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final String image;
  final String routeName;
  final Function()?  onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: CircleAvatar(
          radius: 14,
          child: Image.asset(image),
        ),
        title: Text(title),
      ),
    );
  }
}
