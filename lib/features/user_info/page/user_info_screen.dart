import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/user_info/widgets/avatar_widget.dart';
import 'package:flutter_englearn/features/user_info/widgets/statistics_widget.dart';
import 'package:flutter_englearn/features/user_info/widgets/streak_chart.dart';
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
          child: Column(
            children: <Widget>[
              AvatarWidget(
                height: height,
                width: width,
                avatarUrl: 'assets/male.jpg',
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
                            const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text(
                                'Nguyễn Hữu Lực',
                                style: TextStyle(
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
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32.0),
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
                            StatisticsWidget(width: width),
                            const Divider(
                              color: Colors.white,
                              thickness: 1.0,
                            ),
                            const Text(
                              'Biểu đồ chuỗi ngày học tập',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
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
          ),
        ),
      ),
    );
  }
}
