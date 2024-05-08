import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/auth/pages/welcome_screen.dart';
import 'package:flutter_englearn/features/auth/repository/auth_repository.dart';
import 'package:flutter_englearn/features/learn/repository/learn_repository.dart';
import 'package:flutter_englearn/model/lesson_content.dart';
import 'package:flutter_englearn/model/question_type.dart';
import 'package:flutter_englearn/model/response/lesson_response.dart';
import 'package:flutter_englearn/model/result_return.dart';
import 'package:flutter_englearn/model/user_lesson.dart';
import 'package:flutter_englearn/common/helper/helper.dart';

class LearnService {
  final LearnRepository learnRepository;
  final AuthRepository authRepository;

  LearnService({
    required this.learnRepository,
    required this.authRepository,
  });

  Future<List<LessonResponse>> getListLessonOfTopic(
      BuildContext context, String topicId) async {
    ResultReturn resultReturn =
        await learnRepository.getListLessonOfTopic(topicId);

    if (resultReturn.httpStatusCode == 401) {
      showSnackBar(
          context, 'Phiên đăng nhập đã hết hạn, vui lòng đăng nhập lại');
      Navigator.of(context)
          .pushNamedAndRemoveUntil(WelcomeScreen.routeName, (route) => false);
    } else if (resultReturn.httpStatusCode == 400) {
      showSnackBar(context, 'Lấy danh sách bài học thất bại');
      return [];
    }

    List<LessonResponse> listLessonResponse =
        resultReturn.data as List<LessonResponse>;
    return listLessonResponse;
  }

  Future<LessconContent> getLessonContent(
      BuildContext context, String url) async {
    ResultReturn resultReturn = await learnRepository.getLessonDetail(url);

    if (resultReturn.httpStatusCode == 401) {
      showSnackBar(
          context, 'Phiên đăng nhập đã hết hạn, vui lòng đăng nhập lại');
      Navigator.of(context)
          .pushNamedAndRemoveUntil(WelcomeScreen.routeName, (route) => false);
    } else if (resultReturn.httpStatusCode == 400) {
      showSnackBar(context, 'Lấy bài học thất bại');
      throw Exception('Lấy bài học thất bại');
    }

    LessconContent listLessonContent = resultReturn.data as LessconContent;

    // Update url image
    for (int i = 0; i < listLessonContent.content.length; i++) {
      String? oldURL = listLessonContent.content[i].imageUrl;

      if (oldURL == null) {
        continue;
      }
      String newURL = transformLocalURLMediaToURL(oldURL);
      listLessonContent.content[i].imageUrl = newURL;
    }

    return listLessonContent;
  }

  Future<void> markLessonAsLearned(
      BuildContext context, int lessonId, Function() updateIsComplete) async {
    // Get current username
    String username = await authRepository.getUserName();

    UserLesson userLesson = UserLesson(
      username: username,
      lessonId: lessonId,
      dateLearned: DateTime.now(),
    );
    ResultReturn resultReturn =
        await learnRepository.saveHistoryLesson(userLesson.toJson());

    if (resultReturn.httpStatusCode == 401) {
      if (!context.mounted) return;
      showSnackBar(
          context, 'Phiên đăng nhập đã hết hạn, vui lòng đăng nhập lại');
      Navigator.of(context)
          .pushNamedAndRemoveUntil(WelcomeScreen.routeName, (route) => false);
    } else if (resultReturn.httpStatusCode == 400) {
      if (!context.mounted) return;
      showSnackBar(context, 'Đánh dấu bài học đã học thất bại');
    } else {
      if (!context.mounted) return;
      showSnackBar(context, 'Đánh dấu bài học đã học thành công');
      Navigator.of(context).pop();
      updateIsComplete();
    }
  }

  Future<List<QuestionType>> getListExerciseOfLesson(
      BuildContext context, int lessonId) async {
    ResultReturn resultReturn =
        await learnRepository.getListExerciseOfLessopn(lessonId);

    if (resultReturn.httpStatusCode == 401) {
      showSnackBar(
          context, 'Phiên đăng nhập đã hết hạn, vui lòng đăng nhập lại');
      Navigator.of(context).pushNamedAndRemoveUntil(
        WelcomeScreen.routeName,
        (route) => false,
      );
    } else if (resultReturn.httpStatusCode == 400) {
      showSnackBar(context, 'Lấy danh sách bài tập thất bại');
      return [];
    }

    List<QuestionType> listQuestionType =
        resultReturn.data as List<QuestionType>;
    return listQuestionType;
  }
}
