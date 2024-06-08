import 'package:flutter/material.dart';
import 'package:flutter_englearn/common/provider/common_provider.dart';
import 'package:flutter_englearn/features/auth/provider/auth_provider.dart';
import 'package:flutter_englearn/features/friend/pages/list_friend_request_screen.dart';
import 'package:flutter_englearn/features/friend/pages/list_friend_screen.dart';
import 'package:flutter_englearn/features/user_info/controller/user_info_controller.dart';
import 'package:flutter_englearn/model/response/main_user_info_request.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FriendSummaryInfo extends ConsumerStatefulWidget {
  const FriendSummaryInfo({
    super.key,
    required this.username,
  });
  final String username;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FriendState();
}

class _FriendState extends ConsumerState<FriendSummaryInfo> {
  String currentUsername = '';

  Future<void> getCurrentUsername() async {
    currentUsername = ref.watch(currentUsernameProvider);

    if (currentUsername == '') {
      currentUsername = await ref.watch(authServiceProvicer).getUsername();
      ref.read(currentUsernameProvider.notifier).state = currentUsername;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getCurrentUsername();
    });
  }

  @override
  Widget build(BuildContext context) {
    String currentUsername = ref.watch(currentUsernameProvider);

    return FutureBuilder(
      future: getFriend(context, ref, widget.username),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        final List<MainUserInfoResponse> friends =
            snapshot.data as List<MainUserInfoResponse>;

        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: <Widget>[
                  InkWell(
                    onTap: () => Navigator.pushNamed(
                      context,
                      ListFriendScreen.routeName,
                      arguments: friends,
                    ),
                    child: const Text(
                      'Bạn bè ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    '(${friends.length})',
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  if (currentUsername == widget.username)
                    InkWell(
                      onTap: () => Navigator.pushNamed(
                        context,
                        ListFriendRequestScreen.routeName,
                      ),
                      child: const Text(
                        'Danh sách yêu cầu',
                        style:
                            TextStyle(color: Colors.blueAccent, fontSize: 17),
                      ),
                    )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
