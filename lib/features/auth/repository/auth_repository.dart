import 'package:flutter_englearn/model/response/jwt_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
}
