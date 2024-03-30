import 'dart:convert';

import 'package:flutter_englearn/features/auth/repository/auth_repository.dart';
import 'package:flutter_englearn/model/response/history_learn_topic_response.dart';
import 'package:flutter_englearn/model/response/response_model.dart';
import 'package:flutter_englearn/utils/const/api_url.dart';
import 'package:flutter_englearn/utils/const/base_header_http.dart';
import 'package:http/http.dart' as http;
class HomepageRepository {

  final AuthRepository authRepository;

  HomepageRepository({required this.authRepository});

  Future<List<HistoryLearnTopicResponse>?> fetchTopic(String body) async {
    // Get URL, header
    Map<String, String> headers = BaseHeaderHttp.headers;
    String? jwt;

    await authRepository.getJWTCurrent().then((value) => jwt = value?.token);
    headers['Authorization'] = 'Bearer ${await authRepository.getJWTCurrent()}';
    String authority = APIUrl.baseUrl;
    String unencodedPath = APIUrl.pathSummaryOfTopic;

    // Call login API
    var response = await http.post(
      Uri.http(authority, unencodedPath),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      ResponseModel responseModel = ResponseModel.fromJson(response.body);
      // JwtResponse jwtResponse = JwtResponse.fromMap(responseModel.data);
      // convert response to list history learn topic
      // List<HistoryLearnTopicResponse> listHistoryLearnTopicResponse = ;
      

    } else {
      return null;
    }
  }
}