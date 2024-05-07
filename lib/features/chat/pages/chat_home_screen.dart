import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/auth/provider/auth_provider.dart';
import 'package:flutter_englearn/features/chat/pages/chat_room_screen.dart';
import 'package:flutter_englearn/features/user_info/controller/user_info_controller.dart';
import 'package:flutter_englearn/model/response/main_user_info_request.dart';
import 'package:flutter_englearn/common/provider/control_index_navigate_bar.dart';
import 'package:flutter_englearn/common/widgets/bottom_navigate_bar_widget.dart';
import 'package:flutter_englearn/common/widgets/future_builder_error_widget.dart';
import 'package:flutter_englearn/common/widgets/line_gradient_background_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatHome extends ConsumerStatefulWidget {
  const ChatHome({super.key});

  static const String routeName = '/chat-home-screen';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatHomeState();
}

class _ChatHomeState extends ConsumerState<ChatHome> {
  Future<String> getUsername() async {
    String username = await ref
        .watch(authServiceProvicer)
        .getUsername()
        .then((value) => value);
    return username;
  }

  @override
  Widget build(BuildContext context) {
    // Get index of bottom navigation bar
    final indexBottomNavbar = ref.watch(indexBottomNavbarProvider);

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
            child: FutureBuilder(
              future: getUsername(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return FutureBuilderErrorWidget(
                    error: snapshot.error.toString(),
                  );
                }
                String? username = snapshot.data;
                if (username != null) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Tìm kiếm',
                          prefixIcon: const Icon(Icons.search),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 0.0),
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
                                        snapshot.data
                                            as List<MainUserInfoResponse>;

                                    if (friends.isEmpty) {
                                      return const Text('Không có bạn bè');
                                    }
                                    return Row(
                                      children: [
                                        for (int i = 0; i < friends.length; i++)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
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
                                  child: ListView.builder(
                                    itemCount: 10,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, ChatRoom.routeName);
                                        },
                                        child: const ListTile(
                                          leading: CircleAvatar(
                                            backgroundImage:
                                                AssetImage('assets/male.jpg'),
                                          ),
                                          title: Text('username'),
                                          subtitle: Text('message'),
                                          trailing: Text('time'),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: Text(
                      'Lỗi không lấy được username',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigateBarWidget(index: indexBottomNavbar),
    );
  }
}
