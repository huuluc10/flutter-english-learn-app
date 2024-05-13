import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CreateChatRoomRequest {
  String? chatId;
  List<String> participants;

  CreateChatRoomRequest({
    required this.chatId,
    required this.participants,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatId': chatId,
      'participants': participants,
    };
  }

  String toJson() => json.encode(toMap());
}
