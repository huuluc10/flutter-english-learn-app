import 'dart:convert';

class FriendRequiredRequest {
  String sender;
  String receiver;

  FriendRequiredRequest({
    required this.sender,
    required this.receiver,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sender': sender,
      'receiver': receiver,
    };
  }

  String toJson() => json.encode(toMap());
}
