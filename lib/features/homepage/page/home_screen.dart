import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/homepage/widgets/draw_home_widget.dart';
import 'package:flutter_englearn/utils/bottom_navigate_bar_widget.dart';
import 'package:flutter_englearn/utils/service/control_index_navigate_bar.dart';
import 'package:flutter_englearn/utils/widgets/line_gradient_background_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/home-screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indexBottomNavbar = ref.watch(indexBottomNavbarProvider);
    return Scaffold(
      extendBodyBehindAppBar: true,
      // extendBody: false,
      appBar: AppBar(
        title: const Text('EngLearn'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: const LineGradientBackgroundWidget(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Home Screen',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
      drawer: DrawHomeWidget(),
      bottomNavigationBar: BottomNavigateBarWidget(index: indexBottomNavbar),
    );
  }
}
