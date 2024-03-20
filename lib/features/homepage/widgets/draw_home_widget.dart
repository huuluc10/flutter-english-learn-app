import 'package:flutter/material.dart';

class DrawHomeWidget extends StatelessWidget {
  const DrawHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
          ListTile(
            leading: CircleAvatar(
              radius: 14,
              child: Image.asset('assets/user.png'),
            ),
            title: const Text('Thông tin tài khoản'),
            subtitle: const Text('username'),
          ),
          ListTile(
            leading: CircleAvatar(
              radius: 14,
              child: Image.asset('assets/add-friend.png'),
            ),
            title: const Text('Tìm kiếm bạn bè'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Divider(
              color: Colors.grey[350],
              height: 1,
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              radius: 14,
              child: Image.asset('assets/settings.png'),
            ),
            title: const Text('Cài đặt'),
          ),
        ],
      ),
    );
  }
}
