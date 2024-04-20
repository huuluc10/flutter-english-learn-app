import 'package:flutter_englearn/features/auth/repository/auth_repository.dart';
import 'package:flutter_englearn/model/answer.dart';
import 'package:flutter_englearn/model/response/question_response.dart';
import 'package:flutter_englearn/model/response/response_model.dart';
import 'package:flutter_englearn/model/result_return.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_englearn/utils/const/api_url.dart';
import 'package:flutter_englearn/utils/const/base_header_http.dart';

class ExerciseRepository {
  final AuthRepository authRepository;

  ExerciseRepository({required this.authRepository});

  Future<ResultReturn> getListMultipleChoiceQuestion(int lessonId) async {
    // get jwt token from authRepository
    final jwtResponse = await authRepository.getJWTCurrent();

    if (jwtResponse == null) {
      log('Token is null', name: 'ExerciseRepository');
      return ResultReturn(httpStatusCode: 401, data: null);
    } else {
      log('Get list multiple choice question by lesson id: $lessonId',
          name: 'ExerciseRepository');

      String jwt = jwtResponse.token;
      Map<String, String> headers = BaseHeaderHttp.headers;
      headers['Authorization'] = 'Bearer $jwt';

      String authority = APIUrl.baseUrl;
      String unencodedPath = APIUrl.pathGetMultipleChoiceQuestion;

      Map<String, String> body = {};
      body['lessonId'] = lessonId.toString();

      Uri uri = Uri.http(authority, unencodedPath);

      var request = http.MultipartRequest('GET', uri)
        ..headers.addAll(headers)
        ..fields.addAll(body);

      var response = await request.send();

      if (response.statusCode == 401) {
        log('Token is expired', name: 'ExerciseRepository');
        return ResultReturn(httpStatusCode: 401, data: null);
      } else if (response.statusCode == 400) {
        log('Get list multiple choice question failed',
            name: 'ExerciseRepository');
        return ResultReturn(httpStatusCode: 400, data: null);
      } else {
        log("Get list multiple choice question successfully",
            name: 'ExerciseRepository');

        ResponseModel responseModel =
            ResponseModel.fromJson(await response.stream.bytesToString());
        List<QuestionResponse> list = (responseModel.data as List<dynamic>)
            .map((item) => QuestionResponse.fromMap(item))
            .toList();
        return ResultReturn(httpStatusCode: 200, data: list);
      }
    }
  }

  Future<ResultReturn> getAnswer(String url) async {
    // get jwt token from authRepository
    final jwtResponse = await authRepository.getJWTCurrent();

    if (jwtResponse == null) {
      log('Token is null', name: 'ExerciseRepository');
      return ResultReturn(httpStatusCode: 401, data: null);
    } else {
      log('Get question detail', name: 'ExerciseRepository');

      String jwt = jwtResponse.token;
      Map<String, String> headers = BaseHeaderHttp.headers;
      headers['Authorization'] = 'Bearer $jwt';

      String authority = APIUrl.baseUrl;
      String unencodedPath = APIUrl.pathGetFile;

      Uri uri = Uri.http(authority, unencodedPath, {'path': url});
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 401) {
        log('Token is expired', name: 'UserInfoRepository');
        return ResultReturn(httpStatusCode: 401, data: null);
      } else if (response.statusCode == 400) {
        log('Get question detail failed', name: 'UserInfoRepository');
        return ResultReturn(httpStatusCode: 400, data: null);
      } else {
        log("Get question detail successfully", name: 'UserInfoRepository');
        Answer lessonResponse = Answer.fromJson(response.body);
        return ResultReturn(httpStatusCode: 200, data: lessonResponse);
      }
    }
  }
}
