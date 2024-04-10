import 'package:flutter_englearn/features/learn/repository/learn_repository.dart';
import 'package:flutter_englearn/model/response/lesson_response.dart';
import 'package:flutter_englearn/model/result_return.dart';

class LearnService {
  final LearnRepository learnRepository;

  LearnService({required this.learnRepository});

  Future<List<LessonResponse>> getListLessonOfTopic(String topicId) async {
    ResultReturn resultReturn =
        await learnRepository.getListLessonOfTopic(topicId);
    List<LessonResponse> listLessonResponse =
        resultReturn.data as List<LessonResponse>;
    return listLessonResponse;
  }
}
