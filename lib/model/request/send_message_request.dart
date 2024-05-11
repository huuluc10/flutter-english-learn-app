// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SendMessageRequest {
  String message;
  String sender;
  String senderAvatar;
  String receiver;
  String receiverAvatar;

  SendMessageRequest({
    required this.message,
    required this.sender,
    required this.senderAvatar,
    required this.receiver,
    required this.receiverAvatar,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'sender': sender,
      'senderAvatar': senderAvatar,
      'receiver': receiver,
      'receiverAvatar': receiverAvatar,
      'timestamp': DateTime.now().toIso8601String(),
    };
  }

  factory SendMessageRequest.fromMap(Map<String, dynamic> map) {
    return SendMessageRequest(
      message: map['message'] as String,
      sender: map['sender'] as String,
      senderAvatar: map['senderAvatar'] as String,
      receiver: map['receiver'] as String,
      receiverAvatar: map['receiverAvatar'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SendMessageRequest.fromJson(String source) =>
      SendMessageRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
