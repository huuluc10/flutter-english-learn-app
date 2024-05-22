import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/exercise/controller/exercise_controller.dart';
import 'package:flutter_englearn/features/exercise/provider/exercise_provider.dart';
import 'package:flutter_englearn/features/exercise/widgets/speaking_question_text_widget.dart';
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
    required this.questionId,
    required this.questionURL,
    required this.updateCurrentIndex,
    required this.inCreaseCorrectAnswerCount,
    required this.addExplanationQuestion,
    required this.makeFor,
  });

  final double height;
  final int questionId;
  final String questionURL;
  final Function() updateCurrentIndex;
  final Function() inCreaseCorrectAnswerCount;
  final Function(ExplanationQuestion) addExplanationQuestion;
  final String makeFor;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SpeakingWidgetState();
}

class _SpeakingWidgetState extends ConsumerState<SpeakingWidget> {
  bool _hasSpeech = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String pronounce = '';
  String lastError = '';
  String lastStatus = '';
  final SpeechToText speech = SpeechToText();

  Answer? _answer;

  Future<Answer> _fetchAnswer() async {
    if (_answer == null) {
      _answer = await ref
          .watch(exerciseServiceProvider)
          .getAnswer(widget.questionURL);
      return _answer!;
    } else {
      return _answer!;
    }
  }

  @override
  void initState() {
    super.initState();
    initSpeechState();
  }

  void errorListener(SpeechRecognitionError error) {
    logEvent('Received error status: $error, listening: ${speech.isListening}');
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

  void resultListener(SpeechRecognitionResult result) {
    logEvent(
        'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
    setState(() {
      pronounce = result.recognizedWords;
    });
  }

  void statusListener(String status) {
    logEvent(
        'Received listener status: $status, listening: ${speech.isListening}');
    lastStatus = status;
  }

  void startListening() {
    logEvent('start listening');
    pronounce = '';
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

                  bool haveImage = !answer.question.contains('\n');
                  String question = answer.question;
                  String? wordQuestion;

                  if (!haveImage) {
                    List<String> questions = question.split('\n');
                    question = questions[0];
                    wordQuestion = questions[1];
                  }

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SpeakingQuestionTextWidget(
                        height: widget.height,
                        questionHaveImage: haveImage,
                        question: question,
                        pronounce: wordQuestion,
                        imageUrl: answer.questionImage,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SpeechControlWidget(
                                      hasSpeech: _hasSpeech,
                                      isListening: speech.isListening,
                                      startListening: startListening,
                                      stopListening: stopListening,
                                      level: level,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Từ phát âm của bạn: ',
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: pronounce,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
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
                            changeSpeakingQuestion(
                              context,
                              ref,
                              widget.questionId,
                              widget.makeFor,
                              pronounce,
                              widget.inCreaseCorrectAnswerCount,
                              widget.addExplanationQuestion,
                              widget.updateCurrentIndex,
                              answer,
                            );
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
