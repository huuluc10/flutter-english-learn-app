// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/chat/pages/chat_home_screen.dart';
import 'package:flutter_englearn/features/dictionary/pages/dictionary_screen.dart';
import 'package:flutter_englearn/features/homepage/pages/home_screen.dart';
import 'package:flutter_englearn/common/utils/const/api_url.dart';
import 'package:flutter_englearn/common/provider/control_index_navigate_bar.dart';
import 'package:flutter_englearn/common/websocket/web_socket_singleton.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

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
  final String webSocketUrl = APIUrl.baseUrlSocket;
  late StompClient _client;
  late StompSingleton stompSingleton;

  Future<void> sendMessage(String message) async {
    print("Sending message");
    Future.delayed(Duration(seconds: 5)).then(
      (value) => _client.send(
        destination: '/app/chat/2', // Replace with your chat ID
        body: json.encode({
          'chatId': 2,
          'message': message,
          'type': 'text',
          'sender': 'huuluc10',
          'receiver': 'test',
          'timestamp': DateTime.now().toIso8601String()
        }), // Format the message as needed
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    stompSingleton = StompSingleton(context);
    stompSingleton.connect();
    _client = StompClient(
        config: StompConfig(url: webSocketUrl, onConnect: onConnectCallback));
    _client.activate();
  }

  void onConnectCallback(StompFrame connectFrame) {
    _client.subscribe(
        destination: '/user/test/queue/chats',
        headers: {},
        callback: (frame) {
          var decodedMessage = jsonDecode(frame.body!);
          var payload = decodedMessage['payload'];
          log(frame.body!);
          // Received a frame for this subscription
          // messages = jsonDecode(frame.body!).reversed.toList();
        });
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
