import 'package:flutter_englearn/model/response/jwt_response.dart';
import 'package:flutter_englearn/model/response/response_model.dart';
import 'package:flutter_englearn/utils/const/api_url.dart';
import 'package:flutter_englearn/utils/const/base_header_http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  Future<JwtResponse?> getJWTCurrent() async {
    // Init SharedPreferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();
    JwtResponse? jwtResponse;

    // Get JWT from SharedPreferences
    final String? jwt = prefs.getString('jwt');
    final String? type = prefs.getString('type-jwt');
    final String? username = prefs.getString('username-jwt');
    final List<String>? roles = prefs.getStringList('roles-jwt');

    jwtResponse = JwtResponse(
      token: jwt ?? '',
      type: type ?? '',
      username: username ?? '',
      roles: roles ?? [],
    );
    if (jwtResponse.isEmpty()) {
      // clear all jwt data
      await prefs.remove('jwt');
      await prefs.remove('type-jwt');
      await prefs.remove('username-jwt');
      await prefs.remove('roles-jwt');
      jwtResponse = null;
    }

    return jwtResponse;
  }

  Future<void> saveJWT(JwtResponse jwtResponse) async {
    // Init SharedPreferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save JWT to SharedPreferences
    await prefs.setString('jwt', jwtResponse.token);
    await prefs.setString('type-jwt', jwtResponse.type);
    await prefs.setString('username-jwt', jwtResponse.username);
    await prefs.setStringList('roles-jwt', jwtResponse.roles);
  }

  Future<void> removeJWT() async {
    // Init SharedPreferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Remove JWT from SharedPreferences
    await prefs.remove('jwt');
    await prefs.remove('type-jwt');
    await prefs.remove('username-jwt');
    await prefs.remove('roles-jwt');
  }

  Future<JwtResponse?> login(String body) async {
    // Get URL, header
    Map<String, String> headers = BaseHeaderHttp.headers;
    String authority = APIUrl.baseUrl;
    String unencodedPath = APIUrl.pathLogin;

    // Call login API
    var response = await http.post(
      Uri.http(authority, unencodedPath),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      ResponseModel responseModel = ResponseModel.fromJson(response.body);
      JwtResponse jwtResponse = JwtResponse.fromMap(responseModel.data);
      await saveJWT(jwtResponse);
      print(jwtResponse.toString());
      return jwtResponse;
    } else {
      return null;
    }
  }
}
