import 'package:flutter/material.dart';
import 'package:flutter_englearn/common/helper/helper.dart';
import 'package:flutter_englearn/features/auth/pages/welcome_screen.dart';
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
      return result.data as List<MessageChatRoom>;
    } else if (result.httpStatusCode == 401) {
      if (context.mounted) {
        showSnackBar(
            context, 'Phiên đăng nhập hết hạn, vui lòng đăng nhập lại');
        Navigator.pushNamedAndRemoveUntil(
            context, WelcomeScreen.routeName, (route) => false);
      }
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

    if (result.httpStatusCode == 401) {
      showSnackBar(context, 'Phiên đăng nhập hết hạn, vui lòng đăng nhập lại');
      Navigator.pushNamedAndRemoveUntil(
          context, WelcomeScreen.routeName, (route) => false);
    } else if (result.httpStatusCode != 200) {
      showSnackBar(
          context, 'Có lỗi xảy ra khi cập nhật dữ liệu, vui lòng thử lại sau');
    }
  }

  Future<List<Message>> getHistoryChat(
      BuildContext context, String chatRoomId) async {
    ResultReturn result = await chatRepository.getHistoryChat(chatRoomId);

    if (result.httpStatusCode == 401) {
      if (context.mounted) {
        showSnackBar(
            context, 'Phiên đăng nhập hết hạn, vui lòng đăng nhập lại');
        Navigator.pushNamedAndRemoveUntil(
            context, WelcomeScreen.routeName, (route) => false);
      }
    } else if (result.httpStatusCode != 200) {
      if (context.mounted) {
        showSnackBar(context,
            'Có lỗi xảy ra khi cập nhật dữ liệu, vui lòng thử lại sau');
      }
    }

    return result.data as List<Message>;
  }
}
