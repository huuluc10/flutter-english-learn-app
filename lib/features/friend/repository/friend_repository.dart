import 'package:flutter_englearn/features/auth/repository/auth_repository.dart';
import 'package:flutter_englearn/model/response/response_model.dart';
import 'package:flutter_englearn/utils/const/api_url.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_englearn/utils/const/base_header_http.dart';

class FriendRepository {
  final AuthRepository authRepository;

  FriendRepository({required this.authRepository});

  Future<ResponseModel> getFriend() async {

    // get jwt token from authRepository
    final jwtResponse = await authRepository.getJWTCurrent();

     if (jwtResponse == null) {
      log('Token is null', name: 'UserInfoRepository');
      return ResponseModel(status: '401', message: 'Token is null', data: null);
    } else {
      log('Get list friend', name: 'UserInfoRepository');

       String jwt = jwtResponse.token;
      Map<String, String> headers = BaseHeaderHttp.headers;
      headers['Authorization'] = 'Bearer $jwt';

      String authority = APIUrl.baseUrl;
      String unencodedPath = APIUrl.pathGetFriendByUsername;

      var response = await http.post(
        Uri.http(authority, unencodedPath),
        headers: headers,
      );

      if (response.statusCode != 200) {
        log('Get list friend failed', name: 'UserInfoRepository');
        return ResponseModel(status: response.statusCode.toString(), message: 'Get list friend failed', data: response.body);
      }

      return ResponseModel(status: '200', message: 'Get list friend', data: null);
    }
    
  }
}
