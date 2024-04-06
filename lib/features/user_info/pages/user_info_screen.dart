import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/user_info/pages/more_info_screen.dart';
import 'package:flutter_englearn/features/user_info/providers/user_info_provider.dart';
import 'package:flutter_englearn/features/user_info/widgets/avatar_widget.dart';
import 'package:flutter_englearn/features/user_info/widgets/statistics_widget.dart';
import 'package:flutter_englearn/model/response/user_info_response.dart';
import 'package:flutter_englearn/utils/widgets/line_gradient_background_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInfoScreen extends ConsumerWidget {
  const UserInfoScreen({
    super.key,
    required this.isFriend,
    required this.username,
  });

  static const String routeName = '/user-info-screen';
  final bool isFriend;
  final String username;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    late final bool isMe;

    Future<Map<String, Object>> getUserInfo(String username) async {
      try {
        final userInfo = await ref
            .read(userInfoServiceProvider)
            .getUserInfo(context, username);

        if (username == userInfo.username) {
          isMe = true;
        } else {
          isMe = false;
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

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: LineGradientBackgroundWidget(
        child: SizedBox(
          height: height,
          width: width,
          child: FutureBuilder<Map<String, Object>>(
              future: getUserInfo(username),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                final UserInfoResponse userInfo =
                    snapshot.data!['userInfo'] as UserInfoResponse;
                return Column(
                  children: <Widget>[
                    AvatarWidget(
                      height: height,
                      width: width,
                      avatarUrl: userInfo.urlAvatar,
                    ),
                    SizedBox(
                      height: height * 0.55,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.black54,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 5,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      userInfo.fullName,
                                      style: const TextStyle(
                                        fontSize: 28.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    username,
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: OutlinedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          MoreUserInfoScreen.routeName,
                                          arguments: [
                                            isMe,
                                            userInfo,
                                          ],
                                        );
                                      },
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: Colors.blueAccent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(32.0),
                                        ),
                                      ),
                                      child: Text(
                                        isMe
                                            ? 'Chỉnh sửa thông tin'
                                            : isFriend
                                                ? 'Hủy kết bạn'
                                                : 'Thêm bạn bè',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Divider(
                                    color: Colors.white,
                                    thickness: 1.0,
                                  ),
                                  const Text(
                                    'Thống kê',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  StatisticsWidget(
                                    width: width,
                                    info: snapshot.data!,
                                  ),
                                  const Divider(
                                    color: Colors.white,
                                    thickness: 1.0,
                                  ),
                                  const Row(
                                    children: [
                                      Text(
                                        'Bạn bè ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        '(0)',
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        'Danh sách yêu cầu',
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontSize: 17),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
