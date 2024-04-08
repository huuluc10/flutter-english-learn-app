import 'dart:io';

import 'package:flutter_englearn/features/auth/repository/auth_repository.dart';
import 'package:flutter_englearn/model/request/add_email_request.dart';
import 'package:flutter_englearn/model/response/jwt_response.dart';
import 'package:flutter_englearn/model/response/response_model.dart';
import 'package:flutter_englearn/model/response/user_info_response.dart';
import 'package:flutter_englearn/model/result_return.dart';
import 'package:flutter_englearn/utils/const/api_url.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_englearn/utils/const/base_header_http.dart';
import 'package:intl/intl.dart';
import 'package:http_parser/http_parser.dart';

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

  Future<ResultReturn> getInfo(String username) async {
    // Get JWY token of current user
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
        Uri.http(authority, unencodedPath, {"username": username}),
        headers: headers,
      );

      if (response.statusCode == 200) {
        log('Get user info successfully', name: 'UserInfoRepository');
        ResponseModel responseModel = ResponseModel.fromJson(response.body);
        UserInfoResponse userInfoResponse = UserInfoResponse.fromMap(
            responseModel.data! as Map<String, dynamic>);

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

  Future<int> addEmail(String email) async {
    JwtResponse? jwtResponse = await authRepository.getJWTCurrent();
    if (jwtResponse == null) {
      log('Token is null', name: 'UserInfoRepository');
      return 401;
    } else {
      log('Add email', name: 'UserInfoRepository');

      String jwt = jwtResponse.token;
      Map<String, String> headers = BaseHeaderHttp.headers;
      headers['Authorization'] = 'Bearer $jwt';

      String authority = APIUrl.baseUrl;
      String unencodedPath = APIUrl.pathAddEmail;

      String username = jwtResponse.username;

      AddEmailRequest request = AddEmailRequest(
        email: email,
        username: username,
      );

      var response = await http.post(
        Uri.http(authority, unencodedPath),
        headers: headers,
        body: request.toJson(),
      );

      if (response.statusCode == 200) {
        log('Send email successfully', name: 'UserInfoRepository');
        return 200;
      } else if (response.statusCode == 401) {
        log('Token is expired', name: 'UserInfoRepository');
        return 401;
      } else if (response.statusCode == 400) {
        log('Send email failed', name: 'UserInfoRepository');
        return 400;
      } else {
        log("Email is already taken", name: "UserInfoRepository");
        return 409;
      }
    }
  }

  Future<ResultReturn> countHistoryLearnedLesson() async {
    JwtResponse? jwtResponse = await authRepository.getJWTCurrent();
    if (jwtResponse == null) {
      log('Token is null', name: 'UserInfoRepository');
      return ResultReturn(httpStatusCode: 401, data: null);
    } else {
      log('Count history learned lesson', name: 'UserInfoRepository');

      String jwt = jwtResponse.token;
      Map<String, String> headers = BaseHeaderHttp.headers;
      headers['Authorization'] = 'Bearer $jwt';

      String authority = APIUrl.baseUrl;
      String unencodedPath =
          APIUrl.pathCountHistoryLearnedLesson + jwtResponse.username;

      var response = await http.get(
        Uri.http(authority, unencodedPath),
        headers: headers,
      );

      if (response.statusCode == 200) {
        log('Count history learned lesson successfully',
            name: 'UserInfoRepository');
        ResponseModel responseModel = ResponseModel.fromJson(response.body);
        int count = responseModel.data as int;

        return ResultReturn<int>(httpStatusCode: 200, data: count);
      } else if (response.statusCode == 401) {
        log('Token is expired', name: 'UserInfoRepository');
        return ResultReturn(httpStatusCode: 401, data: null);
      } else {
        log('Count history learned lesson failed', name: 'UserInfoRepository');
        return ResultReturn(httpStatusCode: 400, data: null);
      }
    }
  }

  Future<ResultReturn> getLessonExerciseDone() async {
    JwtResponse? jwtResponse = await authRepository.getJWTCurrent();
    if (jwtResponse == null) {
      log('Token is null', name: 'UserInfoRepository');
      return ResultReturn(httpStatusCode: 401, data: null);
    } else {
      log('Get lesson exercise done', name: 'UserInfoRepository');

      String jwt = jwtResponse.token;
      Map<String, String> headers = BaseHeaderHttp.headers;
      headers['Authorization'] = 'Bearer $jwt';

      String authority = APIUrl.baseUrl;
      String unencodedPath = APIUrl.pathGetExerciseLessonHistory;

      var response = await http.get(
        Uri.http(authority, unencodedPath),
        headers: headers,
      );

      if (response.statusCode == 200) {
        log('Get lesson exercise done successfully',
            name: 'UserInfoRepository');
        ResponseModel responseModel = ResponseModel.fromJson(response.body);
        int count = responseModel.data as int;

        return ResultReturn<int>(httpStatusCode: 200, data: count);
      } else if (response.statusCode == 401) {
        log('Token is expired', name: 'UserInfoRepository');
        return ResultReturn(httpStatusCode: 401, data: null);
      } else {
        log('Get lesson exercise is done failed', name: 'UserInfoRepository');
        return ResultReturn(httpStatusCode: 400, data: null);
      }
    }
  }

  Future<ResultReturn> getExamExerciseDone() async {
    JwtResponse? jwtResponse = await authRepository.getJWTCurrent();
    if (jwtResponse == null) {
      log('Token is null', name: 'UserInfoRepository');
      return ResultReturn(httpStatusCode: 401, data: null);
    } else {
      log('Get lesson exercise done', name: 'UserInfoRepository');

      String jwt = jwtResponse.token;
      Map<String, String> headers = BaseHeaderHttp.headers;
      headers['Authorization'] = 'Bearer $jwt';

      String authority = APIUrl.baseUrl;
      String unencodedPath = APIUrl.pathGetExerciseExamHistory;

      var response = await http.get(
        Uri.http(authority, unencodedPath),
        headers: headers,
      );

      if (response.statusCode == 200) {
        log('Get lesson exercise done successfully',
            name: 'UserInfoRepository');
        ResponseModel responseModel = ResponseModel.fromJson(response.body);
        int count = responseModel.data as int;

        return ResultReturn<int>(httpStatusCode: 200, data: count);
      } else if (response.statusCode == 401) {
        log('Token is expired', name: 'UserInfoRepository');
        return ResultReturn(httpStatusCode: 401, data: null);
      } else {
        log('Get lesson exercise is done failed', name: 'UserInfoRepository');
        return ResultReturn(httpStatusCode: 400, data: null);
      }
    }
  }

  Future<ResultReturn> changeAvatar(String imagePath) async {
    JwtResponse? jwtResponse = await authRepository.getJWTCurrent();
    if (jwtResponse == null) {
      log('Token is null', name: 'UserInfoRepository');
      return ResultReturn(httpStatusCode: 401, data: null);
    } else {
      log('Change avatar', name: 'UserInfoRepository');

      String jwt = jwtResponse.token;
      Map<String, String> headers = BaseHeaderHttp.headers;
      headers['Authorization'] = 'Bearer $jwt';

      String url = "http://${APIUrl.baseUrl}/${APIUrl.pathUpdateAvatar}";
      final File file = File(imagePath);

      // Create a multipart request
      var multipartFile = await http.MultipartFile.fromPath(
        'file',
        file.path,
        contentType: MediaType('image', 'png'),
      );

      // Create a multipart request
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(multipartFile);

      request.headers.addAll(headers);

      var response = await request.send();

      if (response.statusCode == 200) {
        log('Upload successfully', name: 'UserInfoRepository');
        return ResultReturn(httpStatusCode: 200, data: null);
      } else {
        log('Upload failed', name: 'UserInfoRepository');
        return ResultReturn(httpStatusCode: 400, data: null);
      }
    }
  }
}
