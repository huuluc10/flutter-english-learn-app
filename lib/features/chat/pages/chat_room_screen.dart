import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_englearn/common/provider/common_provider.dart';
import 'package:flutter_englearn/common/utils/api_url.dart';
import 'package:flutter_englearn/common/widgets/future_builder_error_widget.dart';
import 'package:flutter_englearn/features/chat/provider/chat_provider.dart';
import 'package:flutter_englearn/features/chat/widgets/receiver_message_widget.dart';
import 'package:flutter_englearn/features/chat/widgets/sender_message_widget.dart';
import 'package:flutter_englearn/features/user_info/pages/user_info_screen.dart';
import 'package:flutter_englearn/common/widgets/line_gradient_background_widget.dart';
import 'package:flutter_englearn/features/user_info/providers/user_info_provider.dart';
import 'package:flutter_englearn/model/message.dart';
import 'package:flutter_englearn/model/request/send_message_request.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class ChatRoomScreen extends ConsumerStatefulWidget {
  const ChatRoomScreen({
    super.key,
    required this.chatId,
    required this.usernameReceiver,
    required this.receriverAvatar,
  });

  static const String routeName = '/chat-room-screen';
  final String chatId;
  final String usernameReceiver;
  final String receriverAvatar;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends ConsumerState<ChatRoomScreen> {
  List<Message> messages = [];
  late StompClient _client;
  late String currentUsername;
  final TextEditingController _messageController = TextEditingController();
  late String senderAvatar;
  final ScrollController messageController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      currentUsername = ref.watch(currentUsernameProvider);
      connectWebsocket();
    });
  }

  _fetchData() async {
    String? currentAvatar = ref.watch(currentAvatarProvider);

    if (currentAvatar != null) {
      senderAvatar = currentAvatar;
    } else {
      currentAvatar =
          await ref.watch(userInfoServiceProvider).getAvatar(context, ref);
      senderAvatar = currentAvatar!;
    }

    if (messages.isEmpty) {
      if (mounted) {
        messages = await ref
            .watch(chatServiceProvider)
            .getHistoryChat(context, widget.chatId);
      } else {
        messages = [];
      }
    }
    return messages;
  }

  @override
  void dispose() {
    super.dispose();
    _client.deactivate();
  }

  void sendMessage(
      String senderAvatar, String receiver, String receiverAvatar) {
    if (_messageController.text.isNotEmpty) {
      SendMessageRequest message = SendMessageRequest(
        message: _messageController.text,
        sender: currentUsername,
        senderAvatar: senderAvatar,
        receiver: receiver,
        receiverAvatar: receiverAvatar,
      );
      _client.send(
        destination: '/app/chat',
        body: message.toJson(), //
      );
      _messageController.clear();
    }
  }

  void connectWebsocket() {
    const String webSocketUrl = APIUrl.baseUrlSocket;
    _client = StompClient(
        config: StompConfig(url: webSocketUrl, onConnect: onConnectCallback));
    _client.activate();
  }

  void onConnectCallback(StompFrame connectFrame) async {
    _client.subscribe(
        destination: '/user/$currentUsername/queue/chat/${widget.chatId}',
        headers: {},
        callback: (frame) {
          ref.watch(haveNewMessageProvider.notifier).update((value) => true);
          Map<String, dynamic> map =
              json.decode(frame.body!) as Map<String, dynamic>;
          Message newMessage = Message.fromMap(map['payload']);
          // Cập nhật danh sách chat và hiển thị tin nhắn mới nhất

          setState(() {
            messages.add(newMessage);
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(widget.usernameReceiver),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded),
            onPressed: () {
              Navigator.pushNamed(context, UserInfoScreen.routeName,
                  arguments: widget.usernameReceiver);
            },
          ),
        ],
      ),
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      body: LineGradientBackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 8,
            right: 8,
            top: 50,
            bottom: 20,
          ),
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height - 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: const Color.fromARGB(127, 255, 255, 255),
            ),
            child: Expanded(
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  child: FutureBuilder(
                    future: _fetchData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return FutureBuilderErrorWidget(
                            error: snapshot.error.toString());
                      }
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        messageController
                            .jumpTo(messageController.position.maxScrollExtent);
                      });
                      return ListView.builder(
                        controller: messageController,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          if (messages[index].sender == currentUsername) {
                            senderAvatar = messages[index].senderAvatar;
                            return SenderMessageWidget(
                              message: messages[index].lastMessage,
                              avatarUrl: messages[index].senderAvatar,
                            );
                          } else {
                            return ReceiverMessageWidget(
                              message: messages[index].lastMessage,
                              avatarUrl: messages[index].receiverAvatar,
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 10,
                bottom: 10,
              ),
              child: TextFormField(
                controller: _messageController,
                onFieldSubmitted: (value) {
                  if (value.isNotEmpty) {
                    sendMessage(senderAvatar, widget.usernameReceiver,
                        widget.receriverAvatar);
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            sendMessage(senderAvatar, widget.usernameReceiver,
                                widget.receriverAvatar);
                          },
                          icon: const Icon(
                            Icons.send,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(64),
                  ),
                  hintText: "Aa",
                  contentPadding: const EdgeInsets.all(5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
