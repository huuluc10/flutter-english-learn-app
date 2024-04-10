import 'package:flutter_englearn/features/auth/repository/auth_repository.dart';
import 'package:flutter_englearn/model/response/lesson_response.dart';
import 'package:flutter_englearn/model/response/response_model.dart';
import 'package:flutter_englearn/model/result_return.dart';
import 'package:flutter_englearn/utils/const/api_url.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_englearn/utils/const/base_header_http.dart';

class LearnRepository {
  final AuthRepository authRepository;

  LearnRepository({required this.authRepository});

  Future<ResultReturn> getListLessonOfTopic(String topicId) async {
    // get jwt token from authRepository
    final jwtResponse = await authRepository.getJWTCurrent();

    if (jwtResponse == null) {
      log('Token is null', name: 'UserInfoRepository');
      return ResultReturn(httpStatusCode: 401, data: null);
    } else {
      log('Get list lesson of topic', name: 'UserInfoRepository');

      String jwt = jwtResponse.token;
      Map<String, String> headers = BaseHeaderHttp.headers;
      headers['Authorization'] = 'Bearer $jwt';

      String authority = APIUrl.baseUrl;
      String unencodedPath = APIUrl.pathGetListLessonOfTopic;

      Map<String, String> body = {};
      body['topicId'] = topicId;

      Uri uri = Uri.http(authority, unencodedPath);

      var request = http.MultipartRequest('GET', uri)
        ..headers.addAll(headers)
        ..fields.addAll(body);

      var response = await request.send();

      if (response.statusCode == 401) {
        log('Token is expired', name: 'UserInfoRepository');
        return ResultReturn(httpStatusCode: 401, data: null);
      } else if (response.statusCode == 400) {
        log('Get list lesson of topic failed', name: 'UserInfoRepository');
        return ResultReturn(httpStatusCode: 400, data: null);
      } else {
        log("Get list lesson of topic successfully",
            name: 'UserInfoRepository');

        ResponseModel responseModel =
            ResponseModel.fromJson(await response.stream.bytesToString());
        List<LessonResponse> listLessonResponse =
            (responseModel.data as List<dynamic>)
                .map((item) => LessonResponse.fromMap(item))
                .toList();
        return ResultReturn(httpStatusCode: 200, data: listLessonResponse);
      }
    }
  }
}
