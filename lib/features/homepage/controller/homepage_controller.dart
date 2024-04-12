import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/homepage/provider/homepage_provider.dart';
import 'package:flutter_englearn/model/response/history_learn_topic_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<List<HistoryLearnTopicResponse>> getListTopic(BuildContext context, WidgetRef ref) async {
      final List<HistoryLearnTopicResponse> listTopic =
          await ref.watch(homepageServiceProvider).fetchTopic(context);

      return Future.value(listTopic);
    }