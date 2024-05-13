import 'package:flutter/material.dart';
import 'package:flutter_englearn/common/helper/helper.dart';
import 'package:flutter_englearn/features/chat/repository/chat_repository.dart';
import 'package:flutter_englearn/model/message.dart';
import 'package:flutter_englearn/model/message_chatroom.dart';
import 'package:flutter_englearn/model/result_return.dart';

class ChatService {
  final ChatRepository chatRepository;

  ChatService({required this.chatRepository});

  Future<List<MessageChatRoom>> getAllChatRoom(BuildContext context) async {
    ResultReturn result = await chatRepository.getAllChatRoom();

    if (result.httpStatusCode == 200) {
      List<MessageChatRoom> chatRooms = result.data as List<MessageChatRoom>;
      return chatRooms;
    } else {
      if (context.mounted) {
        showSnackBar(context, 'Có lỗi xảy ra, vui lòng thử lại sau');
      }
    }
    return [];
  }

  Future<void> markMessageAsRead(
      BuildContext context, String chatRoomId) async {
    ResultReturn result = await chatRepository.markMessageAsRead(chatRoomId);

    if (result.httpStatusCode != 200) {
      showSnackBar(
          context, 'Có lỗi xảy ra khi cập nhật dữ liệu, vui lòng thử lại sau');
    }
  }

  Future<List<Message>> getHistoryChat(
      BuildContext context, String chatRoomId) async {
    ResultReturn result = await chatRepository.getHistoryChat(chatRoomId);

    if (result.httpStatusCode != 200) {
      if (context.mounted) {
        showSnackBar(context,
            'Có lỗi xảy ra khi cập nhật dữ liệu, vui lòng thử lại sau');
      }
    }

    return result.data as List<Message>;
  }

  Future<String?> getChatRoomIdWithParticipants(
      BuildContext context, String friendName) async {
    ResultReturn result = await chatRepository.getChatRoom(friendName);

    if (result.httpStatusCode == 200) {
      MessageChatRoom chatRoom = result.data as MessageChatRoom;
      return chatRoom.chatId;
    } else if (result.httpStatusCode == 204) {
      String? chatId = await chatRepository.createChatRoom(friendName);
      return chatId;
    }
    return null;
  }
}
