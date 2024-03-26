import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/auth/page/adding_info_sign_up_screen.dart';
import 'package:flutter_englearn/features/auth/page/login_screen.dart';
import 'package:flutter_englearn/features/auth/page/otp_input_screen.dart';
import 'package:flutter_englearn/features/auth/page/reset_password_screen.dart';
import 'package:flutter_englearn/features/auth/page/sign_up_screen.dart';
import 'package:flutter_englearn/features/auth/page/welcome_screen.dart';
import 'package:flutter_englearn/features/chat/page/chat_home_screen.dart';
import 'package:flutter_englearn/features/chat/page/chat_room_screen.dart';
import 'package:flutter_englearn/features/dictionary/page/dictionary_screen.dart';
import 'package:flutter_englearn/features/friend/page/find_friend_screen.dart';
import 'package:flutter_englearn/features/homepage/page/about_screen.dart';
import 'package:flutter_englearn/features/homepage/page/home_screen.dart';
import 'package:flutter_englearn/features/homepage/page/settings_screen.dart';
import 'package:flutter_englearn/features/learn/page/lesson_content_screen.dart';
import 'package:flutter_englearn/features/learn/page/multichoice_questions_screen.dart';
import 'package:flutter_englearn/features/learn/page/topic_details_screen.dart';
import 'package:flutter_englearn/features/learn/page/lesson_homepage_screen.dart';
import 'package:flutter_englearn/features/mission/page/mission_screen.dart';
import 'package:flutter_englearn/features/user_info/page/change_password_screen.dart';
import 'package:flutter_englearn/features/user_info/page/more_info_screen.dart';
import 'package:flutter_englearn/features/user_info/page/user_info_screen.dart';
import 'package:flutter_englearn/model/topic_response.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case WelcomeScreen.routeName:
      return MaterialPageRoute(builder: (context) => const WelcomeScreen());

    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context) => const LoginScreen());

    case SignUpScreen.routeName:
      return MaterialPageRoute(builder: (context) => const SignUpScreen());

    case AddingInfoSignUpScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const AddingInfoSignUpScreen());

    case ResetPasswordScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const ResetPasswordScreen());

    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (context) => const HomeScreen());

    case DictionaryScreen.routeName:
      return MaterialPageRoute(builder: (context) => const DictionaryScreen());

    case OTPInputScreen.routeName:
      return MaterialPageRoute(builder: (context) => const OTPInputScreen());

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
      final havePermission = settings.arguments as bool;
      return MaterialPageRoute(
          builder: (context) =>
              MoreUserInfoScreen(havePermission: havePermission));

    case ChatHome.routeName:
      return MaterialPageRoute(builder: (context) => const ChatHome());

    case ChatRoom.routeName:
      return MaterialPageRoute(builder: (context) => const ChatRoom());

    case TopicDetailsScreen.routeName:
      final topicResponse = settings.arguments as TopicResponse;
      return MaterialPageRoute(
          builder: (context) =>
              TopicDetailsScreen(topicResponse: topicResponse));

    case LessonHomePageScreen.routeName:
      final topicId = settings.arguments as int;
      return MaterialPageRoute(
          builder: (context) => LessonHomePageScreen(topicId: topicId));

    case LessonContentScreen.routeName:
      final lessonId = settings.arguments as int;
      return MaterialPageRoute(
          builder: (context) => LessonContentScreen(lessonId: lessonId));

          case MultichoiceQuestionScreen.routeName:
      final lessonId = settings.arguments as int;
      return MaterialPageRoute(
          builder: (context) => MultichoiceQuestionScreen(lessonId: lessonId));

    default:
      return MaterialPageRoute(builder: (context) => const WelcomeScreen());
  }
}
