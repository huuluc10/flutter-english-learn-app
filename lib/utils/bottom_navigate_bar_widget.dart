// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_englearn/utils/service/control_index_navigate_bar.dart';
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
          // i have found out the height of the bottom navigation bar is roughly 60
          height: 70,
        ),
        BottomNavigationBar(
          backgroundColor: Colors.transparent,
          selectedFontSize: 16,
          unselectedFontSize: 12,
          elevation: 0,
          iconSize: 24,
          currentIndex: index,
          onTap: (value) => ref
              .read(indexBottomNavbarProvider.notifier)
              .update((state) => value),
          items: const [
            BottomNavigationBarItem(
              icon: Image(image: AssetImage('assets/home.png'), width: 24),
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
              icon: Image(image: AssetImage("assets/chat.png"), width: 24),
              label: 'Trao đổi',
            ),
          ],
        )
      ],
    );
  }
}
