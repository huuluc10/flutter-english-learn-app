import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/homepage/provider/homepage_provider.dart';
import 'package:flutter_englearn/model/response/main_user_info_request.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LeaderboardScreen extends ConsumerStatefulWidget {
  const LeaderboardScreen({super.key});

  static const String routeName = '/leaderboard-screen';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LeaderboardScreenState();
}

class _LeaderboardScreenState extends ConsumerState<LeaderboardScreen> {
  List<MainUserInfoResponse> listLeaderboard = [];

  Future<List<MainUserInfoResponse>> fetchLeaderboard() async {
    listLeaderboard =
        await ref.read(homepageServiceProvider).fetchLeaderboard(context);
    return listLeaderboard;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        title: const Text('Bảng xếp hạng'),
        backgroundColor: Colors.blue[200],
      ),
      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        edgeOffset: 10,
        displacement: 200,
        strokeWidth: 2,
        color: Colors.blue,
        backgroundColor: const Color(0x00f9f9fa),
        onRefresh: () async {
          listLeaderboard =
              await ref.read(homepageServiceProvider).fetchLeaderboard(context);
        },
        child: FutureBuilder<List<MainUserInfoResponse>>(
          future: fetchLeaderboard(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                children: [
                  Container(
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32.0),
                        topRight: Radius.circular(32.0),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Top ${listLeaderboard.length} người cấp ${listLeaderboard[0].level}',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: ListView.builder(
                        itemCount: listLeaderboard.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: SizedBox(
                              width: 60,
                              height: 60,
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: listLeaderboard[index].urlAvatar,
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            title: Text(
                              listLeaderboard[index].username,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            subtitle: Row(
                              children: [
                                Image.asset(
                                  'assets/fire.png',
                                  width: 20,
                                  height: 20,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  listLeaderboard[index].streak.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            trailing: SizedBox(
                              width: 80,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    'assets/experience.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(listLeaderboard[index]
                                      .experience
                                      .toString()),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
