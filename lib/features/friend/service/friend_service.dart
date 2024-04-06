import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/auth/pages/welcome_screen.dart';
import 'package:flutter_englearn/features/friend/repository/friend_repository.dart';
import 'package:flutter_englearn/model/response/main_user_info_request.dart';
import 'package:flutter_englearn/model/response/response_model.dart';
import 'package:flutter_englearn/utils/helper/helper.dart';

class FriendService {
  final FriendRepository _friendRepository;

  FriendService(this._friendRepository);

  Future<List<MainUserInfoResponse>> getFriends(
      BuildContext context, String username) async {
    ResponseModel response = await _friendRepository.getFriend(username);

    if (response.status == '401') {
      showSnackBar(context, 'Phiên đăng nhập đã hết hạn!');
      Navigator.pushNamedAndRemoveUntil(
          context, WelcomeScreen.routeName, (route) => false);
      throw Exception('Phiên đăng nhập đã hết hạn!');
    } else if (response.status == '400') {
      showSnackBar(context, 'Lấy danh sách bạn bè thất bại!');
      throw Exception('Lấy danh sách bạn bè thất bại!');
    } else {
      List<MainUserInfoResponse> listMainUserInfoResponse =
          response.data as List<MainUserInfoResponse>;
      return listMainUserInfoResponse;
    }
  }
}
