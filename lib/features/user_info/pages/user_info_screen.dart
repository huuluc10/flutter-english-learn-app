import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/user_info/controller/user_info_controller.dart';
import 'package:flutter_englearn/features/user_info/widgets/avatar_widget.dart';
import 'package:flutter_englearn/features/user_info/widgets/more_user_info_button_widgett.dart';
import 'package:flutter_englearn/features/user_info/widgets/statistics_widget.dart';
import 'package:flutter_englearn/features/user_info/widgets/status_friend_widget.dart';
import 'package:flutter_englearn/features/user_info/widgets/user_friend_summary_info_widget.dart';
import 'package:flutter_englearn/model/response/user_info_response.dart';
import 'package:flutter_englearn/common/widgets/future_builder_error_widget.dart';
import 'package:flutter_englearn/common/widgets/line_gradient_background_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInfoScreen extends ConsumerStatefulWidget {
  const UserInfoScreen({
    super.key,
    required this.username,
  });

  static const String routeName = '/user-info-screen';
  final String username;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends ConsumerState<UserInfoScreen> {
  bool isMe = false;

  @override
  void initState() {
    super.initState();
    updateIsMe(ref, widget.username).then((value) => setState(() {
          isMe = value;
        }));
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
          isMe
              ? Padding(
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
                )
              : Container(),
        ],
      ),
      body: LineGradientBackgroundWidget(
        child: SizedBox(
          height: height,
          width: width,
          child: FutureBuilder<Map<String, Object>>(
              future: getUserInfo(context, ref, widget.username),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return FutureBuilderErrorWidget(
                    error: snapshot.error.toString(),
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
                                    child: isMe
                                        ? MoreUserInfoButton(
                                            isMe: isMe, userInfo: userInfo)
                                        : StatusFriend(
                                            username: widget.username),
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
                                  FriendSummaryInfo(username: widget.username),
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
