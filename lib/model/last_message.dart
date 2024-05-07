import 'dart:convert';

import 'package:flutter_englearn/model/message.dart';

class LastMessage {
  List<String> participants;
  Message message;

  LastMessage({
    required this.participants,
    required this.message,
  });

  factory LastMessage.fromMap(Map<String, dynamic> map) {
    return LastMessage(
      participants: List<String>.from(map['participants'] as List<dynamic>),
      message: Message.fromMap(map['message'] as Map<String, dynamic>),
    );
  }

  factory LastMessage.fromJson(String source) =>
      LastMessage.fromMap(json.decode(source) as Map<String, dynamic>);
}
