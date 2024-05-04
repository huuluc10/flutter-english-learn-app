import 'package:flutter/material.dart';
import 'package:flutter_englearn/model/explanation_question.dart';
import 'package:flutter_englearn/utils/const/utils.dart';
import 'package:flutter_englearn/utils/widgets/line_gradient_background_widget.dart';

class ExplanationResultScreen extends StatefulWidget {
  const ExplanationResultScreen({
    super.key,
    required this.explanationQuestions,
    required this.typeExercise,
  });

  static const routeName = '/explanation-result-screen';

  @override
  State<ExplanationResultScreen> createState() =>
      _ExplanationResultScreenState();

  final List<ExplanationQuestion> explanationQuestions;
  final String typeExercise;
}

class _ExplanationResultScreenState extends State<ExplanationResultScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lời giải'),
        backgroundColor: const Color.fromARGB(169, 0, 141, 211),
      ),
      body: LineGradientBackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              children: [
                const Text(
                  'Lời giải',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _currentIndex > 0
                        ? SizedBox(
                            width: 50,
                            child: IconButton(
                              onPressed: () {
                                if (_currentIndex > 0) {
                                  setState(() {
                                    _currentIndex--;
                                  });
                                }
                              },
                              icon: const Icon(Icons.arrow_back),
                            ),
                          )
                        : const SizedBox(width: 50),
                    if (widget.typeExercise != TypeQuestion.speaking &&
                        widget.typeExercise != TypeQuestion.listening)
                      SingleChildScrollView(
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.6,
                          child: Column(
                            children: [
                              Text(
                                widget.explanationQuestions[_currentIndex]
                                    .question,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              if (widget.explanationQuestions[_currentIndex]
                                      .questionImage !=
                                  null)
                                Image.network(
                                  widget.explanationQuestions[_currentIndex]
                                      .questionImage!,
                                ),
                              const SizedBox(height: 10),
                              widget.explanationQuestions[_currentIndex]
                                          .answer !=
                                      null
                                  ? Text(
                                      'Đáp án: ${widget.explanationQuestions[_currentIndex].answer}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    )
                                  : Image.network(
                                      widget.explanationQuestions[_currentIndex]
                                          .answerImage!,
                                    ),
                              const SizedBox(height: 10),
                              if (widget.explanationQuestions[_currentIndex]
                                      .explanation !=
                                  null)
                                Text(
                                  'Lời giải: ${widget.explanationQuestions[_currentIndex].explanation}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                            ],
                          ),
                        ),
                      )
                    else if (widget.typeExercise == TypeQuestion.speaking)
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.6,
                        child: Column(
                          children: [
                            const Text(
                              'Bạn cần luyện tập phát âm những từ sau nhiều lần để cải thiện kỹ năng phát âm của mình',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'Từ cần luyện tập: ${widget.explanationQuestions[_currentIndex].answer}',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      )
                    else
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.6,
                        child: Column(
                          children: [
                            const Text(
                              'Bạn cần luyện tập nghe những từ sau nhiều lần để cải thiện kỹ năng nghe của mình',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'Từ cần luyện tập: ${widget.explanationQuestions[_currentIndex].answer}',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                    _currentIndex < widget.explanationQuestions.length - 1
                        ? SizedBox(
                            width: 50,
                            child: IconButton(
                              onPressed: () {
                                if (_currentIndex <
                                    widget.explanationQuestions.length - 1) {
                                  setState(() {
                                    _currentIndex++;
                                  });
                                }
                              },
                              icon: const Icon(Icons.arrow_forward),
                            ),
                          )
                        : const SizedBox(width: 50),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
