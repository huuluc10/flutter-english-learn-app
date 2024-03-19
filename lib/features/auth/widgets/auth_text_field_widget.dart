import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  final String labelText;
  final bool isPassword;
  final TextEditingController controller;

  const AuthTextField(
      {super.key,
      required this.labelText,
      required this.isPassword,
      required this.controller});

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        filled: true,
        fillColor: const Color.fromARGB(255, 228, 228, 228),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      obscureText: widget.isPassword,
      enableSuggestions: false,
      autocorrect: false,
    );
  }
}
