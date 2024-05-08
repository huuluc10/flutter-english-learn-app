// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_englearn/common/provider/common_provider.dart';
import 'package:flutter_englearn/common/utils/api_url.dart';
import 'package:flutter_englearn/features/auth/provider/auth_provider.dart';
import 'package:flutter_englearn/features/chat/pages/chat_home_screen.dart';
import 'package:flutter_englearn/features/dictionary/pages/dictionary_screen.dart';
import 'package:flutter_englearn/features/homepage/pages/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'dart:developer';

class BottomNavigateBarWidget extends ConsumerStatefulWidget {
  const BottomNavigateBarWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BottomNavigateBarWidgetState();
}

class _BottomNavigateBarWidgetState
    extends ConsumerState<BottomNavigateBarWidget> {
  late StompClient _client;

  @override
  void initState() {
    super.initState();
    const String webSocketUrl = APIUrl.baseUrlSocket;
    log(webSocketUrl);
    _client = StompClient(
        config: StompConfig(url: webSocketUrl, onConnect: onConnectCallback));
    _client.activate();
  }

  void onConnectCallback(StompFrame connectFrame) async {
    String username = await ref.watch(authServiceProvicer).getUsername();
    _client.subscribe(
        destination: '/user/$username/queue/chats',
        headers: {},
        callback: (frame) {
          ref.watch(haveNewMessageProvider.notifier).update((value) => true);
        });
  }

  @override
  void dispose() {
    super.dispose();
    _client.deactivate();
  }

  @override
  Widget build(BuildContext context) {
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
          currentIndex: widget.index,
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
          items: [
            const BottomNavigationBarItem(
              icon: Image(image: AssetImage('assets/home.png'), width: 22),
              label: 'Học tập',
            ),
            const BottomNavigationBarItem(
              icon: Image(
                image: AssetImage('assets/dictionary.png'),
                width: 24,
              ),
              label: 'Từ điển',
            ),
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Consumer(
                      builder: (context, ref, child) {
                        final haveNewMessage =
                            ref.watch(haveNewMessageProvider);
                        return haveNewMessage
                            ? Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              )
                            : Container();
                      },
                    ),
                  ),
                  const Image(image: AssetImage("assets/chat.png"), width: 22),
                ],
              ),
              label: 'Trao đổi',
            ),
          ],
        )
      ],
    );
  }
}
