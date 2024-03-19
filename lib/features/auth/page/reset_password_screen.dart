import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/auth/widgets/auth_background_widget.dart';
import 'package:flutter_englearn/features/auth/widgets/auth_text_field_widget.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);
  static const routeName = '/reset-password-screen';

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: AuthBackgroundWidget(
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
                  onPressed: () {
                    // Todo: Check username and password is not empty
                    // Todo: Check username is existed or not
                    // If not, navigate to AddingInfoSignUpScreen
                    // If yes, show error message
                    // Navigator.pushNamedAndRemoveUntil(context,
                    //     AddingInfoSignUpScreen.routeName, (route) => false);
                  },
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
    );
  }
}
