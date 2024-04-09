import 'package:flutter_englearn/features/auth/repository/auth_repository.dart';
import 'package:flutter_englearn/model/response/main_user_info_request.dart';
import 'package:flutter_englearn/model/response/response_model.dart';
import 'package:flutter_englearn/model/result_return.dart';
import 'package:flutter_englearn/utils/const/api_url.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_englearn/utils/const/base_header_http.dart';

class FriendRepository {
  final AuthRepository authRepository;

  FriendRepository({required this.authRepository});

  Future<ResponseModel> getFriend(String username) async {
    // get jwt token from authRepository
    final jwtResponse = await authRepository.getJWTCurrent();

    if (jwtResponse == null) {
      log('Token is null', name: 'UserInfoRepository');
      return ResponseModel(status: '401', message: 'Token is null', data: null);
    } else {
      log('Get list friend', name: 'UserInfoRepository');

      String jwt = jwtResponse.token;
      Map<String, String> headers = BaseHeaderHttp.headers;
      headers['Authorization'] = 'Bearer $jwt';

      String authority = APIUrl.baseUrl;
      String unencodedPath = APIUrl.pathGetFriendByUsername + username;

      var response = await http.get(
        Uri.http(authority, unencodedPath),
        headers: headers,
      );

      if (response.statusCode != 200) {
        log('Get list friend failed', name: 'UserInfoRepository');
        return ResponseModel(
          status: response.statusCode.toString(),
          message: 'Get list friend failed',
          data: null,
        );
      }

      log("Get list friend successfully", name: 'UserInfoRepository');
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
      log('Token is null', name: 'UserInfoRepository');
      return ResultReturn(httpStatusCode: 401, data: null);
    } else {
      log('Add friend', name: 'UserInfoRepository');

      String jwt = jwtResponse.token;
      Map<String, String> headers = BaseHeaderHttp.headers;
      headers['Authorization'] = 'Bearer $jwt';

      String authority = APIUrl.baseUrl;
      String unencodedPath = APIUrl.pathAddFriend;

      var response = await http.post(
        Uri.http(authority, unencodedPath),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 401) {
        log('Token is expired', name: 'UserInfoRepository');
        return ResultReturn(
          httpStatusCode: response.statusCode,
          data: null,
        );
      } else if (response.statusCode == 400) {
        log('Add friend failed', name: 'UserInfoRepository');
        return ResultReturn(
          httpStatusCode: response.statusCode,
          data: null,
        );
      } else {
        log("Add friend successfully", name: 'UserInfoRepository');
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
      log('Token is null', name: 'UserInfoRepository');
      return ResultReturn(httpStatusCode: 401, data: null);
    } else {
      log('Add friend', name: 'UserInfoRepository');

      String jwt = jwtResponse.token;
      Map<String, String> headers = BaseHeaderHttp.headers;
      headers['Authorization'] = 'Bearer $jwt';

      String authority = APIUrl.baseUrl;
      String unencodedPath = APIUrl.pathGetStatusOfRequestFriend;

      var response = await http.post(
        Uri.http(authority, unencodedPath),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 401) {
        log('Token is expired', name: 'UserInfoRepository');
        return ResultReturn(
          httpStatusCode: response.statusCode,
          data: null,
        );
      } else if (response.statusCode == 400) {
        log('Get status of friend request failed', name: 'UserInfoRepository');
        return ResultReturn(
          httpStatusCode: response.statusCode,
          data: null,
        );
      } else {
        log("Get status of friend request successfully",
            name: 'UserInfoRepository');
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
      log('Token is null', name: 'UserInfoRepository');
      return ResultReturn(httpStatusCode: 401, data: null);
    } else {
      log('Unfriend', name: 'UserInfoRepository');

      String jwt = jwtResponse.token;
      Map<String, String> headers = BaseHeaderHttp.headers;
      headers['Authorization'] = 'Bearer $jwt';

      String authority = APIUrl.baseUrl;
      String unencodedPath = APIUrl.pathUnFriend;

      var response = await http.post(
        Uri.http(authority, unencodedPath),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 401) {
        log('Token is expired', name: 'UserInfoRepository');
        return ResultReturn(
          httpStatusCode: response.statusCode,
          data: null,
        );
      } else if (response.statusCode == 400) {
        log('Unfriend failed', name: 'UserInfoRepository');
        return ResultReturn(
          httpStatusCode: response.statusCode,
          data: null,
        );
      } else {
        log("Unfriend successfully", name: 'UserInfoRepository');
        return ResultReturn(
          httpStatusCode: 200,
          data: null,
        );
      }
    }
  }
}
