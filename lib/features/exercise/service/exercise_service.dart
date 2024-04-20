import 'package:flutter_englearn/features/exercise/repository/exercise.repository.dart';
import 'package:flutter_englearn/model/answer.dart';
import 'package:flutter_englearn/model/response/question_response.dart';
import 'package:flutter_englearn/model/result_return.dart';
import 'package:flutter_englearn/utils/helper/helper.dart';

class ExerciseService {
  final ExerciseRepository exerciseRepository;

  ExerciseService({required this.exerciseRepository});

  Future<List<QuestionResponse>> getListMultipleChoiceQuestion(
      int lessonId) async {
    ResultReturn result =
        await exerciseRepository.getListMultipleChoiceQuestion(lessonId);

    List<QuestionResponse> list = result.data;
    list.shuffle();
    return list;
  }

  Future<Answer> getAnswer(String filePath) async {
    String url = transformLocalURLMediaToURL(filePath);
    ResultReturn result = await exerciseRepository.getAnswer(url);
    Answer answer = result.data;
    return answer;
  }
}
