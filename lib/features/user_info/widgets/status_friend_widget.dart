import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/friend/providers/friend_provider.dart';
import 'package:flutter_englearn/utils/helper/helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatusFriend extends StatelessWidget {
  const StatusFriend({
    super.key,
    required this.username,
  });

  final String username;

  @override
  Widget build(BuildContext context) {
    ButtonStyle buttonStyle = OutlinedButton.styleFrom(
      backgroundColor: Colors.blueAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
      ),
    );
    return Consumer(
      builder: (context, ref, child) {
        return FutureBuilder<int>(
          future: ref
              .watch(friendServiceProvider)
              .getStatusOfFriendRequest(username),
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
                  onPressed: () {
                    showConfirmDialog(
                        context, 'Bạn có muốn hủy kết bạn với $username không?',
                        () {
                      ref
                          .watch(friendServiceProvider)
                          .unFriend(context, username);


                      Navigator.of(context).pop();
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
                return const Text(
                  'Đã gửi yêu cầu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                );
              }
              return const Text(
                'Kết bạn',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              );
            }
          },
        );
      },
    );
  }
}
