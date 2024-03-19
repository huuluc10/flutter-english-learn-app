import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/auth/page/login.dart';
import 'package:flutter_englearn/features/auth/page/welcome.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case WelcomeScreen.routeName:
      return MaterialPageRoute(builder: (context) => const WelcomeScreen());

    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
  }
  return MaterialPageRoute(builder: (context) => const WelcomeScreen());
}
