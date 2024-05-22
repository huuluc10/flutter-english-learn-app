import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/auth/pages/adding_info_sign_up_screen.dart';
import 'package:flutter_englearn/features/auth/pages/login_screen.dart';
import 'package:flutter_englearn/features/auth/pages/otp_input_screen.dart';
import 'package:flutter_englearn/features/auth/pages/reset_password_screen.dart';
import 'package:flutter_englearn/features/auth/pages/set_password_screen.dart';
import 'package:flutter_englearn/features/auth/pages/sign_up_screen.dart';
import 'package:flutter_englearn/features/auth/pages/welcome_screen.dart';
import 'package:flutter_englearn/features/chat/pages/chat_home_screen.dart';
import 'package:flutter_englearn/features/chat/pages/chat_room_screen.dart';
import 'package:flutter_englearn/features/dictionary/pages/dictionary_screen.dart';
import 'package:flutter_englearn/features/exercise/pages/exam_homepage_screen.dart';
import 'package:flutter_englearn/features/exercise/pages/exam_question_screen.dart';
import 'package:flutter_englearn/features/exercise/pages/explantion_result_screen.dart';
import 'package:flutter_englearn/features/exercise/pages/fill_in_the_blank_question_screen.dart';
import 'package:flutter_englearn/features/exercise/pages/listening_question_screen.dart';
import 'package:flutter_englearn/features/exercise/pages/multichoice_questions_screen.dart';
import 'package:flutter_englearn/features/exercise/pages/sentence_transform_question_screen.dart';
import 'package:flutter_englearn/features/exercise/pages/sentence_unscramble_question_screen.dart';
import 'package:flutter_englearn/features/exercise/pages/speaking_question_screen.dart';
import 'package:flutter_englearn/features/friend/pages/find_friend_screen.dart';
import 'package:flutter_englearn/features/friend/pages/list_friend_request_screen.dart';
import 'package:flutter_englearn/features/friend/pages/list_friend_screen.dart';
import 'package:flutter_englearn/features/homepage/pages/about_screen.dart';
import 'package:flutter_englearn/features/homepage/pages/home_screen.dart';
import 'package:flutter_englearn/features/homepage/pages/leaderboard_screen.dart';
import 'package:flutter_englearn/features/homepage/pages/settings_screen.dart';
import 'package:flutter_englearn/features/learn/pages/lesson_content_screen.dart';
import 'package:flutter_englearn/features/exercise/pages/result_exercise_screen.dart';
import 'package:flutter_englearn/features/learn/pages/topic_details_screen.dart';
import 'package:flutter_englearn/features/learn/pages/lesson_homepage_screen.dart';
import 'package:flutter_englearn/features/mission/pages/mission_screen.dart';
import 'package:flutter_englearn/features/user_info/pages/change_password_screen.dart';
import 'package:flutter_englearn/features/user_info/pages/more_info_screen.dart';
import 'package:flutter_englearn/features/user_info/pages/user_info_screen.dart';
import 'package:flutter_englearn/model/explanation_question.dart';
import 'package:flutter_englearn/model/request/sign_up_request.dart';
import 'package:flutter_englearn/model/response/history_learn_topic_response.dart';
import 'package:flutter_englearn/model/response/main_user_info_request.dart';
import 'package:flutter_englearn/model/response/question_response.dart';
import 'package:flutter_englearn/model/response/user_info_response.dart';
import 'package:flutter_englearn/common/pages/error_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case WelcomeScreen.routeName:
      return MaterialPageRoute(builder: (context) => const WelcomeScreen());

    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context) => const LoginScreen());

    case SignUpScreen.routeName:
      return MaterialPageRoute(builder: (context) => const SignUpScreen());

    case AddingInfoSignUpScreen.routeName:
      final SignUpRequest signUpRequest = settings.arguments as SignUpRequest;
      return MaterialPageRoute(
          builder: (context) =>
              AddingInfoSignUpScreen(signUpRequest: signUpRequest));

    case ResetPasswordScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const ResetPasswordScreen());

    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (context) => const HomeScreen());

    case DictionaryScreen.routeName:
      return MaterialPageRoute(builder: (context) => const DictionaryScreen());

    case OTPInputScreen.routeName:
      final arguments = settings.arguments as List<dynamic>;
      final email = arguments[0];
      final isResetPassword = arguments[1];
      final username = arguments[2];
      return MaterialPageRoute(
          builder: (context) => OTPInputScreen(
                email: email,
                iSResetPassword: isResetPassword,
                username: username,
              ));

    case UserInfoScreen.routeName:
      final username = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => UserInfoScreen(
          username: username,
        ),
      );

    case FindFriendScreen.routeName:
      return MaterialPageRoute(builder: (context) => const FindFriendScreen());

    case MissionScreen.routeName:
      return MaterialPageRoute(builder: (context) => const MissionScreen());

    case SettingsScreen.routeName:
      return MaterialPageRoute(builder: (context) => const SettingsScreen());

    case AboutScreen.routeName:
      return MaterialPageRoute(builder: (context) => const AboutScreen());

    case ChangePasswordScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const ChangePasswordScreen());

    case MoreUserInfoScreen.routeName:
      final arguments = settings.arguments as List<Object>;
      final havePermission = arguments[0] as bool;
      final userInfo = arguments[1] as UserInfoResponse;
      return MaterialPageRoute(
          builder: (context) => MoreUserInfoScreen(
                havePermission: havePermission,
                userInfo: userInfo,
              ));

    case ChatHome.routeName:
      return MaterialPageRoute(builder: (context) => const ChatHome());

    case ChatRoomScreen.routeName:
      final arguments = settings.arguments as List<String>;
      final chatId = arguments[0];
      final usernameReceiver = arguments[1];
      final receriverAvatar = arguments[2];
      return MaterialPageRoute(
          builder: (context) => ChatRoomScreen(
                chatId: chatId,
                usernameReceiver: usernameReceiver,
                receriverAvatar: receriverAvatar,
              ));

    case TopicDetailsScreen.routeName:
      final argruments = settings.arguments as List<dynamic>;
      final topicResponse = argruments[0] as HistoryLearnTopicResponse;
      final refresh = argruments[1] as Function();
      final successRate = argruments[2] as double;
      return MaterialPageRoute(
          builder: (context) => TopicDetailsScreen(
                topicResponse: topicResponse,
                refresh: refresh,
                successRate: successRate,
              ));

    case LessonHomePageScreen.routeName:
      final arguments = settings.arguments as List<dynamic>;
      final topicId = arguments[0] as int;
      final successRate = arguments[1] as double;
      return MaterialPageRoute(
          builder: (context) => LessonHomePageScreen(
                topicId: topicId,
                successRate: successRate,
              ));

    case LessonContentScreen.routeName:
      final arguments = settings.arguments as List<dynamic>;
      final int lessonId = arguments[0];
      final url = arguments[1] as String;
      final isCompleted = arguments[2] as String;
      final onMarkAsLearned = arguments[3] as Function();
      return MaterialPageRoute(
          builder: (context) => LessonContentScreen(
                lessonId: lessonId,
                url: url,
                isCompleted: isCompleted,
                onMarkAsLearned: onMarkAsLearned,
              ));

    case MultichoiceQuestionScreen.routeName:
      final questions = settings.arguments as List<QuestionResponse>;
      return MaterialPageRoute(
          builder: (context) =>
              MultichoiceQuestionScreen(questions: questions));

    case ResultExerciseScreen.routeName:
      final arguments = settings.arguments as List<Object>;
      final correctAnswerCount = arguments[0] as int;
      final totalQuestionCount = arguments[1] as int;
      final List<ExplanationQuestion> explanationQuestions =
          (arguments[2] as List)
              .map((item) => item as ExplanationQuestion)
              .toList();
      final typeExercise = arguments[3] as String;
      return MaterialPageRoute(
          builder: (context) => ResultExerciseScreen(
                correctAnswerCount: correctAnswerCount,
                totalQuestionCount: totalQuestionCount,
                explanationQuestions: explanationQuestions,
                typeExercise: typeExercise,
              ));

    case ExplanationResultScreen.routeName:
      final arguments = settings.arguments as List<Object?>;
      final explanationQuestions = arguments[0] as List<ExplanationQuestion>;
      final typeExercise = arguments[1] as String;
      return MaterialPageRoute(
          builder: (context) => ExplanationResultScreen(
                explanationQuestions: explanationQuestions,
                typeExercise: typeExercise,
              ));

    case SentenceTransformQuestionScreen.routeName:
      final question = settings.arguments as List<QuestionResponse>;
      return MaterialPageRoute(
          builder: (context) => SentenceTransformQuestionScreen(
                questions: question,
              ));

    case FillInTheBlankQuestionScreen.routeName:
      final question = settings.arguments as List<QuestionResponse>;
      return MaterialPageRoute(
          builder: (context) => FillInTheBlankQuestionScreen(
                questions: question,
              ));

    case SentenceUnscrambleQuestionScreen.routeName:
      final questions = settings.arguments as List<QuestionResponse>;
      return MaterialPageRoute(
          builder: (context) => SentenceUnscrambleQuestionScreen(
                questions: questions,
              ));

    case SpeakingQuestionScreen.routeName:
      final questions = settings.arguments as List<QuestionResponse>;
      return MaterialPageRoute(
          builder: (context) => SpeakingQuestionScreen(
                questions: questions,
              ));

    case ListeningQuestionScreen.routeName:
      final questions = settings.arguments as List<QuestionResponse>;
      return MaterialPageRoute(
          builder: (context) => ListeningQuestionScreen(
                questions: questions,
              ));

    case ExamHomePageScreen.routeName:
      final topicId = settings.arguments as int;
      return MaterialPageRoute(
          builder: (context) => ExamHomePageScreen(topicId: topicId));

    case ErrorScreen.routeName:
      return MaterialPageRoute(builder: (context) => const ErrorScreen());

    case SetPasswordScreen.routeName:
      final email = settings.arguments as String;
      return MaterialPageRoute(
          builder: (context) => SetPasswordScreen(email: email));

    case ListFriendScreen.routeName:
      final friends = settings.arguments as List<MainUserInfoResponse>;
      return MaterialPageRoute(
          builder: (context) => ListFriendScreen(friends: friends));

    case ExamScreen.routeName:
      final arguments = settings.arguments as List<Object>;
      final int examId = arguments[0] as int;
      final int duration = arguments[1] as int;
      final onMarkAsDone = arguments[2] as Function(double);
      final int exp = arguments[3] as int;
      return MaterialPageRoute(
        builder: (context) => ExamScreen(
          examId: examId,
          duration: duration,
          onMarkAsDone: onMarkAsDone,
          exp: exp,
        ),
      );

    case LeaderboardScreen.routeName:
      return MaterialPageRoute(builder: (context) => const LeaderboardScreen());

    case ListFriendRequestScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const ListFriendRequestScreen());

    default:
      return MaterialPageRoute(builder: (context) => const WelcomeScreen());
  }
}
