import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/auth/provider/auth_provider.dart';
import 'package:flutter_englearn/features/homepage/pages/home_screen.dart';
import 'package:flutter_englearn/features/auth/pages/welcome_screen.dart';
import 'package:flutter_englearn/routes.dart';
import 'package:flutter_englearn/utils/pages/error_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


void main() {
  runApp(const ProviderScope(
    child: SafeArea(child: MyApp()),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EngLearn',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade900),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: ref.watch(isJWTExistProvider).when(
            data: (isJWTExist) {
              if (!isJWTExist) {
                return const WelcomeScreen();
              } else {
                return const HomeScreen();
              }
            },
            error: (error, trace) {
              return const ErrorScreen();
            },
            loading: () => Scaffold(
              backgroundColor: Colors.transparent,
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
                  const Center(
                    child: SpinKitCubeGrid(
                      color: Colors.blue,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}