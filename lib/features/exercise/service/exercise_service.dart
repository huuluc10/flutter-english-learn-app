import 'package:flutter_englearn/features/exercise/repository/exercise.repository.dart';
import 'package:flutter_englearn/model/answer.dart';
import 'package:flutter_englearn/model/response/question_response.dart';
import 'package:flutter_englearn/model/result_return.dart';

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
    ResultReturn result = await exerciseRepository.getAnswer(filePath);
    Answer answer = result.data;
    return answer;
  }
}
