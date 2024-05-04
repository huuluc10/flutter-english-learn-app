import 'package:flutter_englearn/features/auth/repository/auth_repository.dart';
import 'package:flutter_englearn/model/response/main_user_info_request.dart';
import 'package:flutter_englearn/model/response/response_model.dart';
import 'package:flutter_englearn/model/result_return.dart';
import 'package:flutter_englearn/utils/const/api_url.dart';
import 'package:flutter_englearn/utils/const/utils.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FriendRepository {
  final AuthRepository authRepository;

  FriendRepository({required this.authRepository});

  Future<ResponseModel> getFriend(String username) async {
    // get jwt token from authRepository
    final jwtResponse = await authRepository.getJWTCurrent();

    if (jwtResponse == null) {
      log('Token is null', name: 'FriendRepository');
      return ResponseModel(status: '401', message: 'Token is null', data: null);
    } else {
      log('Get list friend', name: 'FriendRepository');

      String jwt = jwtResponse.token;
      Map<String, String> headers = Map.from(httpHeaders);
      headers['Authorization'] = 'Bearer $jwt';

      String authority = APIUrl.baseUrl;
      String unencodedPath = APIUrl.pathGetFriendByUsername + username;

      var response = await http.get(
        Uri.http(authority, unencodedPath),
        headers: headers,
      );

      if (response.statusCode == 401) {
        log('Token is expired', name: 'FriendRepository');
        await authRepository.removeJWT();
        return ResponseModel(
          status: response.statusCode.toString(),
          message: 'Token is expired',
          data: null,
        );
      }

      if (response.statusCode != 200) {
        log('Get list friend failed', name: 'FriendRepository');
        return ResponseModel(
          status: response.statusCode.toString(),
          message: 'Get list friend failed',
          data: null,
        );
      }

      log("Get list friend successfully", name: 'FriendRepository');
      ResponseModel responseModel = ResponseModel.fromJson(response.body);

      List<MainUserInfoResponse> listMainUserInfoResponse = [];
      for (var item in responseModel.data as List<dynamic>) {
        listMainUserInfoResponse.add(MainUserInfoResponse.fromMap(item));
      }

      return ResponseModel(
        status: '200',
        message: 'Get list friend',
        data: listMainUserInfoResponse,
      );
    }
  }

  Future<ResultReturn> addFriend(String body) async {
    // get jwt token from authRepository
    final jwtResponse = await authRepository.getJWTCurrent();

    if (jwtResponse == null) {
      log('Token is null', name: 'FriendRepository');
      return ResultReturn(httpStatusCode: 401, data: null);
    } else {
      log('Add friend', name: 'FriendRepository');

      String jwt = jwtResponse.token;
      Map<String, String> headers = Map.from(httpHeaders);
      headers['Authorization'] = 'Bearer $jwt';

      String authority = APIUrl.baseUrl;
      String unencodedPath = APIUrl.pathAddFriend;

      var response = await http.post(
        Uri.http(authority, unencodedPath),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 401) {
        log('Token is expired', name: 'FriendRepository');
        await authRepository.removeJWT();
        return ResultReturn(
          httpStatusCode: response.statusCode,
          data: null,
        );
      } else if (response.statusCode == 400) {
        log('Add friend failed', name: 'FriendRepository');
        return ResultReturn(
          httpStatusCode: response.statusCode,
          data: null,
        );
      } else {
        log("Add friend successfully", name: 'FriendRepository');
        return ResultReturn(
          httpStatusCode: 200,
          data: null,
        );
      }
    }
  }

  Future<ResultReturn<int>> getStatusOfRequest(String body) async {
    // get jwt token from authRepository
    final jwtResponse = await authRepository.getJWTCurrent();

    if (jwtResponse == null) {
      log('Token is null', name: 'FriendRepository');
      return ResultReturn(httpStatusCode: 401, data: null);
    } else {
      log('Add friend', name: 'FriendRepository');

      String jwt = jwtResponse.token;
      Map<String, String> headers = Map.from(httpHeaders);
      headers['Authorization'] = 'Bearer $jwt';

      String authority = APIUrl.baseUrl;
      String unencodedPath = APIUrl.pathGetStatusOfRequestFriend;

      var response = await http.post(
        Uri.http(authority, unencodedPath),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 401) {
        log('Token is expired', name: 'FriendRepository');
        await authRepository.removeJWT();
        return ResultReturn(
          httpStatusCode: response.statusCode,
          data: null,
        );
      } else if (response.statusCode == 400) {
        log('Get status of friend request failed', name: 'FriendRepository');
        return ResultReturn(
          httpStatusCode: response.statusCode,
          data: null,
        );
      } else {
        log("Get status of friend request successfully",
            name: 'FriendRepository');
        ResponseModel responseModel = ResponseModel.fromJson(response.body);
        int status = -1;

        if (responseModel.data != null) {
          status = responseModel.data as int;
        }
        return ResultReturn(
          httpStatusCode: 200,
          data: status,
        );
      }
    }
  }

  Future<ResultReturn> unfriend(String body) async {
    // get jwt token from authRepository
    final jwtResponse = await authRepository.getJWTCurrent();

    if (jwtResponse == null) {
      log('Token is null', name: 'FriendRepository');
      return ResultReturn(httpStatusCode: 401, data: null);
    } else {
      log('Unfriend', name: 'FriendRepository');

      String jwt = jwtResponse.token;
      Map<String, String> headers = Map.from(httpHeaders);
      headers['Authorization'] = 'Bearer $jwt';

      String authority = APIUrl.baseUrl;
      String unencodedPath = APIUrl.pathUnFriend;

      var response = await http.post(
        Uri.http(authority, unencodedPath),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 401) {
        log('Token is expired', name: 'FriendRepository');
        await authRepository.removeJWT();
        return ResultReturn(
          httpStatusCode: response.statusCode,
          data: null,
        );
      } else if (response.statusCode == 400) {
        log('Unfriend failed', name: 'FriendRepository');
        return ResultReturn(
          httpStatusCode: response.statusCode,
          data: null,
        );
      } else {
        log("Unfriend successfully", name: 'FriendRepository');
        return ResultReturn(
          httpStatusCode: 200,
          data: null,
        );
      }
    }
  }

  Future<List<String>> getHistoryFindFriend() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> listHistoryFindFriend =
        prefs.getStringList('historyFindFriend') ?? [];
    return listHistoryFindFriend;
  }

  Future<void> addHistoryFindFriend(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> listHistoryFindFriend =
        prefs.getStringList('historyFindFriend') ?? [];
    if (listHistoryFindFriend.contains(username)) {
      listHistoryFindFriend.remove(username);
    }
    listHistoryFindFriend.insert(0, username);
    if (listHistoryFindFriend.length > 5) {
      listHistoryFindFriend.removeLast();
    }
    prefs.setStringList('historyFindFriend', listHistoryFindFriend);
  }

  Future<void> removeHistoryFindFriend() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('historyFindFriend');
  }

  Future<void> deleteFromHistoryFindFriend(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> listHistoryFindFriend =
        prefs.getStringList('historyFindFriend') ?? [];
    listHistoryFindFriend.remove(username);
    prefs.setStringList('historyFindFriend', listHistoryFindFriend);
  }

  Future<ResultReturn> getUserByUsername(String username) async {
    // get jwt token from authRepository
    final jwtResponse = await authRepository.getJWTCurrent();

    if (jwtResponse == null) {
      log('Token is null', name: 'FriendRepository');
      return ResultReturn(httpStatusCode: 401, data: null);
    } else {
      log('Get users by username', name: 'FriendRepository');

      String jwt = jwtResponse.token;
      Map<String, String> headers = Map.from(httpHeaders);
      headers['Authorization'] = 'Bearer $jwt';

      String authority = APIUrl.baseUrl;
      String unencodedPath = APIUrl.pathFindFriend;

      Map<String, String> body = {};
      body['username'] = username;

      Uri uri = Uri.http(authority, unencodedPath);

      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll(headers)
        ..fields.addAll(body);

      var response = await request.send();

      if (response.statusCode == 401) {
        await authRepository.removeJWT();
        ResultReturn(httpStatusCode: response.statusCode, data: null);
      } else if (response.statusCode == 400) {
        log('Get users by username failed', name: 'FriendRepository');
        return ResultReturn(httpStatusCode: response.statusCode, data: null);
      }
      log("Get users by username successfully", name: 'FriendRepository');

      ResponseModel responseModel =
          ResponseModel.fromJson(await response.stream.bytesToString());
      List<MainUserInfoResponse> listMainUserInfoResponse =
          (responseModel.data as List<dynamic>)
              .map((item) => MainUserInfoResponse.fromMap(item))
              .toList();
      return ResultReturn(httpStatusCode: 200, data: listMainUserInfoResponse);
    }
  }
}
