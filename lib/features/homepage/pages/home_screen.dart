import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/homepage/controller/homepage_controller.dart';
import 'package:flutter_englearn/features/homepage/widgets/drawer_home_widget.dart';
import 'package:flutter_englearn/features/homepage/widgets/topic_widget.dart';
import 'package:flutter_englearn/features/learn/pages/topic_details_screen.dart';
import 'package:flutter_englearn/utils/widgets/bottom_navigate_bar_widget.dart';
import 'package:flutter_englearn/utils/service/control_index_navigate_bar.dart';
import 'package:flutter_englearn/utils/widgets/line_gradient_background_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../model/response/history_learn_topic_response.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = '/home-screen';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final searchController = TextEditingController();
  Future<List<HistoryLearnTopicResponse>>? _listTopicFuture;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_listTopicFuture == null) {
      _listTopicFuture = getListTopic(context, ref);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get index of bottom navigation bar
    final indexBottomNavbar = ref.watch(indexBottomNavbarProvider);
    // Get current time
    final currentTime = DateTime.now();

    // Get width of screen
    String image = "assets/light.png";
    String welcome = "Chào buổi sáng,";
    if (currentTime.hour < 12) {
      // Good morning
    } else if (currentTime.hour < 18) {
      // Good afternoon
      welcome = "Chào buổi chiều,";
    } else {
      // Good evening
      welcome = "Chào buổi tối,";
      image = "assets/night.png";
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      // extendBody: false,
      appBar: AppBar(
        title: const Text('EngLearn'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: LineGradientBackgroundWidget(
        child: Stack(
          children: [
            Positioned(
              top: -55,
              right: -55,
              child: CircleAvatar(
                radius: 100,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage(image),
              ),
            ),
            Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      welcome,
                      style: const TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    const Text(
                      'Tiếp tục quá trình học nào!',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    TextField(
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Tìm kiếm',
                        prefixIcon: const Icon(Icons.search),
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 165,
              left: 7,
              right: 7,
              child: Column(
                children: [
                  FutureBuilder<List<HistoryLearnTopicResponse>>(
                    future: _listTopicFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<HistoryLearnTopicResponse> listTopic =
                            snapshot.data!;
                        // Filter the list based on the search term
                        listTopic = listTopic
                            .where((topic) => topic.topicName
                                .toLowerCase()
                                .contains(searchController.text.trim()))
                            .toList();
                        return SingleChildScrollView(
                          child: SizedBox(
                            height: MediaQuery.sizeOf(context).height - 265,
                            child: MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              child: GridView.count(
                                crossAxisCount: 2,
                                mainAxisSpacing: 7,
                                crossAxisSpacing: 7,
                                childAspectRatio: 0.44 / 0.5,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                children: List.generate(
                                  listTopic.length,
                                  (index) => InkWell(
                                    onTap: () => Navigator.pushNamed(
                                        context, TopicDetailsScreen.routeName,
                                        arguments: [
                                          listTopic[index],
                                          () {
                                            setState(() {});
                                          }
                                        ]),
                                    child: TopicWidget(
                                      nameTopic:
                                          'Topic ${listTopic[index].topicId}: ${listTopic[index].topicName}',
                                      percent: listTopic[index].successRate,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: const DrawerWidget(),
      bottomNavigationBar: BottomNavigateBarWidget(index: indexBottomNavbar),
    );
  }
}
