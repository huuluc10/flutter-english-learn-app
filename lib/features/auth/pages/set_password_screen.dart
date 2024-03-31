// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/auth/provider/auth_provider.dart';
import 'package:flutter_englearn/features/auth/widgets/auth_text_field_widget.dart';
import 'package:flutter_englearn/utils/helper/helper.dart';
import 'package:flutter_englearn/utils/widgets/line_gradient_background_widget.dart';
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

    void resetPassword() async {
      final String password = passwordController.text;
      final String confirmPassword = confirmPasswordController.text;
      if (password.isEmpty || confirmPassword.isEmpty) {
        showSnackBar(context, 'Vui lòng nhập đầy đủ thông tin');
        return;
      }
      if (password != confirmPassword) {
        showSnackBar(context, 'Mật khẩu không trùng khớp');
        return;
      }
      await ref
          .watch(authServiceProvicer)
          .changeResetPassword(context, email, password);
    }

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
                      onPressed: resetPassword,
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
