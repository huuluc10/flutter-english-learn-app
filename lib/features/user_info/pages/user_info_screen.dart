import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/user_info/pages/more_info_screen.dart';
import 'package:flutter_englearn/features/user_info/providers/user_info_provider.dart';
import 'package:flutter_englearn/features/user_info/widgets/avatar_widget.dart';
import 'package:flutter_englearn/features/user_info/widgets/statistics_widget.dart';
import 'package:flutter_englearn/features/user_info/widgets/streak_chart.dart';
import 'package:flutter_englearn/model/response/user_info_response.dart';
import 'package:flutter_englearn/utils/widgets/line_gradient_background_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInfoScreen extends ConsumerWidget {
  const UserInfoScreen({
    super.key,
    required this.isFriend,
    required this.isMe,
  });

  static const String routeName = '/user-info-screen';
  final bool isFriend;
  final bool isMe;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    Future<UserInfoResponse> getUserInfo() async {
      try {
        final userInfo =
            await ref.read(userInfoServiceProvider).getUserInfo(context);
        return userInfo;
      } catch (e) {
        print('Error: $e');
        throw e;
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
          child: FutureBuilder<UserInfoResponse>(
              future: getUserInfo(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error'),
                  );
                }

                final UserInfoResponse userInfo =
                    snapshot.data as UserInfoResponse;

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
                                    userInfo: userInfo,
                                  ),
                                  const Divider(
                                    color: Colors.white,
                                    thickness: 1.0,
                                  ),
                                  const Text(
                                    'Biểu đồ học tập 7 ngày gần nhất',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 19.5,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const UserStreakChart(),
                                  const SizedBox(height: 15),
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
