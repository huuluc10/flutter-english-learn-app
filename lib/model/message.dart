import 'dart:convert';

class Message {
  String chatRoomId;
  String lastMessage;
  String sender;
  String senderAvatar;
  String receiver;
  String receiverAvatar;
  DateTime timestamp;

  Message({
    required this.chatRoomId,
    required this.lastMessage,
    required this.sender,
    required this.senderAvatar,
    required this.receiver,
    required this.receiverAvatar,
    required this.timestamp,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      chatRoomId: map['chatId'] as String,
      lastMessage: map['message'] as String,
      sender: map['sender'] as String,
      senderAvatar: map['senderAvatar'] as String,
      receiver: map['receiver'] as String,
      receiverAvatar: map['receiverAvatar'] as String,
      timestamp: DateTime.parse(map['timestamp']),
    );
  }

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);
}
