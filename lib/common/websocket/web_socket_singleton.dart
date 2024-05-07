import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_englearn/common/utils/const/api_url.dart';
import 'package:flutter_englearn/common/utils/helper/helper.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class StompSingleton {
  static final StompSingleton _singleton = StompSingleton._internal();
  late StompClient client;
  late BuildContext context;

  factory StompSingleton(BuildContext context) {
    _singleton.context = context;
    return _singleton;
  }

  StompSingleton._internal() {
    const String webSocketUrl = APIUrl.baseUrlSocket;
    client = StompClient(
      config: StompConfig(
        url: webSocketUrl,
        onConnect: (StompFrame connectFrame) {
          print('Connected to Stomp');
          client.subscribe(
              destination: '/user/test/queue/chats',
              headers: {},
              callback: (frame) {
                var decodedMessage = jsonDecode(frame.body!);
                var payload = decodedMessage['payload'];
                log(frame.body!);
                // Received a frame for this subscription
                // messages = jsonDecode(frame.body!).reversed.toList();
              });
        },
        onWebSocketError: (dynamic error) {
          log('Stomp error: $error');
          showSnackBar(
              context, 'Kết nối websocket thất bại : ${error.toString()}');
        },
      ),
    );
    client.activate();
  }

  void connect() async {
    if (!client.connected) {
      client.activate();
    }
  }

  void disconnect() async {
    if (client.connected) {
      client.deactivate();
    }
  }
}
