import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/friend/providers/friend_provider.dart';
import 'package:flutter_englearn/features/user_info/pages/user_info_screen.dart';
import 'package:flutter_englearn/model/response/main_user_info_request.dart';
import 'package:flutter_englearn/utils/widgets/line_gradient_background_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FindFriendScreen extends ConsumerStatefulWidget {
  const FindFriendScreen({super.key});

  static const String routeName = '/find-friend-screen';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FindFriendScreenState();
}

class _FindFriendScreenState extends ConsumerState<FindFriendScreen> {
  late bool isSearching;
  String lastSearchText = '';
  Timer? searchTimer;
  List<MainUserInfoResponse> response = [];

  @override
  void initState() {
    super.initState();
    isSearching = false;
  }

  @override
  void dispose() {
    searchController.dispose();
    searchTimer?.cancel();
    super.dispose();
  }

  final TextEditingController searchController = TextEditingController();

  Future<void> _onTypingFinished(String text) async {
    if (searchTimer != null) {
      searchTimer!.cancel();
    }

    searchTimer = Timer(const Duration(seconds: 1), () async {
      response =
          await ref.watch(friendServiceProvider).findUsers(context, text);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(169, 0, 141, 211),
        title: TextField(
          controller: searchController,
          onChanged: (value) {
            if (value.isNotEmpty) {
              setState(() {
                isSearching = true;
              });
            } else {
              setState(() {
                isSearching = false;
              });
            }
          },
          onSubmitted: (value) async {
            ref.watch(friendServiceProvider).addHistoryFindFriend(value);
            _onTypingFinished(value);
          },
          style: const TextStyle(color: Colors.black),
          cursorColor: Colors.black,
          decoration: InputDecoration(
            hintText: 'Nhập username...',
            hintStyle: const TextStyle(color: Colors.black),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(64.0),
            ),
            contentPadding: const EdgeInsets.all(5.0),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            suffixIcon: IconButton(
              icon: const Icon(
                Icons.clear,
                color: Colors.black,
              ),
              onPressed: () {
                searchController.clear();
                setState(() {
                  isSearching = false;
                });
              },
            ),
          ),
          autofocus: true,
        ),
      ),
      body: LineGradientBackgroundWidget(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                ),
                child: !isSearching
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Lịch sử tìm kiếm',
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                          FutureBuilder(
                            future: ref
                                .watch(friendServiceProvider)
                                .getHistoryFindFriend(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                List<String> listHistory = snapshot.data!;
                                return Column(
                                  children: <Widget>[
                                    for (int i = 0; i < listHistory.length; i++)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 5,
                                        ),
                                        child: Row(
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  isSearching = true;
                                                  searchController.text =
                                                      listHistory[i];
                                                  _onTypingFinished(
                                                      listHistory[i]);
                                                },
                                                child: Text(listHistory[i])),
                                            const Spacer(),
                                            IconButton(
                                              icon: const Icon(Icons.close),
                                              onPressed: () async {
                                                await ref
                                                    .watch(
                                                        friendServiceProvider)
                                                    .deleteHistoryFindFriend(
                                                        listHistory[i]);
                                                setState(() {});
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                );
                              }
                            },
                          ),
                          const SizedBox(height: 5),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Kết quả tìm kiếm',
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              for (int i = 0; i < response.length; i++)
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      UserInfoScreen.routeName,
                                      arguments: response[i].username,
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 5,
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            response[i].urlAvatar,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          response[i].username,
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 5),
                            ],
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
