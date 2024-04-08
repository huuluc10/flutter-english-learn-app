import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/user_info/controller/user_info_controller.dart';
import 'package:flutter_englearn/features/user_info/pages/more_info_screen.dart';
import 'package:flutter_englearn/features/user_info/widgets/avatar_widget.dart';
import 'package:flutter_englearn/features/user_info/widgets/statistics_widget.dart';
import 'package:flutter_englearn/model/response/main_user_info_request.dart';
import 'package:flutter_englearn/model/response/user_info_response.dart';
import 'package:flutter_englearn/utils/widgets/line_gradient_background_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInfoScreen extends ConsumerStatefulWidget {
  const UserInfoScreen({
    super.key,
    required this.isFriend,
    required this.username,
  });

  static const String routeName = '/user-info-screen';
  final bool isFriend;
  final String username;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends ConsumerState<UserInfoScreen> {
  bool isMe = false;

  Future<Map<String, Object>> getUserInfo(String username) async {
    return await getInfo(
      context,
      ref,
      username,
      (bool value) {
        isMe = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

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
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () async {
                showImagePicker(context, ref, () {
                  setState(() {});
                });
              },
              child: Image.asset(
                'assets/change-picture.png',
                height: 40,
                width: 40,
              ),
            ),
          ),
        ],
      ),
      body: LineGradientBackgroundWidget(
        child: SizedBox(
          height: height,
          width: width,
          child: FutureBuilder<Map<String, Object>>(
              future: getUserInfo(widget.username),
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
                                    widget.username,
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
                                            : widget.isFriend
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
                                  FutureBuilder(
                                    future: getFriends(
                                      context,
                                      ref,
                                      widget.username,
                                    ),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }

                                      if (snapshot.hasError) {
                                        return Center(
                                          child:
                                              Text('Error: ${snapshot.error}'),
                                        );
                                      }

                                      final List<MainUserInfoResponse> friends =
                                          snapshot.data
                                              as List<MainUserInfoResponse>;

                                      return Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Row(
                                              children: <Widget>[
                                                const Text(
                                                  'Bạn bè ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  '(${friends.length})',
                                                  style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                const Spacer(),
                                                const Text(
                                                  'Danh sách yêu cầu',
                                                  style: TextStyle(
                                                      color: Colors.blueAccent,
                                                      fontSize: 17),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
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
