import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/user_info/pages/more_info_screen.dart';
import 'package:flutter_englearn/model/response/user_info_response.dart';

class MoreUserInfoButton extends StatelessWidget {
  const MoreUserInfoButton({
    super.key,
    required this.isMe,
    required this.userInfo,
  });

  final bool isMe;
  final UserInfoResponse userInfo;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.pushNamed(
          context,
          MoreUserInfoScreen.routeName,
          arguments: [
            isMe,
            userInfo,
          ],
        );
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
      child: const Text(
        'Chỉnh sửa thông tin',
        style: TextStyle(
          color: Colors.white,
          fontSize: 17,
        ),
      ),
    );
  }
}
