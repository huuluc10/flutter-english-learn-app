import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/friend/providers/friend_provider.dart';
import 'package:flutter_englearn/common/utils/helper/helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatusFriend extends ConsumerStatefulWidget {
  const StatusFriend({
    super.key,
    required this.username,
  });

  final String username;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StatusFriendState();
}

class _StatusFriendState extends ConsumerState<StatusFriend> {
  ButtonStyle buttonStyle = OutlinedButton.styleFrom(
    backgroundColor: Colors.blueAccent,
  );
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: ref
          .watch(friendServiceProvider)
          .getStatusOfFriendRequest(widget.username),
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // show loading spinner while waiting
        } else if (snapshot.hasError) {
          return OutlinedButton(
            onPressed: () {},
            style: buttonStyle,
            child: const Text(
              'Lỗi',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
            ),
          );
        } else {
          int? statusRequest = snapshot.data;
          if (statusRequest == 1) {
            return OutlinedButton(
              onPressed: () async {
                await showConfirmDialog(context,
                    'Bạn có muốn hủy kết bạn với ${widget.username} không?',
                    () async {
                  await ref
                      .watch(friendServiceProvider)
                      .unFriend(context, widget.username);

                  Navigator.of(context).pop();
                  setState(() {});
                });
              },
              style: buttonStyle,
              child: const Text(
                'Đã kết bạn',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            );
          } else if (statusRequest == 0) {
            return OutlinedButton(
              onPressed: () async {
                await showConfirmDialog(context,
                    'Bạn có muốn hủy kết bạn với ${widget.username} không?',
                    () async {
                  await ref
                      .watch(friendServiceProvider)
                      .unFriend(context, widget.username);

                  Navigator.of(context).pop();
                  setState(() {});
                });
              },
              style: buttonStyle,
              child: const Text(
                'Đã gửi yêu cầu kết bạn',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            );
          }
          return OutlinedButton(
            style: buttonStyle,
            onPressed: () async {
              await ref.watch(friendServiceProvider).addFriend(widget.username);
              setState(() {});
            },
            child: const Text(
              'Kết bạn',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
            ),
          );
        }
      },
    );
  }
}
