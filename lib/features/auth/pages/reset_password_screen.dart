import 'package:flutter/material.dart';
import 'package:flutter_englearn/utils/helper/helper.dart';
import 'package:flutter_englearn/utils/widgets/line_gradient_background_widget.dart';
import 'package:flutter_englearn/features/auth/widgets/auth_text_field_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_englearn/features/auth/provider/auth_provider.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);
  static const routeName = '/reset-password-screen';

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  final String regrexEmail = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

  void createResetPassword() {
    String email = _emailController.text.trim();

    if (email.isNotEmpty) {
      //check valid email
      if (RegExp(regrexEmail).hasMatch(email)) {
        ref.watch(authServiceProvicer).resetPassword(context, email);
        
      } else {
        showSnackBar(context, 'Email không hợp lệ');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        reverse: true,
        child: LineGradientBackgroundWidget(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/reset_password.png',
                    width: 200,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Quên mật khẩu',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AuthTextField(
                      labelText: 'Email',
                      isPassword: false,
                      controller: _emailController,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: createResetPassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      'Gửi',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
