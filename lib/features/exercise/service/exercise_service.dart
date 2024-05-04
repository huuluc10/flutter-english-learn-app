import 'package:flutter_englearn/features/exercise/repository/exercise_repository.dart';
import 'package:flutter_englearn/model/answer.dart';
import 'package:flutter_englearn/model/response/exam_response.dart';
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

  Future<List<QuestionResponse>> getListFillInBlankQuestion(
      int lessonId) async {
    ResultReturn result =
        await exerciseRepository.getListFillQuestion(lessonId);

    List<QuestionResponse> list = result.data;
    list.shuffle();
    return list;
  }

  Future<List<QuestionResponse>> getListSentenceUnscrambleQuestion(
      int lessonId) async {
    ResultReturn result =
        await exerciseRepository.getListSentenceUnscrambleQuestion(lessonId);

    List<QuestionResponse> list = result.data;
    list.shuffle();
    return list;
  }

  Future<Answer> getAnswer(String filePath) async {
    ResultReturn result = await exerciseRepository.getAnswer(filePath);
    Answer answer = result.data;
    if (answer.answers != null) {
      answer.answers!.shuffle();
    }
    return answer;
  }

  Future<List<QuestionResponse>> getListSentenceTransformationQuestion(
      int lessonId) async {
    ResultReturn result = await exerciseRepository
        .getListSentenceTransformationQuestion(lessonId);

    List<QuestionResponse> list = result.data;
    list.shuffle();
    return list;
  }

  Future<List<QuestionResponse>> getListSpeakingQuestion(int lessonId) async {
    ResultReturn result =
        await exerciseRepository.getListSpeakingQuestion(lessonId);

    List<QuestionResponse> list = result.data;
    list.shuffle();
    return list;
  }

  Future<List<QuestionResponse>> getListListeningQuestion(int lessonId) async {
    ResultReturn result =
        await exerciseRepository.getListListeningQuestion(lessonId);

    List<QuestionResponse> list = result.data;
    list.shuffle();
    return list;
  }

  Future<List<ExamResponse>> getListExam(int topicId) async {
    ResultReturn result = await exerciseRepository.getListExam(topicId);

    List<ExamResponse> list = result.data;
    return list;
  }

  Future<List<QuestionResponse>> getExamQuestion(int examId) async {
    ResultReturn result = await exerciseRepository.getExamDetail(examId);

    List<QuestionResponse> list = result.data;
    list.shuffle();
    return list;
  }

  Future<String> getQuestionType(int questionTypeId) async {
    ResultReturn result =
        await exerciseRepository.getNameOfQuestionType(questionTypeId);

    return result.data;
  }
}
