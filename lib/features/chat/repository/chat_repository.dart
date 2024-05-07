import 'package:flutter_englearn/features/auth/repository/auth_repository.dart';
import 'package:flutter_englearn/model/result_return.dart';
import 'package:flutter_englearn/common/utils/const/api_url.dart';
import 'package:flutter_englearn/common/utils/const/utils.dart';
import 'package:http/http.dart';

class ChatRepositopry {
  final AuthRepository authRepository;

  ChatRepositopry({required this.authRepository});

  Future<ResultReturn> getAllChatRoom() async {
    // Get jwt token
    final token = await authRepository.getJWTCurrent();

    if (token == null) {
      return ResultReturn(httpStatusCode: 401, data: "Token is null");
    }

    // Call api
    Uri url = Uri.parse(APIUrl.baseUrlSocketHttp + APIUrl.pathGetAllChatRoom);
    Map<String, String> headersHTTP = Map.from(httpHeaders);

    final Response response = await get(url, headers: headersHTTP);

    if (response.statusCode == 200) {
      return ResultReturn(httpStatusCode: 200, data: response.body);
    } else {
      return ResultReturn(httpStatusCode: response.statusCode, data: null);
    }
  }
}
