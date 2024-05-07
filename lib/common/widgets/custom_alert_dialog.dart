import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    required this.content,
    required this.onConfirm,
  });

  final String content;
  final Function() onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Xác nhận'),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Hủy'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          child: const Text('Đồng ý'),
        ),
      ],
    );
  }
}
