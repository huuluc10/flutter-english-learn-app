import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/auth/pages/welcome_screen.dart';
import 'package:flutter_englearn/features/auth/provider/auth_provider.dart';
import 'package:flutter_englearn/features/friend/providers/friend_provider.dart';
import 'package:flutter_englearn/features/user_info/providers/user_info_provider.dart';
import 'package:flutter_englearn/model/response/jwt_response.dart';
import 'package:flutter_englearn/model/response/main_user_info_request.dart';
import 'package:flutter_englearn/model/result_return.dart';
import 'dart:developer' as logger;

import 'package:flutter_englearn/utils/helper/helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

void changeAvatar(
  BuildContext context,
  WidgetRef ref,
  String imagePath,
  Function() refresh,
) async {
  Navigator.pop(context);
  ResultReturn result =
      await ref.read(userInfoServiceProvider).updateAvatar(context, imagePath);

  if (result.httpStatusCode == 401) {
    logger.log('Token expired', name: 'UserInfoScreen');

    if (!context.mounted) return;
    Navigator.pushNamedAndRemoveUntil(
        context, WelcomeScreen.routeName, (route) => false);
  } else if (result.httpStatusCode == 400) {
    logger.log('Update avatar failed', name: 'UserInfoScreen');
    if (!context.mounted) return;
    showSnackBar(context, 'Update avatar failed');
  } else {
    logger.log('Update avatar successfully', name: 'UserInfoScreen');
    if (!context.mounted) return;
    showSnackBar(context, 'Update avatar successfully');
    refresh();
  }
}

void showImagePicker(
  BuildContext context,
  WidgetRef ref,
  Function() refresh,
) async {
  final picker = ImagePicker();
  XFile? imageFilePicker;
  showModalBottomSheet(
    context: context,
    builder: (builder) {
      return Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height * 0.1,
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: InkWell(
                onTap: () async {
                  imageFilePicker = await imgFromCamera(picker);
                  if (!context.mounted) return;
                  changeAvatar(
                    context,
                    ref,
                    imageFilePicker!.path,
                    refresh,
                  );
                },
                child: const Column(
                  children: [
                    Icon(Icons.camera_alt),
                    Text('Chụp ảnh'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () async {
                  imageFilePicker = await imgFromGallery(picker);
                  if (!context.mounted) return;
                  changeAvatar(
                    context,
                    ref,
                    imageFilePicker!.path,
                    refresh,
                  );
                },
                child: const Column(
                  children: [
                    Icon(Icons.photo),
                    Text('Chọn ảnh từ thư viện'),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Future<List<MainUserInfoResponse>> getFriends(
  BuildContext context,
  WidgetRef ref,
  String username,
) async {
  final friends =
      await ref.read(friendServiceProvider).getFriends(context, username);

  return friends;
}

Future<Map<String, Object>> getInfo(
  BuildContext context,
  WidgetRef ref,
  String username,
  Function(bool) updateIsMe,
) async {
  try {
    final userInfo =
        await ref.read(userInfoServiceProvider).getUserInfo(context, username);
    final String currentUser = await ref
        .read(authServiceProvicer)
        .getJWT()
        .then((value) => value.username);

    if (username == currentUser) {
      updateIsMe(true);
    } else {
      updateIsMe(false);
    }
    final countHistoryLearnedLesson =
        await ref.read(userInfoServiceProvider).countHistoryLearnedLesson();

    final countLessonExercisesDone =
        await ref.read(userInfoServiceProvider).getLessonExerciseDone();
    final countExamExercisesDone =
        await ref.read(userInfoServiceProvider).getExamExerciseDone();

    Map<String, Object> result = {
      'userInfo': userInfo,
      'countHistoryLearnedLesson': countHistoryLearnedLesson,
      'countLessonExercisesDone': countLessonExercisesDone,
      'countExamExercisesDone': countExamExercisesDone,
    };

    return result;
  } catch (e) {
    rethrow;
  }
}
