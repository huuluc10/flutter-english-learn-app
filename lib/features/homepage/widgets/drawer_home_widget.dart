// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/auth/provider/auth_provider.dart';
import 'package:flutter_englearn/features/friend/pages/find_friend_screen.dart';
import 'package:flutter_englearn/features/homepage/pages/settings_screen.dart';
import 'package:flutter_englearn/features/homepage/widgets/item_drawer_widget.dart';
import 'package:flutter_englearn/features/mission/pages/mission_screen.dart';
import 'package:flutter_englearn/features/user_info/pages/user_info_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrawerWidget extends ConsumerWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;

    Future<String> getUsername() async {
      String username = await ref
          .watch(authServiceProvicer)
          .getJWT()
          .then((value) => value.username);
      return username;
    }

    return Drawer(
      backgroundColor: Colors.white,
      elevation: 0,
      width: width * 0.8,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color.fromARGB(169, 0, 141, 211),
                  Color.fromARGB(169, 22, 145, 206),
                ],
                tileMode: TileMode.mirror,
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.transparent,
                  child: Image.asset('assets/englearn.png'),
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'EngLearn',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      'Ứng dụng học tiếng Anh',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Divider(
              color: Colors.grey[350],
              height: 1,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 14,
              top: 12,
            ),
            child: Text(
              'Tài khoản',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ItemDrawerWidget(
            title: 'Thông tin tài khoản',
            image: 'assets/user.png',
            routeName: UserInfoScreen.routeName,
            onTap: () async {
              Navigator.pushNamed(
                context,
                UserInfoScreen.routeName,
                arguments: {
                  'username': await getUsername(),
                  'isFriend': false,
                },
              );
            },
          ),
          ItemDrawerWidget(
            title: 'Tìm kiếm bạn bè',
            image: 'assets/add-friend.png',
            routeName: FindFriendScreen.routeName,
            onTap: () {
              Navigator.pushNamed(
                context,
                FindFriendScreen.routeName,
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Divider(
              color: Colors.grey[350],
              height: 1,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 14,
              top: 12,
            ),
            child: Text(
              'Nhiệm vụ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ItemDrawerWidget(
            title: 'Nhiệm vụ hằng ngày',
            image: 'assets/goal.png',
            routeName: MissionScreen.routeName,
            onTap: () {
              Navigator.pushNamed(
                context,
                MissionScreen.routeName,
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Divider(
              color: Colors.grey[350],
              height: 1,
            ),
          ),
          ItemDrawerWidget(
            title: "Cài đặt",
            image: 'assets/settings.png',
            routeName: SettingsScreen.routeName,
            onTap: () {
              Navigator.pushNamed(
                context,
                SettingsScreen.routeName,
              );
            },
          )
        ],
      ),
    );
  }
}
