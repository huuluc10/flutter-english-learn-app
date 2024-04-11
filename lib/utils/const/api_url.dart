class APIUrl {
  // ip and port
  static const String ip = "192.168.1.202";
  static const String portEngLearn = "8080";
  static const String portSocket = "8082";

  // base url
  static const String baseUrl = "$ip:$portEngLearn";
  static const String baseUrlSocket = "ws://$ip:$portSocket";

  // path dictionary api
  static const String rootDictionaryAPI = "api.dictionaryapi.dev";
  static const String pathDictionary = "api/v2/entries/en/";

  // path auth api
  static const String pathLogin = "auth/signin";
  static const String pathLogout = "auth/logout";
  static const String pathSignUp = "auth/signup";
  static const String pathCheckUsername = "auth/checkUsername";
  static const String pathCheckEmail = "auth/checkEmail";
  static const String pathChangeResetPassword =
      "auth/resetPassword/setNewPassword";

  // path otp api
  static const String pathResetPassword = "otp/forgot-password/";
  static const String pathVerifyOTP = "otp/verifyCodeOTP";
  static const String pathAddEmail = "otp/addEmail";

  // path lesson api
  static const String pathSummaryOfTopic = "api/v1/lessons/topic/";

  // path topic api
  static const String pathAllTopic = "api/v1/topic/";

  // path user api
  static const String pathChangePassword = "/api/v1/user/changePassword";
  static const String pathGetUserInfo = "api/v1/user/getByUsername";
  static const String pathUpdateUserInfo = "api/v1/user/update";
  static const String pathUpdateAvatar = "api/v1/user/updateAvatar";
  static const String pathFindFriend = "/api/v1/user/findUser";

  static const String pathUpdateStreak = "/api/v1/user/updateStreak";

  // path storage api
  static const String pathGetFile = "storage/getfile";

  //path get history learn lesson api
  static const String pathSaveHistoryLearnLesson = "/api/v1/user-lesson/";
  static const String pathCountHistoryLearnedLesson =
      "/api/v1/user-lesson/count-lesson-learned/";

  // path get history do exercise api
  static const String pathGetExerciseLessonHistory =
      "/api/v1/user-question/count-lesson-have-exercises-done";
  static const String pathGetExerciseExamHistory =
      "/api/v1/user-question/count-exam-have-exercises-done";

  // path friend api
  static const String pathGetFriendByUsername = "/api/v1/friend-request/";
  static const String pathAddFriend = "/api/v1/friend-request/";
  static const String pathGetStatusOfRequestFriend =
      "/api/v1/friend-request/status";
  static const String pathUnFriend = "/api/v1/friend-request/delete";

  // path lesson api
  static const String pathGetListLessonOfTopic = "/api/v1/lessons/topic";
  static const String pathSaveHistoryLesson = "/api/v1/user-lesson/";

  // path get list daily mission api
  static const String pathGetListDailyMission = "/api/v1/mission-daily/";
}
