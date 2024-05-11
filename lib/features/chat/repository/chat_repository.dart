import 'dart:convert';

import 'package:flutter_englearn/common/utils/api_url.dart';
import 'package:flutter_englearn/common/utils/utils.dart';
import 'package:flutter_englearn/features/auth/repository/auth_repository.dart';
import 'package:flutter_englearn/model/message.dart';
import 'package:flutter_englearn/model/message_chatroom.dart';
import 'package:flutter_englearn/model/result_return.dart';
import 'package:http/http.dart';

class ChatRepository {
  final AuthRepository authRepository;

  ChatRepository({required this.authRepository});

  Future<ResultReturn> getAllChatRoom() async {
    String username = await authRepository.getUserName();
    // Call api
    Uri url = Uri.http(APIUrl.baseUrlSocketHttp, APIUrl.pathGetAllChatRoom,
        {"participant": username});
    Map<String, String> headersHTTP = Map.from(httpHeaders);

    final Response response = await get(url, headers: headersHTTP);

    if (response.statusCode == 200) {
      List<MessageChatRoom> chatRooms = [];

      final List jsonResponse = jsonDecode(response.body);
      chatRooms =
          jsonResponse.map((item) => MessageChatRoom.fromMap(item)).toList();

      return ResultReturn(httpStatusCode: 200, data: chatRooms);
    } else if (response.statusCode == 401) {
      await authRepository.removeJWT();
    }
    return ResultReturn(httpStatusCode: response.statusCode, data: null);
  }

  Future<ResultReturn> markMessageAsRead(String chatRoomId) async {
    Uri url = Uri.http(APIUrl.baseUrlSocketHttp, APIUrl.pathMarkAsRead,
        {"chatId": chatRoomId});
    Map<String, String> headersHTTP = Map.from(httpHeaders);

    final Response response = await post(url, headers: headersHTTP);

    if (response.statusCode == 200) {
      return ResultReturn(httpStatusCode: 200, data: null);
    } else if (response.statusCode == 401) {
      await authRepository.removeJWT();
      return ResultReturn(httpStatusCode: 401, data: null);
    }
    return ResultReturn(httpStatusCode: response.statusCode, data: null);
  }

  Future<ResultReturn> getHistoryChat(String chatRoomId) async {
    Uri url = Uri.http(APIUrl.baseUrlSocketHttp, "/chat/$chatRoomId/history");
    Map<String, String> headersHTTP = Map.from(httpHeaders);

    final Response response = await get(url, headers: headersHTTP);

    if (response.statusCode == 200) {
      List<Message> messages = [];

      final List jsonResponse = jsonDecode(response.body);
      messages = jsonResponse.map((item) => Message.fromMap(item)).toList();

      return ResultReturn(httpStatusCode: 200, data: messages);
    } else if (response.statusCode == 401) {
      await authRepository.removeJWT();
    }
    return ResultReturn(httpStatusCode: response.statusCode, data: null);
  }
}
