class APIUrl {
  static const String ip = "192.168.184.233";
  static const String portEngLearn = "8080";
  static const String portSocket = "8082";

  static const String baseUrl = "$ip:$portEngLearn";
  static const String baseUrlSocket = "ws://$ip:$portSocket";

  static const String pathLogin = "auth/signin";
  static const String pathLogout = "auth/logout";
}
