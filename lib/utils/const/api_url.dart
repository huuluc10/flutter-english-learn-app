class APIUrl {
  static const String ip = "huuluc.ddns.net";
  static const String portEngLearn = "8080";
  static const String portSocket = "8082";

  static const String baseUrl = "$ip:$portEngLearn";
  static const String baseUrlSocket = "ws://$ip:$portSocket";

  // path auth api
  static const String pathLogin = "auth/signin";
  static const String pathLogout = "auth/logout";
  static const String pathSignUp = "auth/signup";
  static const String pathCheckUsername = "auth/checkUsername";
  static const String pathCheckEmail = "auth/checkEmail";
  static const String pathChangeResetPassword =
      "auth/resetPassword/setNewPassword";

  //path otp api
  static const String pathResetPassword = "otp/forgot-password/";
  static const String pathVerifyOTP = "otp/verifyCodeOTP";
}
