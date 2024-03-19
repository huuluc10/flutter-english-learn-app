import 'package:flutter/material.dart';

class authTextField extends StatelessWidget {
  authTextField({super.key, required this.labelText, required this.isPassword});

  String labelText;
  bool isPassword;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: labelText,
        // set gray to background color
        filled: true,
        fillColor: Color.fromARGB(255, 228, 228, 228),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      obscureText: isPassword,
      enableSuggestions: false,
      autocorrect: false,
    );
  }
}
