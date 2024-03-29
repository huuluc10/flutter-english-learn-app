class APIUrl {
  static const String ip = "192.168.1.202";
  static const String portEngLearn = "8080";
  static const String portSocket = "8082";

  static const String baseUrl = "$ip:$portEngLearn";
  static const String baseUrlSocket = "ws://$ip:$portSocket";

  static const String pathLogin = "auth/signin";
  static const String pathLogout = "auth/logout";
  static const String pathSignUp = "auth/signup";
  static const String pathCheckUsername = "auth/checkUsername";
}
