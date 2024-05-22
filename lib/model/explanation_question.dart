// ignore_for_file: public_member_api_docs, sort_constructors_first
class ExplanationQuestion {
  String question;
  String? questionImage;
  String? answer;
  String? answerImage;
  String? selectedAnswer;
  String? selectedAnswerImage;
  String? explanation;
  bool isCorrect;

  ExplanationQuestion({
    required this.question,
    required this.questionImage,
    required this.answer,
    required this.answerImage,
    required this.selectedAnswer,
    required this.selectedAnswerImage,
    required this.explanation,
    required this.isCorrect,
  });
}
