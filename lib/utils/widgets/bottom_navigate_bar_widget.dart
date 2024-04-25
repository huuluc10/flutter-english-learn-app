// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/chat/pages/chat_home_screen.dart';
import 'package:flutter_englearn/features/dictionary/pages/dictionary_screen.dart';
import 'package:flutter_englearn/features/homepage/pages/home_screen.dart';
import 'package:flutter_englearn/utils/provider/control_index_navigate_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavigateBarWidget extends ConsumerWidget {
  const BottomNavigateBarWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Container(
          // this is the decoration of the container for gradient look
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(249, 255, 255, 255),
                Color.fromARGB(248, 242, 243, 245),
              ],
            ),
          ),
          height: 55,
        ),
        BottomNavigationBar(
          backgroundColor: Colors.transparent,
          selectedFontSize: 16,
          unselectedFontSize: 12,
          elevation: 0,
          iconSize: 22,
          currentIndex: index,
          onTap: (value) {
            ref
                .read(indexBottomNavbarProvider.notifier)
                .update((state) => value);
            switch (value) {
              case 0:
                Navigator.pushNamedAndRemoveUntil(
                    context, HomeScreen.routeName, (route) => false);
              case 1:
                Navigator.pushNamedAndRemoveUntil(
                    context, DictionaryScreen.routeName, (route) => false);
              default:
                Navigator.pushNamedAndRemoveUntil(
                    context, ChatHome.routeName, (route) => false);
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Image(image: AssetImage('assets/home.png'), width: 22),
              label: 'Học tập',
            ),
            BottomNavigationBarItem(
              icon: Image(
                image: AssetImage('assets/dictionary.png'),
                width: 24,
              ),
              label: 'Từ điển',
            ),
            BottomNavigationBarItem(
              icon: Image(image: AssetImage("assets/chat.png"), width: 22),
              label: 'Trao đổi',
            ),
          ],
        )
      ],
    );
  }
}
