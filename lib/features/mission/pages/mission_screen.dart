import 'package:flutter/material.dart';
import 'package:flutter_englearn/utils/widgets/line_gradient_background_widget.dart';
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
        child: Container(),
      ),
    );
  }
}
