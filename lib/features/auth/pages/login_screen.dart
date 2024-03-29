import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/auth/pages/reset_password_screen.dart';
import 'package:flutter_englearn/features/auth/pages/sign_up_screen.dart';
import 'package:flutter_englearn/features/auth/provider/auth_provider.dart';
import 'package:flutter_englearn/features/homepage/pages/home_screen.dart';
import 'package:flutter_englearn/utils/helper/helper.dart';
import 'package:flutter_englearn/utils/widgets/line_gradient_background_widget.dart';
import 'package:flutter_englearn/features/auth/widgets/auth_text_field_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/login-screen';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  void login() async {
    // Check if username and password is not empty
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      showSnackBar(context, "Nhập đây đủ thông tin tài khoản và mật khẩu!");
    } else if (isHTML(usernameController.text) ||
        isHTML(passwordController.text)) {
      showSnackBar(context, "Vui lòng không chèn ký tự đặc biệt!");
    } else {
      // Call login API
      ref.watch(authServiceProvicer).login(
            context,
            usernameController.text.trim(),
            passwordController.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
                    'assets/login.png',
                    width: 200,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Đăng nhập',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AuthTextField(
                      labelText: 'Tên đăng nhập hoặc email',
                      isPassword: false,
                      controller: usernameController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AuthTextField(
                      labelText: 'Mật khẩu',
                      isPassword: true,
                      controller: passwordController,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      'Đăng nhập',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Chưa có tài khoản?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            SignUpScreen.routeName,
                            (route) => false,
                          );
                        },
                        child: const Text('Đăng ký'),
                      ),
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          ResetPasswordScreen.routeName,
                          (route) => false,
                        );
                      },
                      child: const Text("Quên mật khẩu?"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
