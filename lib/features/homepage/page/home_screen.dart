import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/homepage/widgets/drawer_home_widget.dart';
import 'package:flutter_englearn/features/homepage/widgets/topic_widget.dart';
import 'package:flutter_englearn/utils/widgets/bottom_navigate_bar_widget.dart';
import 'package:flutter_englearn/utils/service/control_index_navigate_bar.dart';
import 'package:flutter_englearn/utils/widgets/line_gradient_background_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/home-screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get index of bottom navigation bar
    final indexBottomNavbar = ref.watch(indexBottomNavbarProvider);
    // Get current time
    final currentTime = DateTime.now();

    // Get width of screen
    final width = MediaQuery.of(context).size.width;
    String image = "assets/light.png";
    String welcome = "Chào buổi sáng,";
    if (currentTime.hour < 12) {
      // Good morning
    } else if (currentTime.hour < 18) {
      // Good afternoon
      welcome = "Chào buổi chiều,";
    } else {
      // Good evening
      welcome = "Chào buổi tối,";
      image = "assets/night.png";
    }

    Future<void> refresh() async {
      return Future.delayed(const Duration(seconds: 1));
    }

    const int countOfColumn = 10;

    final height = 250 + (10 + width * 0.5) * countOfColumn;

    return Scaffold(
      extendBodyBehindAppBar: true,
      // extendBody: false,
      appBar: AppBar(
        title: const Text('EngLearn'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: LineGradientBackgroundWidget(
        child: SingleChildScrollView(
          child: SizedBox(
            height: height,
            child: Stack(
              children: [
                Positioned(
                  top: -55,
                  right: -55,
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(image),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          welcome,
                          style: const TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        const Text(
                          'Tiếp tục quá trình học nào!',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Tìm kiếm',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 190,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Column(
                      children: [
                        for (var i = 0; i < countOfColumn; i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TopicWidget(
                                  width: width,
                                  nameTopic: 'Topic 1: Name of topic',
                                  percent: 0.5,
                                ),
                                TopicWidget(
                                  width: width,
                                  nameTopic: 'Topic 1: Name of topic',
                                  percent: 0.8,
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: const DrawerWidget(),
      bottomNavigationBar: BottomNavigateBarWidget(index: indexBottomNavbar),
    );
  }
}
