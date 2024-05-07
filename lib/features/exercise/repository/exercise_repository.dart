import 'package:flutter_englearn/features/auth/repository/auth_repository.dart';
import 'package:flutter_englearn/model/answer.dart';
import 'package:flutter_englearn/model/response/exam_response.dart';
import 'package:flutter_englearn/model/response/question_response.dart';
import 'package:flutter_englearn/model/response/response_model.dart';
import 'package:flutter_englearn/model/result_return.dart';
import 'package:flutter_englearn/common/utils/const/utils.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_englearn/common/utils/const/api_url.dart';

class ExerciseRepository {
  final AuthRepository authRepository;

  ExerciseRepository({required this.authRepository});

  Future<ResultReturn> getListMultipleChoiceQuestion(int lessonId) async {
    // get jwt token from authRepository
    final jwtResponse = await authRepository.getJWTCurrent();

    if (jwtResponse == null) {
      log('Token is null', name: 'ExerciseRepository', time: DateTime.now());
      return ResultReturn(httpStatusCode: 401, data: null);
    } else {
      log('Get list multiple choice question by lesson id: $lessonId',
          name: 'ExerciseRepository', time: DateTime.now());

      String jwt = jwtResponse.token;
      Map<String, String> headers = Map.from(httpHeaders);
      headers['Authorization'] = 'Bearer $jwt';

      String authority = APIUrl.baseUrl;
      String unencodedPath = APIUrl.pathGetMultipleChoiceQuestion;

      Map<String, String> body = {};
      body['lessonId'] = lessonId.toString();

      Uri uri = Uri.http(authority, unencodedPath);

      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll(headers)
        ..fields.addAll(body);

      var response = await request.send();

      if (response.statusCode == 401) {
        log('Token is expired',
            name: 'ExerciseRepository', time: DateTime.now());
        await authRepository.removeJWT();
        return ResultReturn(httpStatusCode: 401, data: null);
      } else if (response.statusCode == 400) {
        log('Get list multiple choice question failed',
            name: 'ExerciseRepository', time: DateTime.now());
        return ResultReturn(httpStatusCode: 400, data: null);
      } else {
        log("Get list multiple choice question successfully",
            name: 'ExerciseRepository', time: DateTime.now());

        ResponseModel responseModel =
            ResponseModel.fromJson(await response.stream.bytesToString());
        List<QuestionResponse> list = (responseModel.data as List<dynamic>)
            .map((item) => QuestionResponse.fromMap(item))
            .toList();
        return ResultReturn(httpStatusCode: 200, data: list);
      }
    }
  }

  Future<ResultReturn> getListFillQuestion(int lessonId) async {
    // get jwt token from authRepository
    final jwtResponse = await authRepository.getJWTCurrent();

    if (jwtResponse == null) {
      log('Token is null', name: 'ExerciseRepository', time: DateTime.now());
      return ResultReturn(httpStatusCode: 401, data: null);
    } else {
      log('Get list fill in the blank question by lesson id: $lessonId',
          name: 'ExerciseRepository', time: DateTime.now());

      String jwt = jwtResponse.token;
      Map<String, String> headers = Map.from(httpHeaders);
      headers['Authorization'] = 'Bearer $jwt';

      String authority = APIUrl.baseUrl;
      String unencodedPath = APIUrl.pathGetFillInBlankQuestion;

      Map<String, String> body = {};
      body['lessonId'] = lessonId.toString();

      Uri uri = Uri.http(authority, unencodedPath);

      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll(headers)
        ..fields.addAll(body);

      var response = await request.send();

      if (response.statusCode == 401) {
        log('Token is expired',
            name: 'ExerciseRepository', time: DateTime.now());
        await authRepository.removeJWT();
        return ResultReturn(httpStatusCode: 401, data: null);
      } else if (response.statusCode == 400) {
        log('Get list fill question failed',
            name: 'ExerciseRepository', time: DateTime.now());
        return ResultReturn(httpStatusCode: 400, data: null);
      } else {
        log("Get list fill question successfully",
            name: 'ExerciseRepository', time: DateTime.now());

        ResponseModel responseModel =
            ResponseModel.fromJson(await response.stream.bytesToString());
        List<QuestionResponse> list = (responseModel.data as List<dynamic>)
            .map((item) => QuestionResponse.fromMap(item))
            .toList();
        return ResultReturn(httpStatusCode: 200, data: list);
      }
    }
  }

  Future<ResultReturn> getListSentenceUnscrambleQuestion(int lessonId) async {
    // get jwt token from authRepository
    final jwtResponse = await authRepository.getJWTCurrent();

    if (jwtResponse == null) {
      log('Token is null', name: 'ExerciseRepository', time: DateTime.now());
      return ResultReturn(httpStatusCode: 401, data: null);
    } else {
      log('Get list sentence uncramble question by lesson id: $lessonId',
          name: 'ExerciseRepository', time: DateTime.now());

      String jwt = jwtResponse.token;
      Map<String, String> headers = Map.from(httpHeaders);
      headers['Authorization'] = 'Bearer $jwt';

      String authority = APIUrl.baseUrl;
      String unencodedPath = APIUrl.pathGetListSentenceUnscrambleQuestion;

      Map<String, String> body = {};
      body['lessonId'] = lessonId.toString();

      Uri uri = Uri.http(authority, unencodedPath);

      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll(headers)
        ..fields.addAll(body);

      var response = await request.send();

      if (response.statusCode == 401) {
        await authRepository.removeJWT();
        log('Token is expired',
            name: 'ExerciseRepository', time: DateTime.now());
        return ResultReturn(httpStatusCode: 401, data: null);
      } else if (response.statusCode == 400) {
        log('Get list sentence uncramble question failed',
            name: 'ExerciseRepository', time: DateTime.now());
        return ResultReturn(httpStatusCode: 400, data: null);
      } else {
        log("Get list sentence uncramble question successfully",
            name: 'ExerciseRepository', time: DateTime.now());

        ResponseModel responseModel =
            ResponseModel.fromJson(await response.stream.bytesToString());
        List<QuestionResponse> list = (responseModel.data as List<dynamic>)
            .map((item) => QuestionResponse.fromMap(item))
            .toList();
        return ResultReturn(httpStatusCode: 200, data: list);
      }
    }
  }

  Future<ResultReturn> getListSpeakingQuestion(int lessonId) async {
    // get jwt token from authRepository
    final jwtResponse = await authRepository.getJWTCurrent();

    if (jwtResponse == null) {
      log('Token is null', name: 'ExerciseRepository', time: DateTime.now());
      return ResultReturn(httpStatusCode: 401, data: null);
    } else {
      log('Get list speaking question by lesson id: $lessonId',
          name: 'ExerciseRepository', time: DateTime.now());

      String jwt = jwtResponse.token;
      Map<String, String> headers = Map.from(httpHeaders);
      headers['Authorization'] = 'Bearer $jwt';

      String authority = APIUrl.baseUrl;
      String unencodedPath = APIUrl.pathGetListSpeakingQuestion;

      Map<String, String> body = {};
      body['lessonId'] = lessonId.toString();

      Uri uri = Uri.http(authority, unencodedPath);

      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll(headers)
        ..fields.addAll(body);

      var response = await request.send();

      if (response.statusCode == 401) {
        await authRepository.removeJWT();
        log('Token is expired',
            name: 'ExerciseRepository', time: DateTime.now());
        return ResultReturn(httpStatusCode: 401, data: null);
      } else if (response.statusCode == 400) {
        log('Get list sentence uncramble question failed',
            name: 'ExerciseRepository', time: DateTime.now());
        return ResultReturn(httpStatusCode: 400, data: null);
      } else {
        log("Get list sentence uncramble question successfully",
            name: 'ExerciseRepository', time: DateTime.now());

        ResponseModel responseModel =
            ResponseModel.fromJson(await response.stream.bytesToString());
        List<QuestionResponse> list = (responseModel.data as List<dynamic>)
            .map((item) => QuestionResponse.fromMap(item))
            .toList();
        return ResultReturn(httpStatusCode: 200, data: list);
      }
    }
  }

  Future<ResultReturn> getListSentenceTransformationQuestion(
      int lessonId) async {
    // get jwt token from authRepository
    final jwtResponse = await authRepository.getJWTCurrent();

    if (jwtResponse == null) {
      log('Token is null', name: 'ExerciseRepository', time: DateTime.now());
      return ResultReturn(httpStatusCode: 401, data: null);
    } else {
      log('Get list sentence transformation question by lesson id: $lessonId',
          name: 'ExerciseRepository', time: DateTime.now());

      String jwt = jwtResponse.token;
      Map<String, String> headers = Map.from(httpHeaders);
      headers['Authorization'] = 'Bearer $jwt';

      String authority = APIUrl.baseUrl;
      String unencodedPath = APIUrl.pathGetListSentenceTransformationQuestion;

      Map<String, String> body = {};
      body['lessonId'] = lessonId.toString();

      Uri uri = Uri.http(authority, unencodedPath);

      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll(headers)
        ..fields.addAll(body);

      var response = await request.send();

      if (response.statusCode == 401) {
        await authRepository.removeJWT();
        log('Token is expired',
            name: 'ExerciseRepository', time: DateTime.now());
        return ResultReturn(httpStatusCode: 401, data: null);
      } else if (response.statusCode == 400) {
        log('Get list sentence transformation question failed',
            name: 'ExerciseRepository', time: DateTime.now());
        return ResultReturn(httpStatusCode: 400, data: null);
      } else {
        log("Get list sentence transformation question successfully",
            name: 'ExerciseRepository', time: DateTime.now());

        ResponseModel responseModel =
            ResponseModel.fromJson(await response.stream.bytesToString());
        List<QuestionResponse> list = (responseModel.data as List<dynamic>)
            .map((item) => QuestionResponse.fromMap(item))
            .toList();
        return ResultReturn(httpStatusCode: 200, data: list);
      }
    }
  }

  Future<ResultReturn> getListListeningQuestion(int lessonId) async {
    // get jwt token from authRepository
    final jwtResponse = await authRepository.getJWTCurrent();

    if (jwtResponse == null) {
      log('Token is null', name: 'ExerciseRepository', time: DateTime.now());
      return ResultReturn(httpStatusCode: 401, data: null);
    } else {
      log('Get list sentence transformation question by lesson id: $lessonId',
          name: 'ExerciseRepository', time: DateTime.now());

      String jwt = jwtResponse.token;
      Map<String, String> headers = Map.from(httpHeaders);
      headers['Authorization'] = 'Bearer $jwt';

      String authority = APIUrl.baseUrl;
      String unencodedPath = APIUrl.pathGetListListeningQuestion;

      Map<String, String> body = {};
      body['lessonId'] = lessonId.toString();

      Uri uri = Uri.http(authority, unencodedPath);

      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll(headers)
        ..fields.addAll(body);

      var response = await request.send();

      if (response.statusCode == 401) {
        await authRepository.removeJWT();
        log('Token is expired',
            name: 'ExerciseRepository', time: DateTime.now());
        return ResultReturn(httpStatusCode: 401, data: null);
      } else if (response.statusCode == 400) {
        log('Get list sentence transformation question failed',
            name: 'ExerciseRepository', time: DateTime.now());
        return ResultReturn(httpStatusCode: 400, data: null);
      } else {
        log("Get list sentence transformation question successfully",
            name: 'ExerciseRepository', time: DateTime.now());

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
      log('Token is null', name: 'ExerciseRepository', time: DateTime.now());
      return ResultReturn(httpStatusCode: 401, data: null);
    } else {
      log('Get question detail',
          name: 'ExerciseRepository', time: DateTime.now());

      String jwt = jwtResponse.token;
      Map<String, String> headers = Map.from(httpHeaders);
      headers['Authorization'] = 'Bearer $jwt';

      String authority = APIUrl.baseUrl;
      String unencodedPath = APIUrl.pathGetFile;

      Uri uri = Uri.http(authority, unencodedPath, {'path': url});
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 401) {
        log('Token is expired',
            name: 'ExerciseRepository', time: DateTime.now());
        await authRepository.removeJWT();
        return ResultReturn(httpStatusCode: 401, data: null);
      } else if (response.statusCode == 400) {
        log('Get question detail failed',
            name: 'ExerciseRepository', time: DateTime.now());
        return ResultReturn(httpStatusCode: 400, data: null);
      } else {
        log("Get question detail successfully",
            name: 'ExerciseRepository', time: DateTime.now());
        Answer lessonResponse = Answer.fromJson(response.body);
        return ResultReturn(httpStatusCode: 200, data: lessonResponse);
      }
    }
  }

  Future<ResultReturn> getListExam(int topicId) async {
    // get jwt token from authRepository
    final jwtResponse = await authRepository.getJWTCurrent();

    if (jwtResponse == null) {
      log('Token is null', name: 'ExerciseRepository', time: DateTime.now());
      return ResultReturn(httpStatusCode: 401, data: null);
    } else {
      log('Get list exam', name: 'ExerciseRepository', time: DateTime.now());

      String jwt = jwtResponse.token;
      Map<String, String> headers = Map.from(httpHeaders);
      headers['Authorization'] = 'Bearer $jwt';

      String authority = APIUrl.baseUrl;
      String unencodedPath = APIUrl.pathGetExamByTopic;

      Uri uri =
          Uri.http(authority, unencodedPath, {'topicId': topicId.toString()});

      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 401) {
        log('Token is expired',
            name: 'ExerciseRepository', time: DateTime.now());
        await authRepository.removeJWT();
        return ResultReturn(httpStatusCode: 401, data: null);
      } else if (response.statusCode == 400) {
        log('Get list exam failed',
            name: 'ExerciseRepository', time: DateTime.now());
        return ResultReturn(httpStatusCode: 400, data: null);
      } else {
        log("Get list exam successfully",
            name: 'ExerciseRepository', time: DateTime.now());

        ResponseModel responseModel = ResponseModel.fromJson(response.body);
        List<ExamResponse> list = (responseModel.data as List<dynamic>)
            .map((item) => ExamResponse.fromMap(item))
            .toList();
        return ResultReturn(httpStatusCode: 401, data: list);
      }
    }
  }

  Future<ResultReturn> getExamDetail(int examId) async {
    // get jwt token from authRepository
    final jwtResponse = await authRepository.getJWTCurrent();

    if (jwtResponse == null) {
      log('Token is null', name: 'ExerciseRepository', time: DateTime.now());
      return ResultReturn(httpStatusCode: 401, data: null);
    } else {
      log('Get exam detail', name: 'ExerciseRepository', time: DateTime.now());

      String jwt = jwtResponse.token;
      Map<String, String> headers = Map.from(httpHeaders);
      headers['Authorization'] = 'Bearer $jwt';

      String authority = APIUrl.baseUrl;
      String unencodedPath = APIUrl.pathGetListQuestionExamByTopic;

      Uri uri =
          Uri.http(authority, unencodedPath, {'examId': examId.toString()});

      final response = await http.post(uri, headers: headers);

      if (response.statusCode == 401) {
        log('Token is expired',
            name: 'ExerciseRepository', time: DateTime.now());
        await authRepository.removeJWT();
        return ResultReturn(httpStatusCode: 401, data: null);
      } else if (response.statusCode == 400) {
        log('Get exam detail failed',
            name: 'ExerciseRepository', time: DateTime.now());
        return ResultReturn(httpStatusCode: 400, data: null);
      } else {
        log("Get exam detail successfully",
            name: 'ExerciseRepository', time: DateTime.now());

        ResponseModel responseModel = ResponseModel.fromJson(response.body);
        List<QuestionResponse> list = (responseModel.data as List<dynamic>)
            .map((item) => QuestionResponse.fromMap(item))
            .toList();
        return ResultReturn(httpStatusCode: 200, data: list);
      }
    }
  }

  Future<ResultReturn> getNameOfQuestionType(int typeId) async {
    // get jwt token from authRepository
    final jwtResponse = await authRepository.getJWTCurrent();

    if (jwtResponse == null) {
      log('Token is null', name: 'ExerciseRepository', time: DateTime.now());
      return ResultReturn(httpStatusCode: 401, data: null);
    } else {
      log('Get name of question type',
          name: 'ExerciseRepository', time: DateTime.now());

      String jwt = jwtResponse.token;
      Map<String, String> headers = Map.from(httpHeaders);
      headers['Authorization'] = 'Bearer $jwt';

      String authority = APIUrl.baseUrl;
      String unencodedPath = APIUrl.pathGetNameOfQuestionType;

      Uri uri = Uri.http(
          authority, unencodedPath, {'questionTypeId': typeId.toString()});

      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 401) {
        log('Token is expired',
            name: 'ExerciseRepository', time: DateTime.now());
        await authRepository.removeJWT();
        return ResultReturn(httpStatusCode: 401, data: null);
      } else if (response.statusCode == 400) {
        log('Get name of question type failed',
            name: 'ExerciseRepository', time: DateTime.now());
        return ResultReturn(httpStatusCode: 400, data: null);
      } else {
        log("Get name of question type successfully",
            name: 'ExerciseRepository', time: DateTime.now());

        ResponseModel responseModel = ResponseModel.fromJson(response.body);
        String name = responseModel.data as String;
        return ResultReturn(httpStatusCode: 200, data: name);
      }
    }
  }

  Future<ResultReturn> saveAnswerQuestion(String body) async {
    // get jwt token from authRepository
    final jwtResponse = await authRepository.getJWTCurrent();

    if (jwtResponse == null) {
      log('Token is null', name: 'ExerciseRepository', time: DateTime.now());
      return ResultReturn(httpStatusCode: 401, data: null);
    } else {
      log('Save answer question', name: 'ExerciseRepository');

      String jwt = jwtResponse.token;
      Map<String, String> headers = Map.from(httpHeaders);
      headers['Authorization'] = 'Bearer $jwt';

      String authority = APIUrl.baseUrl;
      String unencodedPath = APIUrl.pathSaveAnswerQuestion;

      Uri url = Uri.http(authority, unencodedPath);

      // Call api to check
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 401) {
        log('Token is expired',
            name: 'ExerciseRepository', time: DateTime.now());
        await authRepository.removeJWT();
        return ResultReturn(httpStatusCode: 401, data: null);
      } else if (response.statusCode == 200) {
        log("Save answer question successfully", name: "ExerciseRepository");

        return ResultReturn(httpStatusCode: 200, data: "Ok");
      } else {
        log("Save answer question failed", name: "ExerciseRepository");
        return ResultReturn(httpStatusCode: 400, data: null);
      }
    }
  }
}
