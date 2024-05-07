// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/user_info/pages/user_info_screen.dart';

import 'package:flutter_englearn/model/response/main_user_info_request.dart';
import 'package:flutter_englearn/common/widgets/line_gradient_background_widget.dart';

class ListFriendScreen extends StatefulWidget {
  const ListFriendScreen({
    Key? key,
    required this.friends,
  }) : super(key: key);

  static const String routeName = "/list-friend_screen";
  final List<MainUserInfoResponse> friends;
  @override
  State<ListFriendScreen> createState() => _ListFriendScreenState();
}

class _ListFriendScreenState extends State<ListFriendScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(169, 0, 141, 211),
        title: const Text('Danh sách bạn bè'),
      ),
      body: LineGradientBackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemBuilder: (content, index) {
              MainUserInfoResponse user = widget.friends[index];
              return InkWell(
                onTap: () => Navigator.pushNamed(
                  context,
                  UserInfoScreen.routeName,
                  arguments: user.username,
                ),
                child: Container(
                  color: Colors.black54,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80.0),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                user.urlAvatar,
                                cacheKey: DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString(),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            user.fullName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            user.username,
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: widget.friends.length,
          ),
        ),
      ),
    );
  }
}
