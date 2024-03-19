import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/auth/page/adding_info_sign_up_screen.dart';
import 'package:flutter_englearn/features/auth/page/login_screen.dart';
import 'package:flutter_englearn/features/auth/widgets/auth_background_widget.dart';
import 'package:flutter_englearn/features/auth/widgets/auth_text_field_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static const routeName = '/signup-screen';

  @override
  Widget build(BuildContext context) {
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
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
                  'assets/sign_up.png',
                  width: 200,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Đăng ký tài khoản mới',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AuthTextField(
                    labelText: 'Tên đăng nhập',
                    isPassword: false,
                    controller: _usernameController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AuthTextField(
                    labelText: 'Mật khẩu',
                    isPassword: true,
                    controller: _passwordController,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Todo: Check username and password is not empty
                    // Todo: Check username is existed or not
                    // If not, navigate to AddingInfoSignUpScreen
                    // If yes, show error message
                    Navigator.pushNamedAndRemoveUntil(context,
                        AddingInfoSignUpScreen.routeName, (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    'Đăng ký',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Đã có tài khoản?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, LoginScreen.routeName, (route) => false);
                      },
                      child: const Text('Đăng nhập'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
