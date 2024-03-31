import 'package:flutter_englearn/features/auth/repository/auth_repository.dart';
import 'package:flutter_englearn/model/response/history_learn_topic_response.dart';
import 'package:flutter_englearn/model/response/response_model.dart';
import 'package:flutter_englearn/utils/const/api_url.dart';
import 'package:flutter_englearn/utils/const/base_header_http.dart';
import 'package:http/http.dart' as http;

class HomepageRepository {
  final AuthRepository authRepository;

  HomepageRepository({required this.authRepository});

  Future<List<HistoryLearnTopicResponse>> fetchTopic() async {
    List<HistoryLearnTopicResponse> listHistoryLearnTopicResponse = [];
    // Get URL, header
    String? jwt;
    await authRepository.getJWTCurrent().then((value) => jwt = value?.token);
    Map<String, String> headers = BaseHeaderHttp.headers;
    headers['Authorization'] = 'Bearer $jwt';

    String authority = APIUrl.baseUrl;
    String unencodedPath = APIUrl.pathAllTopic;

    // Call login API
    var response = await http.get(
      Uri.http(authority, unencodedPath),
      headers: headers,
    );

    if (response.statusCode == 200) {
      ResponseModel responseModel = ResponseModel.fromJson(response.body);
      for (var item in responseModel.data as List<dynamic>) {
        listHistoryLearnTopicResponse
            .add(HistoryLearnTopicResponse.fromMap(item));
      }
    }
    return listHistoryLearnTopicResponse;
  }
}
