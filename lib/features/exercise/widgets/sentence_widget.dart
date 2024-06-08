import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/exercise/controller/exercise_controller.dart';
import 'package:flutter_englearn/features/exercise/provider/exercise_provider.dart';
import 'package:flutter_englearn/features/exercise/widgets/sentence_answer_select_widget.dart';
import 'package:flutter_englearn/features/exercise/widgets/sentence_word_widget.dart';
import 'package:flutter_englearn/model/answer.dart';
import 'package:flutter_englearn/model/explanation_question.dart';
import 'package:flutter_englearn/common/widgets/future_builder_error_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_grid/responsive_grid.dart';

class SentenceWidget extends ConsumerStatefulWidget {
  const SentenceWidget({
    super.key,
    required this.isUnscrambl,
    required this.height,
    required this.questionId,
    required this.questionURL,
    required this.updateCurrentIndex,
    required this.inCreaseCorrectAnswerCount,
    required this.addExplanationQuestion,
    required this.makeFor,
  });

  final bool isUnscrambl;
  final double height;
  final int questionId;
  final String questionURL;
  final Function() updateCurrentIndex;
  final Function() inCreaseCorrectAnswerCount;
  final Function(ExplanationQuestion) addExplanationQuestion;
  final String makeFor;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SentenceWidgetState();
}

class _SentenceWidgetState extends ConsumerState<SentenceWidget> {
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

  void changeQuestion(Answer answer) async {
    String stringAnswer = listWordIsChosen.join(' ');

    int correctAnswerStreak = ref.watch(userProgressProvider);

    if (stringAnswer == answer.correctAnswer) {
      ref.read(userProgressProvider.notifier).state = correctAnswerStreak + 1;
      await saveAnswerQuestion(
        context,
        ref,
        widget.questionId,
        widget.makeFor,
        true,
      );
      widget.inCreaseCorrectAnswerCount();
    } else {
      ref.read(userProgressProvider.notifier).state = 0;
      await saveAnswerQuestion(
        context,
        ref,
        widget.questionId,
        widget.makeFor,
        false,
      );
    }
    widget.addExplanationQuestion(
      ExplanationQuestion(
        question: answer.question,
        questionImage: answer.questionImage,
        answer: answer.correctAnswer,
        answerImage: answer.correctImage,
        selectedAnswer: stringAnswer,
        selectedAnswerImage: null,
        explanation: answer.explanation,
        isCorrect: stringAnswer == answer.correctAnswer,
      ),
    );
    _answer = null;
    listWordIsChosen.clear();
    wordsAnswer.clear();

    widget.updateCurrentIndex();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });

    correctAnswerStreak = ref.watch(userProgressProvider);

    if (correctAnswerStreak % 5 == 0) {
      showCorrectAnswerStreakPopup(context, correctAnswerStreak);
    }
  }

  List<String> wordsAnswer = [];

  List<String> listWordIsChosen = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Sắp xếp từ để tạo thành câu đúng nghĩa',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: SizedBox(
            height: widget.height * 0.75,
            child: FutureBuilder<Answer>(
                future: _fetchAnswer(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return FutureBuilderErrorWidget(
                      error: snapshot.error.toString(),
                    );
                  }
                  Answer answer = snapshot.data!;
                  if (wordsAnswer.isEmpty && listWordIsChosen.isEmpty) {
                    wordsAnswer = widget.isUnscrambl
                        ? getWordsUnscramble(answer.question)
                        : getWordsTransform(answer.correctAnswer!);
                  }
                  // for (String word in listWordIsChosen) {
                  //   int index = wordsAnswer.indexOf(word);
                  //   if (index > -1) {
                  //     wordsAnswer.removeAt(index);
                  //   }
                  // }

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
                          minHeight: 120,
                          maxHeight: widget.height * 0.33,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  answer.question,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Row(
                                  children: [
                                    Text(
                                      'Câu trả lời: ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: ResponsiveGridList(
                                    desiredItemWidth:
                                        MediaQuery.of(context).size.width *
                                            0.25,
                                    minSpacing: 10,
                                    children: List.generate(
                                      listWordIsChosen.length,
                                      (index) {
                                        String word = listWordIsChosen[index];
                                        return SentenceAnswerSelectWidget(
                                          word: word,
                                          onTap: (value) {
                                            int indexValueIsChosen =
                                                listWordIsChosen.indexOf(value);
                                            listWordIsChosen
                                                .removeAt(indexValueIsChosen);
                                            wordsAnswer.add(value);
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) {
                                              setState(() {});
                                            });
                                          },
                                        );
                                      },
                                    ),
                                  ),
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
                          height: widget.height * 0.28,
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ResponsiveGridList(
                              desiredItemWidth:
                                  MediaQuery.of(context).size.width * 0.25,
                              minSpacing: 8,
                              children: List.of(
                                wordsAnswer.map(
                                  (e) {
                                    return InkWell(
                                      onTap: () {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          setState(() {
                                            listWordIsChosen.add(e);
                                            wordsAnswer.remove(e);
                                          });
                                        });
                                      },
                                      child: SentenceWordWidget(text: e),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            changeQuestion(answer);
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
