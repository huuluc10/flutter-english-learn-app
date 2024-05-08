import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_englearn/common/helper/helper.dart';
import 'package:flutter_englearn/model/message_chatroom.dart';
import 'package:intl/intl.dart';

class ChatRoomItem extends StatelessWidget {
  final MessageChatRoom chatRoom;
  final String currentUsername;

  const ChatRoomItem({
    Key? key,
    required this.chatRoom,
    required this.currentUsername,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String avatar = chatRoom.lastMessage.sender != currentUsername
        ? chatRoom.lastMessage.senderAvatar
        : chatRoom.lastMessage.receiverAvatar;
    avatar = transformLocalURLMediaToURL(avatar);

    final username = chatRoom.lastMessage.sender != currentUsername
        ? chatRoom.lastMessage.sender
        : chatRoom.lastMessage.receiver;

    String date = DateFormat.yMd().format(chatRoom.lastMessage.timestamp);
    String time = DateFormat.Hm().format(chatRoom.lastMessage.timestamp);

    return ListTile(
      leading:
          CircleAvatar(backgroundImage: CachedNetworkImageProvider(avatar)),
      title: Text(
        username,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      subtitle: Text(
        chatRoom.lastMessage.lastMessage,
        style: const TextStyle(fontSize: 16),
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            date,
            style: const TextStyle(fontSize: 14),
          ),
          Text(
            time,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
