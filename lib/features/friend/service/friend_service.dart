import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/auth/pages/welcome_screen.dart';
import 'package:flutter_englearn/features/friend/repository/friend_repository.dart';
import 'package:flutter_englearn/model/request/friend_required_request.dart';
import 'package:flutter_englearn/model/response/main_user_info_request.dart';
import 'package:flutter_englearn/model/response/response_model.dart';
import 'package:flutter_englearn/model/result_return.dart';
import 'dart:developer';
import 'package:flutter_englearn/common/utils/helper/helper.dart';

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
        String newURL = transformLocalURLMediaToURL(oldURL);
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
    ResultReturn result =
        await friendRepository.getStatusOfRequest(request.toJson());
    return result.data as int;
  }

  Future<void> unFriend(BuildContext context, String username) async {
    // Get current user
    String currentUsername =
        await friendRepository.authRepository.getUserName();
    FriendRequiredRequest request =
        FriendRequiredRequest(sender: currentUsername, receiver: username);
    ResultReturn result = await friendRepository.unfriend(request.toJson());

    if (result.httpStatusCode == 200) {
      log('Hủy kết bạn thành công', name: 'FriendService');
      showSnackBar(context, 'Hủy kết bạn thành công!');
    } else {
      log('Hủy kết bạn thất bại', name: 'FriendService');
      showSnackBar(context, 'Hủy kết bạn thất bại!');
    }
  }

  Future<List<String>> getHistoryFindFriend() async {
    return await friendRepository.getHistoryFindFriend();
  }

  Future<void> addHistoryFindFriend(String username) async {
    await friendRepository.addHistoryFindFriend(username);
  }

  Future<void> deleteHistoryFindFriend(String username) async {
    await friendRepository.deleteFromHistoryFindFriend(username);
  }

  Future<List<MainUserInfoResponse>> findUsers(
      BuildContext context, String username) async {
    ResultReturn result = await friendRepository.getUserByUsername(username);

    if (result.httpStatusCode == 401) {
      showSnackBar(context, 'Phiên đăng nhập đã hết hạn!');
      Navigator.pushNamedAndRemoveUntil(
          context, WelcomeScreen.routeName, (route) => false);
    } else if (result.httpStatusCode == 400) {
      showSnackBar(context, 'Tìm kiếm thất bại!');
      return [];
    } else {
      List<MainUserInfoResponse> listMainUserInfoResponse =
          result.data as List<MainUserInfoResponse>;

      // Update url avatar
      for (int i = 0; i < listMainUserInfoResponse.length; i++) {
        String oldURL = listMainUserInfoResponse[i].urlAvatar;
        String newURL = transformLocalURLMediaToURL(oldURL);
        listMainUserInfoResponse[i].urlAvatar = newURL;
      }
      return listMainUserInfoResponse;
    }
    return [];
  }

  Future<List<MainUserInfoResponse>> getListWaitForAcceptFriendRequest(
      BuildContext context) async {
    ResultReturn response =
        await friendRepository.getListRequestWaitForAccept();

    if (response.httpStatusCode == '401') {
      showSnackBar(context, 'Phiên đăng nhập đã hết hạn!');
      Navigator.pushNamedAndRemoveUntil(
          context, WelcomeScreen.routeName, (route) => false);
      throw Exception('Phiên đăng nhập đã hết hạn!');
    } else if (response.httpStatusCode == '400') {
      showSnackBar(context, 'Lấy danh sách yêu cầu kết bạn thất bại!');
      throw Exception('Lấy danh sách yêu cầu kết bạn thất bại!');
    } else {
      List<MainUserInfoResponse> listMainUserInfoResponse =
          response.data as List<MainUserInfoResponse>;

      // Update url avatar
      for (int i = 0; i < listMainUserInfoResponse.length; i++) {
        String oldURL = listMainUserInfoResponse[i].urlAvatar;
        String newURL = transformLocalURLMediaToURL(oldURL);
        listMainUserInfoResponse[i].urlAvatar = newURL;
      }
      return listMainUserInfoResponse;
    }
  }

  Future<int> acceptFriendRequest(String sender) async {
    // Get current user
    String currentUsername =
        await friendRepository.authRepository.getUserName();
    FriendRequiredRequest request =
        FriendRequiredRequest(sender: sender, receiver: currentUsername);
    ResultReturn result =
        await friendRepository.acceptFriendRequest(request.toJson());

    return result.httpStatusCode;
  }

  Future<List<MainUserInfoResponse>> getListFriendRequestIsSent(
      BuildContext context) async {
    ResultReturn response = await friendRepository.getListRequestIsSent();

    if (response.httpStatusCode == 401) {
      if (context.mounted) {
        showSnackBar(context, 'Phiên đăng nhập đã hết hạn!');
        Navigator.pushNamedAndRemoveUntil(
            context, WelcomeScreen.routeName, (route) => false);
      }
    } else if (response.httpStatusCode == 200) {
      List<MainUserInfoResponse> listMainUserInfoResponse =
          response.data as List<MainUserInfoResponse>;

      // Update url avatar
      for (int i = 0; i < listMainUserInfoResponse.length; i++) {
        String oldURL = listMainUserInfoResponse[i].urlAvatar;
        String newURL = transformLocalURLMediaToURL(oldURL);
        listMainUserInfoResponse[i].urlAvatar = newURL;
      }
      return listMainUserInfoResponse;
    }
    if (context.mounted) {
      showSnackBar(context, 'Lấy danh sách yêu cầu kết bạn thất bại!');
    }
    return [];
  }
}
