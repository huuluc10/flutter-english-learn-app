import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/friend/providers/friend_provider.dart';
import 'package:flutter_englearn/model/response/main_user_info_request.dart';
import 'package:flutter_englearn/common/widgets/future_builder_error_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FriendRequestSentWidget extends ConsumerStatefulWidget {
  const FriendRequestSentWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FriendRequestSentWidgetState();
}

class _FriendRequestSentWidgetState
    extends ConsumerState<FriendRequestSentWidget> {
  List<MainUserInfoResponse> listFriendRequest = [];

  Future<List<MainUserInfoResponse>> fetchFriendRequest() async {
    if (listFriendRequest.isEmpty) {
      listFriendRequest = await ref
          .read(friendServiceProvider)
          .getListFriendRequestIsSent(context);
    }
    return listFriendRequest;
  }

  void cancelFriendRequest(String username) async {
    await ref.read(friendServiceProvider).unFriend(context, username);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: FutureBuilder<List<MainUserInfoResponse>>(
        future: fetchFriendRequest(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return FutureBuilderErrorWidget(error: snapshot.error.toString());
          } else {
            if (listFriendRequest.isEmpty) {
              return const Center(
                child: Text(
                  'Trống',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }
            return ListView.builder(
              itemCount: listFriendRequest.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(listFriendRequest[index].urlAvatar),
                  ),
                  title: Text(
                    listFriendRequest[index].username,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(
                    listFriendRequest[index].fullName,
                    style: const TextStyle(fontSize: 14),
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      cancelFriendRequest(listFriendRequest[index].username);
                    },
                    child: const Text('Xóa'),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
