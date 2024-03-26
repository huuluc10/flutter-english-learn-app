import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MultichoiceQuestionScreen extends ConsumerStatefulWidget {
  const MultichoiceQuestionScreen({
    super.key,
    required this.lessonId,
  });

  static const String routeName = '/multichoice-question-screen';

  final int lessonId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MultichoiceQuestionScreenState();
}

class _MultichoiceQuestionScreenState
    extends ConsumerState<MultichoiceQuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
