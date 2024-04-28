import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/exercise/controller/exercise_controller.dart';
import 'package:flutter_englearn/features/exercise/provider/exercise_provider.dart';
import 'package:flutter_englearn/features/exercise/widgets/sentence_answer_select_widget.dart';
import 'package:flutter_englearn/features/exercise/widgets/sentence_word_widget.dart';
import 'package:flutter_englearn/model/answer.dart';
import 'package:flutter_englearn/model/explanation_question.dart';
import 'package:flutter_englearn/utils/helper/helper.dart';
import 'package:flutter_englearn/utils/widgets/future_builder_error_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SentenceWidget extends ConsumerStatefulWidget {
  const SentenceWidget({
    super.key,
    required this.isUnscrambl,
    required this.height,
    required this.questionURL,
    required this.updateCurrentIndex,
    required this.inCreaseCorrectAnswerCount,
    required this.addExplanationQuestion,
  });

  final bool isUnscrambl;
  final double height;
  final String questionURL;
  final Function() updateCurrentIndex;
  final Function() inCreaseCorrectAnswerCount;
  final Function(ExplanationQuestion) addExplanationQuestion;

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
                  if (wordsAnswer.isEmpty) {
                    wordsAnswer = widget.isUnscrambl
                        ? getWordsUnscramble(answer.question)
                        : getWordsTransform(answer.correctAnswer!);
                  }
                  for (String word in listWordIsChosen) {
                    wordsAnswer.remove(word);
                  }

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
                                  child: GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 5,
                                      mainAxisSpacing: 5,
                                      childAspectRatio: 2,
                                    ),
                                    itemCount: listWordIsChosen.length,
                                    itemBuilder: (context, index) {
                                      String word = listWordIsChosen[index];
                                      return SentenceAnswerSelectWidget(
                                        word: word,
                                        onTap: (value) {
                                          listWordIsChosen.remove(value);
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
                            child: GridView.count(
                              crossAxisCount: 3,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              childAspectRatio: 3,
                              children: List.of(
                                wordsAnswer.map(
                                  (e) {
                                    return InkWell(
                                      onTap: () {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          setState(() {
                                            listWordIsChosen.add(e);
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
                          onPressed: () {
                            _answer = null;
                            String stringAnswer = listWordIsChosen.join(' ');
                            if (wordsAnswer.isEmpty) {
                              if (wordsAnswer.isEmpty &&
                                  stringAnswer.length ==
                                      answer.correctAnswer!.length) {
                                if (stringAnswer == answer.correctAnswer) {
                                  widget.inCreaseCorrectAnswerCount();
                                } else {
                                  widget.addExplanationQuestion(
                                    ExplanationQuestion(
                                      question: answer.question,
                                      questionImage: answer.questionImage,
                                      answer: answer.correctAnswer,
                                      answerImage: answer.correctImage,
                                      explanation: answer.explanation,
                                    ),
                                  );
                                }
                                widget.updateCurrentIndex();
                                listWordIsChosen.clear();
                                setState(() {});
                              }
                            } else {
                              showSnackBar(
                                  context, 'Vui lòng hoàn thành câu trả lời');
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
