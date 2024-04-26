import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/exercise/controller/exercise_controller.dart';
import 'package:flutter_englearn/features/exercise/widgets/speech_control_widget.dart';
import 'package:flutter_englearn/model/answer.dart';
import 'package:flutter_englearn/model/explanation_question.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeakingWidget extends ConsumerStatefulWidget {
  const SpeakingWidget({
    super.key,
    required this.height,
    required this.questionURL,
    required this.updateCurrentIndex,
    required this.inCreaseCorrectAnswerCount,
    required this.addExplanationQuestion,
  });

  final double height;
  final String questionURL;
  final Function() updateCurrentIndex;
  final Function() inCreaseCorrectAnswerCount;
  final Function(ExplanationQuestion) addExplanationQuestion;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SpeakingWidgetState();
}

class _SpeakingWidgetState extends ConsumerState<SpeakingWidget> {
  bool _hasSpeech = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = '';
  String lastError = '';
  String lastStatus = '';
  final SpeechToText speech = SpeechToText();

  @override
  void initState() {
    super.initState();
    initSpeechState();
  }

  void errorListener(SpeechRecognitionError error) {
    logEvent('Received error status: $error, listening: ${speech.isListening}');
    setState(() {
      lastError = '${error.errorMsg} - ${error.permanent}';
    });
  }

  Future<void> initSpeechState() async {
    logEvent('Initialize');
    try {
      var hasSpeech = await speech.initialize(
        onError: errorListener,
        onStatus: statusListener,
      );
      if (!mounted) return;

      setState(() {
        _hasSpeech = hasSpeech;
      });
    } catch (e) {
      setState(() {
        lastError = 'Speech recognition failed: ${e.toString()}';
        _hasSpeech = false;
      });
    }
  }

  Future<Answer> _fetchAnswer() async {
    return await Future.delayed(
        const Duration(seconds: 0),
        () => Answer(
              question: 'Answer 2',
              answers: [],
              correctAnswer: 'Answer 2',
              explanation:
                  'Explanation Answer 2 Explanation Answer 2.\nExplanation Answer 2 Explanation Answer 2  ',
            ));
  }

  void resultListener(SpeechRecognitionResult result) {
    logEvent(
        'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  void statusListener(String status) {
    logEvent(
        'Received listener status: $status, listening: ${speech.isListening}');
    lastStatus = status;
  }

  void startListening() {
    logEvent('start listening');
    lastWords = '';
    lastError = '';
    final options = SpeechListenOptions(
      listenMode: ListenMode.confirmation,
      cancelOnError: true,
      partialResults: true,
      autoPunctuation: true,
      enableHapticFeedback: true,
    );
    speech.listen(
      onResult: resultListener,
      listenFor: const Duration(seconds: 30),
      pauseFor: const Duration(seconds: 3),
      localeId: 'en_US',
      listenOptions: options,
    );
  }

  void stopListening() {
    logEvent('stop');
    speech.stop();
    setState(() {
      level = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    String? correctAnswer;
    String? explanation;
    return Column(
      children: [
        const Text(
          'Luyện nói tiếng Anh',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: SizedBox(
            height: widget.height * 0.8,
            child: FutureBuilder<Answer>(
                future: _fetchAnswer(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Error'),
                    );
                  }
                  Answer answer = snapshot.data!;
                  correctAnswer = answer.correctAnswer;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 233, 233, 233),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: BoxConstraints(
                          minHeight: 150,
                          maxHeight: widget.height * 0.20,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  answer.question,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.volume_up),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                          left: 10,
                          bottom: 5,
                          right: 10,
                        ),
                        child: SizedBox(
                          height: widget.height * 0.46,
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: Padding(
                              padding: const EdgeInsets.all(14),
                              child: Center(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Expanded(
                                          child: Text(
                                            'Nhấn biểu tượng bên cạnh để nói',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                            textAlign: TextAlign.justify,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 150,
                                          child: SpeechControlWidget(
                                            hasSpeech: _hasSpeech,
                                            isListening: speech.isListening,
                                            startListening: startListening,
                                            stopListening: stopListening,
                                            level: level,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Consumer(
                                            builder: (context, ref, child) {
                                              return RichText(
                                                text: TextSpan(
                                                  text: 'Từ phát âm của bạn: ',
                                                  style: DefaultTextStyle.of(
                                                          context)
                                                      .style,
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text: lastWords,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.volume_up),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (lastWords == '') {
                              // show SnackBar
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Vui lòng nói từ bạn đã nghe',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  backgroundColor:
                                      Color.fromARGB(255, 233, 233, 233),
                                ),
                              );
                            } else {
                              if (lastWords == correctAnswer) {
                                widget.inCreaseCorrectAnswerCount();
                              } else {
                                widget.addExplanationQuestion(
                                  ExplanationQuestion(
                                    question: answer.question,
                                    questionImage: answer.questionImage,
                                    answer: correctAnswer!,
                                    answerImage: answer.correctImage,
                                    explanation: explanation,
                                  ),
                                );
                              }
                              widget.updateCurrentIndex();
                            }
                          },
                          child: const Text('Tiếp tục'),
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ),
      ],
    );
  }
}
