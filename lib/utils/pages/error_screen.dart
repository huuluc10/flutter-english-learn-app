import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/auth/pages/welcome_screen.dart';
import 'package:flutter_englearn/features/auth/provider/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ErrorScreen extends ConsumerWidget {
  static const routeName = '/error-screen';

  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/welcome.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Phiên đăng nhập đã hết hạn, vui lòng đăng nhập lại',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(authServiceProvicer).removeJWT().then(
                            (value) => Navigator.pushNamedAndRemoveUntil(
                                context,
                                WelcomeScreen.routeName,
                                (route) => false),
                          );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      'Đăng nhập',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
