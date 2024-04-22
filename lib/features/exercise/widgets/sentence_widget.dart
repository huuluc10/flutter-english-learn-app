import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/exercise/provider/exercise_provider.dart';
import 'package:flutter_englearn/model/answer.dart';
import 'package:flutter_englearn/model/explanation_question.dart';
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
  Future<Answer> _fetchAnswer() async {
    return await ref
        .watch(exerciseServiceProvider)
        .getAnswer(widget.questionURL);
  }

  List<String> getWordsTransform(String sentence) {
    List<String> words = sentence.split(' ');
    words.shuffle();
    return sentence.split(' ');
  }

  List<String> getWordsUnscramble(String sentence) {
    List<String> words = sentence.split('/');
    return words;
  }

  ValueNotifier<List<String>> listWordIsChosen =
      ValueNotifier<List<String>>([]);

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
            child: ValueListenableBuilder<List<String>>(
              valueListenable: listWordIsChosen,
              builder: (context, value, child) => FutureBuilder<Answer>(
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
                    List<String> words = widget.isUnscrambl
                        ? getWordsUnscramble(answer.question)
                        : getWordsTransform(answer.correctAnswer!);
                    // Remove word is chosen
                    for (String word in value) {
                      words.remove(word);
                    }

                    if (words.isEmpty) {
                      // Concat list word is chosen to create answer
                      String stringAnswer = value.join(' ');
                      if (stringAnswer == answer.correctAnswer) {
                        widget.inCreaseCorrectAnswerCount();
                        value.clear();
                      } else {
                        widget.addExplanationQuestion(
                          ExplanationQuestion(
                            question: answer.question,
                            answer: answer.correctAnswer,
                            answerImage: answer.correctImage,
                            explanation: answer.explanation,
                          ),
                        );
                      }
                      widget.updateCurrentIndex();
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
                            maxHeight: widget.height * 0.35,
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
                                      itemCount: value.length,
                                      itemBuilder: (context, index) {
                                        String word = value[index];
                                        return InkWell(
                                          onTap: () {
                                            words.add(word);
                                            List<String> newValue =
                                                List.from(value);
                                            newValue.remove(word);
                                            listWordIsChosen.value = newValue;
                                          },
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(left: 3),
                                            padding: const EdgeInsets.all(3),
                                            height: 80, // Add this
                                            width: 80,
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Center(
                                              child: Text(
                                                word,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ),
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
                            height: widget.height * 0.30,
                            child: MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              child: GridView.count(
                                crossAxisCount: 3,
                                childAspectRatio: 3,
                                children: List.of(
                                  words.map(
                                    (e) {
                                      return InkWell(
                                        onTap: () {
                                          words.remove(e);
                                          List<String> newValue =
                                              List.from(listWordIsChosen.value);
                                          newValue.add(e);
                                          listWordIsChosen.value = newValue;
                                        },
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(left: 5),
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                            child: Text(
                                              e,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
        ),
      ],
    );
  }
}
