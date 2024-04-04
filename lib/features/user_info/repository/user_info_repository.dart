import 'package:flutter_englearn/features/auth/repository/auth_repository.dart';
import 'package:flutter_englearn/model/response/jwt_response.dart';
import 'package:flutter_englearn/model/response/response_model.dart';
import 'package:flutter_englearn/model/response/user_info_response.dart';
import 'package:flutter_englearn/model/result_return.dart';
import 'package:flutter_englearn/utils/const/api_url.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_englearn/utils/const/base_header_http.dart';
import 'package:intl/intl.dart';

class UserInfoRepository {
  final AuthRepository authRepository;

  UserInfoRepository({required this.authRepository});

  // Call api to change password
  // Get status code
  // * Important: If status code is 200, then change password successfully
  // If status code is 401, then token is expired
  // If status code is 400, then change password failed
  Future<int> changePassword(String body) async {
    // Get token and username
    JwtResponse? jwtResponse = await authRepository.getJWTCurrent();

    if (jwtResponse == null) {
      log('Token is null', name: 'UserInfoRepository');
      return 401;
    } else {
      log('Change password', name: 'UserInfoRepository');

      String jwt = jwtResponse.token;
      Map<String, String> headers = BaseHeaderHttp.headers;
      headers['Authorization'] = 'Bearer $jwt';

      String authority = APIUrl.baseUrl;
      String unencodedPath = APIUrl.pathChangePassword;

      var response = await http.post(
        Uri.http(authority, unencodedPath),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        log('Change password successfully', name: 'UserInfoRepository');
        return 200;
      } else if (response.statusCode == 401) {
        log('Token is expired', name: 'UserInfoRepository');
        return 401;
      } else {
        log('Change password failed', name: 'UserInfoRepository');
        return 400;
      }
    }
  }

  Future<String> getUsername() async {
    JwtResponse? jwtResponse = await authRepository.getJWTCurrent();
    if (jwtResponse == null) {
      log('Token is null', name: 'UserInfoRepository');
      return '';
    } else {
      return jwtResponse.username;
    }
  }

  Future<ResultReturn> getInfo() async {
    JwtResponse? jwtResponse = await authRepository.getJWTCurrent();
    if (jwtResponse == null) {
      log('Token is null', name: 'UserInfoRepository');
      return ResultReturn(httpStatusCode: 401, data: null);
    } else {
      log('Get user info', name: 'UserInfoRepository');

      String jwt = jwtResponse.token;
      Map<String, String> headers = BaseHeaderHttp.headers;
      headers['Authorization'] = 'Bearer $jwt';

      String authority = APIUrl.baseUrl;
      String unencodedPath = APIUrl.pathGetUserInfo;

      var response = await http.post(
        Uri.http(authority, unencodedPath),
        headers: headers,
      );

      if (response.statusCode == 200) {
        log('Get user info successfully', name: 'UserInfoRepository');
        ResponseModel responseModel = ResponseModel.fromJson(response.body);
        UserInfoResponse userInfoResponse = UserInfoResponse.fromMap(
            responseModel.data as Map<String, dynamic>);

        userInfoResponse.urlAvatar =
            _transformLocalURLAvatarToURL(userInfoResponse.urlAvatar);
        userInfoResponse.dateOfBirth =
            _convertUTCtoLocal(userInfoResponse.dateOfBirth);

        return ResultReturn<UserInfoResponse>(
            httpStatusCode: 200, data: userInfoResponse);
      } else if (response.statusCode == 401) {
        log('Token is expired', name: 'UserInfoRepository');
        return ResultReturn(httpStatusCode: 401, data: null);
      } else {
        log('Change password failed', name: 'UserInfoRepository');
        return ResultReturn(httpStatusCode: 400, data: null);
      }
    }
  }

  // *Important: Transform local url avatar to get full url
  String _transformLocalURLAvatarToURL(String localURL) {
    String authority = APIUrl.baseUrl;
    String linkAvatar =
        Uri.http(authority, APIUrl.pathGetFile, {"path": localURL}).toString();

    return linkAvatar;
  }

  DateTime _convertUTCtoLocal(DateTime dateTimeUTC) {
    DateTime dateTime = DateTime.parse(dateTimeUTC.toIso8601String()).toLocal();
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
    return DateTime.parse(formattedDate);
  }

  Future<int> updateInfo(String body) async {
    JwtResponse? jwtResponse = await authRepository.getJWTCurrent();
    if (jwtResponse == null) {
      log('Token is null', name: 'UserInfoRepository');
      return 401;
    } else {
      log('Update user info', name: 'UserInfoRepository');

      String jwt = jwtResponse.token;
      Map<String, String> headers = BaseHeaderHttp.headers;
      headers['Authorization'] = 'Bearer $jwt';

      String authority = APIUrl.baseUrl;
      String unencodedPath = APIUrl.pathUpdateUserInfo;

      var response = await http.post(
        Uri.http(authority, unencodedPath),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        log('Update user info successfully', name: 'UserInfoRepository');
        return 200;
      } else if (response.statusCode == 401) {
        log('Token is expired', name: 'UserInfoRepository');
        return 401;
      } else {
        log('Update user info failed', name: 'UserInfoRepository');
        return 400;
      }
    }
  }
}
