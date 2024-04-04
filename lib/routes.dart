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
import 'package:flutter_englearn/features/exercise/pages/explantion_result_screen.dart';
import 'package:flutter_englearn/features/exercise/pages/full_in_the_blank_question_screen.dart';
import 'package:flutter_englearn/features/exercise/pages/listening_question_screen.dart';
import 'package:flutter_englearn/features/exercise/pages/multichoice_questions_screen.dart';
import 'package:flutter_englearn/features/exercise/pages/sentence_transform_question_screen.dart';
import 'package:flutter_englearn/features/exercise/pages/sentence_unscramble_question_screen.dart';
import 'package:flutter_englearn/features/exercise/pages/speaking_question_screen.dart';
import 'package:flutter_englearn/features/friend/pages/find_friend_screen.dart';
import 'package:flutter_englearn/features/homepage/pages/about_screen.dart';
import 'package:flutter_englearn/features/homepage/pages/home_screen.dart';
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
import 'package:flutter_englearn/model/response/user_info_response.dart';
import 'package:flutter_englearn/utils/pages/error_screen.dart';

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
      return MaterialPageRoute(
          builder: (context) => OTPInputScreen(
                email: email,
                iSResetPassword: isResetPassword,
              ));

    case UserInfoScreen.routeName:
      final arguments = settings.arguments as Map<String, bool>;
      final isFriend = arguments['isFriend'];
      final isMe = arguments['isMe'];
      return MaterialPageRoute(
        builder: (context) => UserInfoScreen(
          isFriend: isFriend!,
          isMe: isMe!,
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

    case ChatRoom.routeName:
      return MaterialPageRoute(builder: (context) => const ChatRoom());

    case TopicDetailsScreen.routeName:
      final topicResponse = settings.arguments as HistoryLearnTopicResponse;
      return MaterialPageRoute(
          builder: (context) =>
              TopicDetailsScreen(topicResponse: topicResponse));

    case LessonHomePageScreen.routeName:
      final topicId = settings.arguments as int;
      return MaterialPageRoute(
          builder: (context) => LessonHomePageScreen(topicId: topicId));

    case LessonContentScreen.routeName:
      final arguments = settings.arguments as List<Object>;
      final lessonId = arguments[0] as int;
      final isCompleted = arguments[1] as bool;
      return MaterialPageRoute(
          builder: (context) => LessonContentScreen(
                lessonId: lessonId,
                isCompleted: isCompleted,
              ));

    case MultichoiceQuestionScreen.routeName:
      final lessonId = settings.arguments as int;
      return MaterialPageRoute(
          builder: (context) => MultichoiceQuestionScreen(lessonId: lessonId));

    case ResultExerciseScreen.routeName:
      final arguments = settings.arguments as List<Object>;
      final correctAnswerCount = arguments[0] as int;
      final totalQuestionCount = arguments[1] as int;
      final explanationQuestions = arguments[2] as List<ExplanationQuestion>;
      return MaterialPageRoute(
          builder: (context) => ResultExerciseScreen(
                correctAnswerCount: correctAnswerCount,
                totalQuestionCount: totalQuestionCount,
                explanationQuestions: explanationQuestions,
              ));

    case ExplanationResultScreen.routeName:
      final explanationQuestions =
          settings.arguments as List<ExplanationQuestion>;
      return MaterialPageRoute(
          builder: (context) => ExplanationResultScreen(
              explanationQuestions: explanationQuestions));

    case SentenceTransformQuestionScreen.routeName:
      final lessonId = settings.arguments as int;
      return MaterialPageRoute(
          builder: (context) => SentenceTransformQuestionScreen(
                lessonId: lessonId,
              ));

    case FillInTheBlankQuestionScreen.routeName:
      final lessonId = settings.arguments as int;
      return MaterialPageRoute(
          builder: (context) => FillInTheBlankQuestionScreen(
                lessonId: lessonId,
              ));

    case SentenceUnscrambleQuestionScreen.routeName:
      final lessonId = settings.arguments as int;
      return MaterialPageRoute(
          builder: (context) => SentenceUnscrambleQuestionScreen(
                lessonId: lessonId,
              ));

    case SpeakingQuestionScreen.routeName:
      final lessonId = settings.arguments as int;
      return MaterialPageRoute(
          builder: (context) => SpeakingQuestionScreen(
                lessonId: lessonId,
              ));

    case ListeningQuestionScreen.routeName:
      final lessonId = settings.arguments as int;
      return MaterialPageRoute(
          builder: (context) => ListeningQuestionScreen(
                lessonId: lessonId,
              ));

    case ExamHomePageScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const ExamHomePageScreen());

    case ErrorScreen.routeName:
      return MaterialPageRoute(builder: (context) => const ErrorScreen());

    case SetPasswordScreen.routeName:
      final email = settings.arguments as String;
      return MaterialPageRoute(
          builder: (context) => SetPasswordScreen(email: email));

    default:
      return MaterialPageRoute(builder: (context) => const WelcomeScreen());
  }
}
