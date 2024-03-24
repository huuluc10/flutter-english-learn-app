import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/chat/page/chat_room_screen.dart';
import 'package:flutter_englearn/utils/service/control_index_navigate_bar.dart';
import 'package:flutter_englearn/utils/widgets/bottom_navigate_bar_widget.dart';
import 'package:flutter_englearn/utils/widgets/line_gradient_background_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatHome extends ConsumerWidget {
  const ChatHome({super.key});

  static const String routeName = '/chat-home-screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get index of bottom navigation bar
    final indexBottomNavbar = ref.watch(indexBottomNavbarProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Chat'),
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
                          child: Row(
                            children: [
                              for (int i = 0; i < 10; i++)
                                const Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:
                                            AssetImage('assets/male.jpg'),
                                        radius: 25,
                                      ),
                                      Text('username'),
                                    ],
                                  ),
                                ),
                            ],
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
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigateBarWidget(index: indexBottomNavbar),
    );
  }
}
