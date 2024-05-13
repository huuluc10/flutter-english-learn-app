import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_englearn/common/helper/helper.dart';
import 'package:flutter_englearn/common/provider/common_provider.dart';
import 'package:flutter_englearn/common/utils/api_url.dart';
import 'package:flutter_englearn/features/chat/pages/chat_room_screen.dart';
import 'package:flutter_englearn/features/chat/provider/chat_provider.dart';
import 'package:flutter_englearn/features/chat/widgets/chat_room_item_widget.dart';
import 'package:flutter_englearn/features/user_info/controller/user_info_controller.dart';
import 'package:flutter_englearn/model/message_chatroom.dart';
import 'package:flutter_englearn/model/response/main_user_info_request.dart';
import 'package:flutter_englearn/common/widgets/bottom_navigate_bar_widget.dart';
import 'package:flutter_englearn/common/widgets/future_builder_error_widget.dart';
import 'package:flutter_englearn/common/widgets/line_gradient_background_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class ChatHome extends ConsumerStatefulWidget {
  const ChatHome({super.key});

  static const String routeName = '/chat-home-screen';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatHomeState();
}

class _ChatHomeState extends ConsumerState<ChatHome> {
  late StompClient _client;
  String username = '';
  List<MessageChatRoom> chatRooms = [];
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      username = ref.watch(currentUsernameProvider);
      connectWebsocket();
    });
  }

  void connectWebsocket() {
    const String webSocketUrl = APIUrl.baseUrlSocket;
    _client = StompClient(
        config: StompConfig(url: webSocketUrl, onConnect: onConnectCallback));
    _client.activate();
  }

  Future<List<MessageChatRoom>> _fetchChatRooms() async {
    if (chatRooms.isEmpty) {
      chatRooms = await ref.watch(chatServiceProvider).getAllChatRoom(context);
    }
    return chatRooms;
  }

  void onConnectCallback(StompFrame connectFrame) async {
    _client.subscribe(
        destination: '/user/$username/queue/chats',
        headers: {},
        callback: (frame) {
          ref.watch(haveNewMessageProvider.notifier).update((value) => true);
          MessageChatRoom messageChatRoom =
              MessageChatRoom.fromJson(frame.body as String);

          // Cập nhật danh sách chatRoom và hiển thị tin nhắn mới nhất

          setState(() {
            final chatRoomIndex = chatRooms.indexWhere(
                (chatRoom) => chatRoom.chatId == messageChatRoom.chatId);
            if (chatRoomIndex != -1) {
              chatRooms[chatRoomIndex] = messageChatRoom;
            } else {
              chatRooms.add(messageChatRoom);
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    // Get index of bottom navigation bar
    final indexBottomNavbar = ref.watch(indexBottomNavbarProvider);
    _fetchChatRooms();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Trao đổi'),
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Tìm kiếm',
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height - 225,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32.0),
                    color: const Color.fromARGB(127, 255, 255, 255),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Danh sách bạn bè',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: FutureBuilder(
                            future: getFriend(context, ref, username),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasError) {
                                return FutureBuilderErrorWidget(
                                  error: snapshot.error.toString(),
                                );
                              }
                              final List<MainUserInfoResponse> friends =
                                  snapshot.data as List<MainUserInfoResponse>;

                              if (friends.isEmpty) {
                                return const Text('Không có bạn bè');
                              }
                              return Row(
                                children: [
                                  for (int i = 0; i < friends.length; i++)
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: InkWell(
                                        onTap: () async {
                                          String? chatRoomId = await ref
                                              .watch(chatServiceProvider)
                                              .getChatRoomIdWithParticipants(
                                                  context, friends[i].username);

                                          if (chatRoomId == null) {
                                            showSnackBar(context,
                                                'Có lỗi xảy ra, vui lòng thử lại sau');
                                          }

                                          Navigator.pushNamed(
                                            context,
                                            ChatRoomScreen.routeName,
                                            arguments: [
                                              chatRoomId,
                                              friends[i].username,
                                              friends[i].urlAvatar,
                                            ],
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              backgroundImage:
                                                  CachedNetworkImageProvider(
                                                friends[i].urlAvatar,
                                              ),
                                              radius: 25,
                                            ),
                                            Text(friends[i].username),
                                          ],
                                        ),
                                      ),
                                    )
                                ],
                              );
                            },
                          ),
                        ),
                        const Text(
                          'Tin nhắn mới nhất',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Expanded(
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: FutureBuilder(
                                future: _fetchChatRooms(),
                                builder: (context, snapshot) {
                                  SchedulerBinding.instance
                                      .addPostFrameCallback((_) {
                                    scrollController.jumpTo(scrollController
                                        .position.maxScrollExtent);
                                  });
                                  return ListView.builder(
                                    controller: scrollController,
                                    itemCount: chatRooms.length,
                                    itemBuilder: (context, index) {
                                      if (chatRooms.isEmpty) {
                                        return const Text('Không có tin nhắn');
                                      }
                                      final chatRoom = chatRooms[index];
                                      return InkWell(
                                        onTap: () async {
                                          await ref
                                              .watch(chatServiceProvider)
                                              .markMessageAsRead(
                                                  context, chatRoom.chatId);

                                          String receiverUsername =
                                              chatRoom.participants[0] ==
                                                      username
                                                  ? chatRoom.participants[1]
                                                  : chatRoom.participants[0];

                                          String receiverAvatar =
                                              receiverUsername ==
                                                      chatRoom
                                                          .lastMessage.sender
                                                  ? chatRoom
                                                      .lastMessage.senderAvatar
                                                  : chatRoom.lastMessage
                                                      .receiverAvatar;

                                          Navigator.pushNamed(
                                            context,
                                            ChatRoomScreen.routeName,
                                            arguments: [
                                              chatRoom.chatId,
                                              receiverUsername,
                                              receiverAvatar,
                                            ],
                                          );
                                        },
                                        child: ChatRoomItem(
                                          currentUsername: username,
                                          chatRoom: chatRoom,
                                        ),
                                      );
                                    },
                                  );
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigateBarWidget(index: indexBottomNavbar),
    );
  }
}
