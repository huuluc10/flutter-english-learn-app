import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/mission/providers/mission_providers.dart';
import 'package:flutter_englearn/model/response/mission_response.dart';
import 'package:flutter_englearn/common/widgets/future_builder_error_widget.dart';
import 'package:flutter_englearn/common/widgets/line_gradient_background_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MissionScreen extends ConsumerWidget {
  const MissionScreen({super.key});

  static const String routeName = '/mission-screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nhiệm vụ hằng ngày'),
        backgroundColor: const Color.fromARGB(169, 0, 141, 211),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Danh sách nhiệm vụ hằng ngày',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    FutureBuilder(
                      future: ref
                          .watch(missionServiceProvider)
                          .getMissionList(context),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          if (snapshot.hasError) {
                            return FutureBuilderErrorWidget(
                              error: snapshot.error.toString(),
                            );
                          } else {
                            final listMission =
                                snapshot.data as List<MissionResponse>;
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: listMission.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                    listMission[index].missionName,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: RichText(
                                    text: TextSpan(
                                      text: listMission[index].missionContent,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                '\nKinh nghiệm đạt được: ${listMission[index].missionExperience}',
                                            style: const TextStyle(
                                              color: Colors.green,
                                            )),
                                      ],
                                    ),
                                  ),
                                  trailing: listMission[index].isDone
                                      ? const SizedBox(
                                          width: 50,
                                          child: Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          ),
                                        )
                                      : Container(width: 0),
                                );
                              },
                            );
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 5),
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
