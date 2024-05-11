import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/friend/widget/confirmation_widget.dart';
import 'package:flutter_englearn/features/friend/widget/friend_request_sent_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListFriendRequestScreen extends ConsumerStatefulWidget {
  const ListFriendRequestScreen({super.key});

  static const String routeName = '/list-friend-request-screen';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ListFriendRequestScreenState();
}

class _ListFriendRequestScreenState
    extends ConsumerState<ListFriendRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Danh sách yêu cầu kết bạn'),
          bottom: const TabBar(
            indicatorColor: Colors.blue,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: 'Chờ xác nhận'),
              Tab(text: 'Đã gửi'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ConfirmationFriendRequestWidget(),
            FriendRequestSentWidget(),
          ],
        ),
      ),
    );
  }
}


