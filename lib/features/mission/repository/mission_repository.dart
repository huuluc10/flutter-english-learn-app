import 'package:flutter_englearn/features/auth/repository/auth_repository.dart';
import 'package:flutter_englearn/model/response/mission_response.dart';
import 'package:flutter_englearn/model/response/response_model.dart';
import 'package:flutter_englearn/model/result_return.dart';
import 'package:flutter_englearn/common/utils/const/api_url.dart';
import 'package:flutter_englearn/common/utils/const/utils.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;

class MissionRepository {
  final AuthRepository authRepository;

  MissionRepository({required this.authRepository});

  Future<ResultReturn> getMissionList() async {
    String? jwt;
    await authRepository.getJWTCurrent().then((value) => jwt = value?.token);
    if (jwt == null) {
      log("JWT is null", name: "HomepageRepository");
    }
    Map<String, String> headers = Map.from(httpHeaders);
    headers['Authorization'] = 'Bearer $jwt';

    String authority = APIUrl.baseUrl;
    String unencodedPath = APIUrl.pathGetListDailyMission;

    log("Get list daily mission", name: "MissionRepository");

    final response = await http.get(
      Uri.http(authority, unencodedPath),
      headers: headers,
    );

    if (response.statusCode == 200) {
      log("Get list daily mission success", name: "MissionRepository");
      ResponseModel responseModel = ResponseModel.fromJson(response.body);
      List<MissionResponse> listMission = (responseModel.data as List<dynamic>)
          .map((item) => MissionResponse.fromMap(item))
          .toList();

      return ResultReturn(httpStatusCode: 200, data: listMission);
    } else if (response.statusCode == 401) {
      await authRepository.removeJWT();
      log("Token is expired", name: "MissionRepository");
      return ResultReturn(httpStatusCode: 401, data: null);
    } else {
      log("Get list daily mission failed", name: "MissionRepository");
      return ResultReturn(httpStatusCode: 400, data: null);
    }
  }
}
