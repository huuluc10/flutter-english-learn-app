class APIUrl {
  // IP ADDRESS SERVER AND PORT
  static const String ip = "192.168.226.233";
  static const String portEngLearn = "8080";
  static const String portSocket = "8082";

  // BASE URL
  static const String baseUrl = "$ip:$portEngLearn";
  static const String baseUrlSocket = "ws://$ip:$portSocket";
  static const String baseUrlSocketHttp = "$ip:$portSocket";

  // PATH DICTIONARY API
  static const String rootDictionaryAPI = "api.dictionaryapi.dev";
  static const String pathDictionary = "api/v2/entries/en/";

  // PATH AUTH API
  static const String pathLogin = "auth/signin";
  static const String pathLogout = "auth/logout";
  static const String pathSignUp = "auth/signup";
  static const String pathCheckUsername = "auth/checkUsername";
  static const String pathCheckEmail = "auth/checkEmail";
  static const String pathChangeResetPassword =
      "auth/resetPassword/setNewPassword";

  // PATH OTP API
  static const String pathResetPassword = "otp/forgot-password/";
  static const String pathVerifyOTP = "otp/verifyCodeOTP";
  static const String pathAddEmail = "otp/addEmail";

  // PATH SUMMARY OF TOPIC API
  static const String pathSummaryOfTopic = "api/v1/lessons/topic/";

  // PATH TOPIC API
  static const String pathAllTopic = "api/v1/topic/";

  // PATH USER API
  static const String pathChangePassword = "/api/v1/user/changePassword";
  static const String pathGetUserInfo = "api/v1/user/getByUsername";
  static const String pathUpdateUserInfo = "api/v1/user/update";
  static const String pathUpdateAvatar = "api/v1/user/updateAvatar";
  static const String pathFindFriend = "/api/v1/user/findUser";

  static const String pathUpdateStreak = "/api/v1/user/updateStreak";

  // PATH STORAGE API
  static const String pathGetFile = "storage/getfile";

  // PATH GET HISTORY LEARN LESSON API
  static const String pathSaveHistoryLearnLesson = "/api/v1/user-lesson/";
  static const String pathCountHistoryLearnedLesson =
      "/api/v1/user-lesson/count-lesson-learned/";

  // PATH GET HISTORY LEARN EXERCISE API
  static const String pathGetExerciseLessonHistory =
      "/api/v1/user-question/count-lesson-have-exercises-done";
  static const String pathGetExerciseExamHistory =
      "/api/v1/user-question/count-exam-have-exercises-done";

  // PATH FRIEND API
  static const String pathGetFriendByUsername = "/api/v1/friend-request/";
  static const String pathAddFriend = "/api/v1/friend-request/";
  static const String pathGetStatusOfRequestFriend =
      "/api/v1/friend-request/status";
  static const String pathUnFriend = "/api/v1/friend-request/delete";

  // PATH LESSON API
  static const String pathGetListLessonOfTopic = "/api/v1/lessons/topic";
  static const String pathSaveHistoryLesson = "/api/v1/user-lesson/";

  // PATH GET LIST DAYLY MISSION API
  static const String pathGetListDailyMission = "/api/v1/mission-daily/";

  // PATH GET QUESTION API
  static const String pathGetMultipleChoiceQuestion =
      "/api/v1/question/findMultipleChoiceQuestionByLessonId";
  static const String pathGetFillInBlankQuestion =
      "/api/v1/question/findFillInBlankQuestionByLessonId";
  static const String pathGetListExerciseQuestion =
      "/api/v1/question/getTypeQuestion/";
  static const String pathGetListSentenceUnscrambleQuestion =
      "/api/v1/question/findSentenceUnscrambleQuestionByLessonId";

  /* ----------------------------------------------------------------------------- */

  // PATH GET ALL ROOM CHAT API
  static const String pathGetAllChatRoom = "/api/chat-room";
}
