import 'package:flutter_englearn/features/auth/repository/auth_repository.dart';
import 'package:flutter_englearn/model/response/history_learn_topic_response.dart';
import 'package:flutter_englearn/model/response/main_user_info_request.dart';
import 'package:flutter_englearn/model/response/response_model.dart';
import 'package:flutter_englearn/model/result_return.dart';
import 'package:flutter_englearn/common/utils/const/api_url.dart';
import 'package:flutter_englearn/common/utils/const/utils.dart';
import 'package:flutter_englearn/common/utils/helper/helper.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class HomepageRepository {
  final AuthRepository authRepository;

  HomepageRepository({required this.authRepository});

  Future<List<HistoryLearnTopicResponse>> fetchTopic() async {
    List<HistoryLearnTopicResponse> listHistoryLearnTopicResponse = [];
    // Get URL, header
    String? jwt;
    await authRepository.getJWTCurrent().then((value) => jwt = value?.token);
    if (jwt == null) {
      log("JWT is null", name: "HomepageRepository");
    }
    Map<String, String> headers = Map.from(httpHeaders);
    headers['Authorization'] = 'Bearer $jwt';

    String authority = APIUrl.baseUrl;
    String unencodedPath = APIUrl.pathAllTopic;

    // Call login API
    log("fetchTopic", name: "HomepageRepository");
    var response = await http.get(
      Uri.http(authority, unencodedPath),
      headers: headers,
    );

    if (response.statusCode == 401) {
      await authRepository.removeJWT();
    }

    if (response.statusCode == 200) {
      log("fetchTopic success", name: "HomepageRepository");
      ResponseModel responseModel = ResponseModel.fromJson(response.body);
      for (var item in responseModel.data as List<dynamic>) {
        listHistoryLearnTopicResponse
            .add(HistoryLearnTopicResponse.fromMap(item));
      }
    }
    return listHistoryLearnTopicResponse;
  }

  Future<ResultReturn> getLeaderboard() async {
    // Get URL, header
    String? jwt;
    await authRepository.getJWTCurrent().then((value) => jwt = value?.token);
    if (jwt == null) {
      log("JWT is null", name: "HomepageRepository");
    }
    Map<String, String> headers = Map.from(httpHeaders);
    headers['Authorization'] = 'Bearer $jwt';

    String authority = APIUrl.baseUrl;
    String unencodedPath = APIUrl.pathGetLeaderboard;

    // Call login API
    log("getLeaderboard", name: "HomepageRepository");
    var response = await http.get(
      Uri.http(authority, unencodedPath),
      headers: headers,
    );

    if (response.statusCode == 401) {
      await authRepository.removeJWT();
    }

    if (response.statusCode == 200) {
      log("Get Leaderboard success", name: "HomepageRepository");
      ResponseModel responseModel = ResponseModel.fromJson(response.body);

      List<MainUserInfoResponse> listMainUserInfoResponse =
          (responseModel.data as List<dynamic>)
              .map((item) => MainUserInfoResponse.fromMap(item))
              .toList();

      for (int i = 0; i < listMainUserInfoResponse.length; i++) {
        listMainUserInfoResponse[i].urlAvatar =
            transformLocalURLMediaToURL(listMainUserInfoResponse[i].urlAvatar);
      }
      return ResultReturn(
          httpStatusCode: response.statusCode, data: listMainUserInfoResponse);
    } else if (response.statusCode == 401) {
      return ResultReturn(httpStatusCode: response.statusCode, data: null);
    } else {
      return ResultReturn(httpStatusCode: response.statusCode, data: null);
    }
  }
}
