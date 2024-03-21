import 'package:flutter/material.dart';

class ItemDrawerWidget extends StatelessWidget {
  const ItemDrawerWidget({
    Key? key,
    required this.title,
    required this.image,
    required this.routeName
  }) : super(key: key);

  final String title;
  final String image;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, routeName),
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
