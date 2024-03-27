import 'package:flutter/material.dart';
import 'package:flutter_englearn/model/explanation_question.dart';
import 'package:flutter_englearn/utils/widgets/line_gradient_background_widget.dart';

class ExplanationResultScreen extends StatefulWidget {
  const ExplanationResultScreen(
      {super.key, required this.explanationQuestions});

  static const routeName = '/explanation-result-screen';

  @override
  State<ExplanationResultScreen> createState() =>
      _ExplanationResultScreenState();

  final List<ExplanationQuestion> explanationQuestions;
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
                    IconButton(
                      onPressed: () {
                        if (_currentIndex > 0) {
                          setState(() {
                            _currentIndex--;
                          });
                        }
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    SingleChildScrollView(
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.6,
                        child: Column(
                          children: [
                            Text(
                              widget
                                  .explanationQuestions[_currentIndex].question,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Đáp án: ${widget.explanationQuestions[_currentIndex].answer}',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 10),
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
                    ),
                    IconButton(
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
