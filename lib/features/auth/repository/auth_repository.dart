import 'dart:convert';

import 'dart:developer';
import 'package:flutter_englearn/model/response/jwt_response.dart';
import 'package:flutter_englearn/model/response/response_model.dart';
import 'package:flutter_englearn/utils/const/api_url.dart';
import 'package:flutter_englearn/utils/const/base_header_http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  Future<JwtResponse?> getJWTCurrent() async {
    log("getJWTCurrent", name: "AuthRepository");
    // Init SharedPreferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();
    JwtResponse? jwtResponse;

    // Get JWT from SharedPreferences
    final String? jwt = prefs.getString('jwt');
    final String? type = prefs.getString('type-jwt');
    final String? username = prefs.getString('username');
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
      await prefs.remove('username-');
      await prefs.remove('roles-jwt');
      jwtResponse = null;
    }

    return jwtResponse;
  }

  Future<String> getUserName() async {
    log("getUserName", name: "AuthRepository");
    // Init SharedPreferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get JWT from SharedPreferences
    final String? username = prefs.getString('username');

    return username ?? '';
  }

  Future<void> saveJWT(JwtResponse jwtResponse) async {
    log("saveJWT", name: "AuthRepository");
    // Init SharedPreferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save JWT to SharedPreferences
    await prefs.setString('jwt', jwtResponse.token);
    await prefs.setString('type-jwt', jwtResponse.type);
    await prefs.setString('username', jwtResponse.username);
    await prefs.setStringList('roles-jwt', jwtResponse.roles);
  }

  Future<void> removeJWT() async {
    // Init SharedPreferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Remove JWT from SharedPreferences
    await prefs.remove('jwt');
    await prefs.remove('type-jwt');
    await prefs.remove('username');
    await prefs.remove('roles-jwt');
  }

  Future<JwtResponse?> login(String body) async {
    log("login", name: "AuthRepository");
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
      log("Login success", name: "AuthRepository");
      ResponseModel responseModel = ResponseModel.fromJson(response.body);
      JwtResponse jwtResponse =
          JwtResponse.fromMap(responseModel.data as Map<String, dynamic>);
      await saveJWT(jwtResponse);
      return jwtResponse;
    } else {
      log("Login failed", name: "AuthRepository");
      return null;
    }
  }

  Future<bool> logout() async {
    log("logout", name: "AuthRepository");
    //Get jwto token current
    String jwt = (await getJWTCurrent())!.token;

    // Get URL, header
    Map<String, String> headers = BaseHeaderHttp.headers;
    headers['Authorization'] = 'Bearer $jwt';
    String authority = APIUrl.baseUrl;
    String unencodedPath = APIUrl.pathLogout;

    // Call logo API
    var response = await http.post(
      Uri.http(authority, unencodedPath),
      headers: headers,
    );

    if (response.statusCode == 200) {
      await removeJWT();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> signUp(String body) async {
    log("signUp", name: "AuthRepository");
    // Get URL, header
    Map<String, String> headers = BaseHeaderHttp.headers;
    String authority = APIUrl.baseUrl;
    String unencodedPath = APIUrl.pathSignUp;

    // Call sign up API
    var response = await http.post(
      Uri.http(authority, unencodedPath),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkUsernameExists(String username) async {
    log("checkUsernameExists", name: "AuthRepository");
    Map<String, String> headers = BaseHeaderHttp.headers;
    String authority = APIUrl.baseUrl;
    String unencodedPath = APIUrl.pathCheckUsername;

    final url = Uri.http(authority, unencodedPath, {'username': username});

    // Call api to check
    final response = await http.get(
      url,
      headers: headers,
    );

    bool check = jsonDecode(response.body)['data'];
    return check;
  }

  Future<bool> checkEmailExists(String email) async {
    log("checkEmailExists", name: "AuthRepository");
    Map<String, String> headers = BaseHeaderHttp.headers;
    String authority = APIUrl.baseUrl;
    String unencodedPath = APIUrl.pathCheckEmail;

    final url = Uri.http(authority, unencodedPath, {'email': email});

    // Call api to check
    final response = await http.get(
      url,
      headers: headers,
    );

    bool check = jsonDecode(response.body)['data'];
    return check;
  }

  Future<bool> resetPassword(String email) async {
    log("resetPassword", name: "AuthRepository");
    Map<String, String> headers = BaseHeaderHttp.headers;
    String authority = APIUrl.baseUrl;
    String unencodedPath = APIUrl.pathResetPassword + email;

    final url = Uri.http(authority, unencodedPath);

    // Call api to check
    final response = await http.post(
      url,
      headers: headers,
    );

    int httpStatusCode = response.statusCode;

    bool check = httpStatusCode == 200;
    return check;
  }

  Future<String> verifyOTPResetPass(String body) async {
    log("verifyOTP", name: "AuthRepository");
    Map<String, String> headers = BaseHeaderHttp.headers;
    String authority = APIUrl.baseUrl;
    String unencodedPath = APIUrl.pathVerifyOTP;

    final url = Uri.http(authority, unencodedPath);

    // Call api to check
    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    int httpStatusCode = response.statusCode;

    if (httpStatusCode == 200) {
      return 'Code is correct';
    }
    if (httpStatusCode == 404) {
      return 'Code is expired';
    } else {
      return 'Code is incorrect';
    }
  }

  Future<bool> changeResetPassword(String body) async {
    log("changeResetPassword", name: "AuthRepository");
    Map<String, String> headers = BaseHeaderHttp.headers;
    String authority = APIUrl.baseUrl;
    String unencodedPath = APIUrl.pathChangeResetPassword;

    final url = Uri.http(authority, unencodedPath);

    // Call api to check
    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    int httpStatusCode = response.statusCode;

    bool check = httpStatusCode == 200;
    return check;
  }
}
