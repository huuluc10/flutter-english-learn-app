// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/auth/controller/auth_controller.dart';
import 'package:flutter_englearn/features/auth/widgets/auth_text_field_widget.dart';
import 'package:flutter_englearn/common/widgets/line_gradient_background_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SetPasswordScreen extends ConsumerWidget {
  const SetPasswordScreen({
    super.key,
    required this.email,
  });

  static const String routeName = '/set-password-screen';
  final String email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: LineGradientBackgroundWidget(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Text(
                'Đặt lại mật khẩu',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    AuthTextField(
                        labelText: 'Nhập mật khẩu mới',
                        isPassword: true,
                        controller: passwordController),
                    const SizedBox(height: 20),
                    AuthTextField(
                        labelText: 'Nhập lại mật khẩu mới',
                        isPassword: true,
                        controller: confirmPasswordController),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        await resetPassword(
                          context,
                          ref,
                          email,
                          passwordController.text,
                          confirmPasswordController.text,
                        );
                      },
                      child: const Text('Xác nhận'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
