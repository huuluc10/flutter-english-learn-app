import 'package:flutter_englearn/features/auth/repository/auth_repository.dart';
import 'package:flutter_englearn/model/lesson_content.dart';
import 'package:flutter_englearn/model/response/lesson_response.dart';
import 'package:flutter_englearn/model/question_type.dart';
import 'package:flutter_englearn/model/response/response_model.dart';
import 'package:flutter_englearn/model/result_return.dart';
import 'package:flutter_englearn/utils/const/api_url.dart';
import 'package:flutter_englearn/utils/const/utils.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;

class LearnRepository {
  final AuthRepository authRepository;

  LearnRepository({required this.authRepository});

  Future<ResultReturn> getListLessonOfTopic(String topicId) async {
    // get jwt token from authRepository
    final jwtResponse = await authRepository.getJWTCurrent();

    if (jwtResponse == null) {
      log('Token is null', name: 'LearnRepository');
      return ResultReturn(httpStatusCode: 401, data: null);
    } else {
      log('Get list lesson of topic', name: 'LearnRepository');

      String jwt = jwtResponse.token;
      Map<String, String> headers = Map.from(httpHeaders);
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
        log('Token is expired', name: 'LearnRepository');
        return ResultReturn(httpStatusCode: 401, data: null);
      } else if (response.statusCode == 400) {
        log('Get list lesson of topic failed', name: 'LearnRepository');
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

  Future<ResultReturn> getLessonDetail(String url) async {
    // get jwt token from authRepository
    final jwtResponse = await authRepository.getJWTCurrent();

    if (jwtResponse == null) {
      log('Token is null', name: 'LearnRepository');
      return ResultReturn(httpStatusCode: 401, data: null);
    } else {
      log('Get lesson detail', name: 'LearnRepository');

      String jwt = jwtResponse.token;
      Map<String, String> headers = Map.from(httpHeaders);
      headers['Authorization'] = 'Bearer $jwt';

      String authority = APIUrl.baseUrl;
      String unencodedPath = APIUrl.pathGetFile;

      Uri uri = Uri.http(authority, unencodedPath, {'path': url});
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 401) {
        log('Token is expired', name: 'LearnRepository');
        return ResultReturn(httpStatusCode: 401, data: null);
      } else if (response.statusCode == 400) {
        log('Get lesson detail failed', name: 'LearnRepository');
        return ResultReturn(httpStatusCode: 400, data: null);
      } else {
        log("Get lesson detail successfully", name: 'LearnRepository');
        LessconContent lessonResponse = LessconContent.fromJson(response.body);
        return ResultReturn(httpStatusCode: 200, data: lessonResponse);
      }
    }
  }

  Future<ResultReturn> saveHistoryLesson(String body) async {
    // get jwt token from authRepository
    final jwtResponse = await authRepository.getJWTCurrent();

    if (jwtResponse == null) {
      log('Token is null', name: 'LearnRepository');
      return ResultReturn(httpStatusCode: 401, data: null);
    } else {
      log('Save history lesson', name: 'LearnRepository');

      String jwt = jwtResponse.token;
      Map<String, String> headers = Map.from(httpHeaders);
      headers['Authorization'] = 'Bearer $jwt';

      String authority = APIUrl.baseUrl;
      String unencodedPath = APIUrl.pathSaveHistoryLesson;

      Uri uri = Uri.http(authority, unencodedPath);
      final response = await http.post(
        uri,
        headers: headers,
        body: body,
      );
      if (response.statusCode == 401) {
        log('Token is expired', name: 'LearnRepository');
        return ResultReturn(httpStatusCode: 401, data: null);
      } else if (response.statusCode == 400) {
        log('Save history lesson failed', name: 'LearnRepository');
        return ResultReturn(httpStatusCode: 400, data: null);
      } else {
        log("Save history lesson successfully", name: 'LearnRepository');
        return ResultReturn(httpStatusCode: 200, data: null);
      }
    }
  }

  Future<ResultReturn> getListExerciseOfLessopn(int lessonId) async {
    // get jwt token from authRepository
    final jwtResponse = await authRepository.getJWTCurrent();

    if (jwtResponse == null) {
      log('Token is null', name: 'LearnRepository');
      return ResultReturn(httpStatusCode: 401, data: null);
    } else {
      log('Get list exercise of lesson', name: 'LearnRepository');

      String jwt = jwtResponse.token;
      Map<String, String> headers = Map.from(httpHeaders);
      headers['Authorization'] = 'Bearer $jwt';

      String authority = APIUrl.baseUrl;
      String unencodedPath =
          APIUrl.pathGetListExerciseQuestion + lessonId.toString();

      Uri uri = Uri.http(authority, unencodedPath);
      final response = await http.get(
        uri,
        headers: headers,
      );

      if (response.statusCode == 500) {
        log('Server error', name: 'LearnRepository');
        return ResultReturn(httpStatusCode: 500, data: null);
      }
      if (response.statusCode == 401) {
        log('Token is expired', name: 'LearnRepository');
        return ResultReturn(httpStatusCode: 401, data: null);
      } else if (response.statusCode == 400) {
        log('Get list exercise of lesson failed', name: 'LearnRepository');
        return ResultReturn(httpStatusCode: 400, data: null);
      } else {
        log("Get list exercise of lesson successfully",
            name: 'LearnRepository');
        ResponseModel responseModel = ResponseModel.fromJson(response.body);
        List<QuestionType> listExerciseResponse =
            (responseModel.data as List<dynamic>)
                .map((item) => QuestionType.fromMap(item))
                .toList();
        return ResultReturn(httpStatusCode: 200, data: listExerciseResponse);
      }
    }
  }
}
