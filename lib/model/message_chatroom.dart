import 'dart:convert';

import 'package:flutter_englearn/model/message.dart';

class MessageChatRoom {
  String chatId;
  List<String> participants;
  Message? lastMessage;
  bool isSeen;

  MessageChatRoom({
    required this.chatId,
    required this.participants,
    required this.lastMessage,
    required this.isSeen,
  });

  factory MessageChatRoom.fromMap(Map<String, dynamic> map) {
    return MessageChatRoom(
      chatId: map['chatId'] as String,
      participants: List<String>.from(map['participants']),
      lastMessage: map['lastMessage'] != null
          ? Message.fromMap(map['lastMessage']! as Map<String, dynamic>)
          : null,
      isSeen: map['seen'] as bool,
    );
  }

  factory MessageChatRoom.fromJson(String source) =>
      MessageChatRoom.fromMap(json.decode(source) as Map<String, dynamic>);
}
