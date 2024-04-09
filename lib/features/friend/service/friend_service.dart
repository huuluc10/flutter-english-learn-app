import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/auth/pages/welcome_screen.dart';
import 'package:flutter_englearn/features/friend/repository/friend_repository.dart';
import 'package:flutter_englearn/model/request/friend_required_request.dart';
import 'package:flutter_englearn/model/response/main_user_info_request.dart';
import 'package:flutter_englearn/model/response/response_model.dart';
import 'package:flutter_englearn/model/result_return.dart';
import 'package:flutter_englearn/utils/helper/helper.dart';

class FriendService {
  final FriendRepository friendRepository;

  FriendService({required this.friendRepository});

  Future<List<MainUserInfoResponse>> getFriends(
      BuildContext context, String username) async {
    ResponseModel response = await friendRepository.getFriend(username);

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

      // Update url avatar
      for (int i = 0; i < listMainUserInfoResponse.length; i++) {
        String oldURL = listMainUserInfoResponse[i].urlAvatar;
        String newURL = transformLocalURLAvatarToURL(oldURL);
        listMainUserInfoResponse[i].urlAvatar = newURL;
      }
      return listMainUserInfoResponse;
    }
  }

  Future<ResultReturn> addFriend(String username) async {
    // Get current user
    String currentUsername =
        await friendRepository.authRepository.getUserName();
    FriendRequiredRequest request =
        FriendRequiredRequest(sender: currentUsername, receiver: username);
    return await friendRepository.addFriend(request.toJson());
  }

  Future<int> getStatusOfFriendRequest(String username) async {
    // Get current user
    String currentUsername =
        await friendRepository.authRepository.getUserName();
    FriendRequiredRequest request =
        FriendRequiredRequest(sender: currentUsername, receiver: username);
    ResultReturn result =  await friendRepository.getStatusOfRequest(request.toJson());
    return result.data as int;
  }
}
