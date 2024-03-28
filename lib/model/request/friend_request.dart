import 'dart:convert';

class FriendRequest {
  String sender;
  String receiver;
  int status;

  FriendRequest({
    required this.sender,
    required this.receiver,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sender': sender,
      'receiver': receiver,
      'status': status,
    };
  }

  String toJson() => json.encode(toMap());
}
