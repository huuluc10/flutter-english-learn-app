import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/auth/pages/welcome_screen.dart';
import 'package:flutter_englearn/features/friend/providers/friend_provider.dart';
import 'package:flutter_englearn/model/response/main_user_info_request.dart';
import 'package:flutter_englearn/common/helper/helper.dart';
import 'package:flutter_englearn/common/widgets/future_builder_error_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConfirmationFriendRequestWidget extends ConsumerStatefulWidget {
  const ConfirmationFriendRequestWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConfirmationFriendRequestWidgetState();
}

class _ConfirmationFriendRequestWidgetState
    extends ConsumerState<ConfirmationFriendRequestWidget> {
  List<MainUserInfoResponse> listFriendRequest = [];

  Future<List<MainUserInfoResponse>> fetchFriendRequest() async {
    listFriendRequest = await ref
        .read(friendServiceProvider)
        .getListWaitForAcceptFriendRequest(context);

    return listFriendRequest;
  }

  void acceptFriendRequest(String username) async {
    int accept =
        await ref.read(friendServiceProvider).acceptFriendRequest(username);

    if (accept == 200) {
      setState(() {});
    } else if (accept == 401) {
      if (mounted) {
        showSnackBar(context, 'Phiên đăng nhập đã hết hạn!');
        Navigator.pushNamedAndRemoveUntil(
            context, WelcomeScreen.routeName, (route) => false);
      }
    } else {
      if (mounted) {
        showSnackBar(context, 'Xác nhận yêu cầu kết bạn thất bại!');
      }
    }
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
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.cancel,
                            color: Colors.red,
                          ),
                          onPressed: () async {
                            await ref.read(friendServiceProvider).unFriend(
                                context, listFriendRequest[index].username);
                            setState(() {});
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            acceptFriendRequest(
                                listFriendRequest[index].username);
                          },
                        ),
                      ],
                    ),
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
