import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/dictionary/widgets/dictionary_api_number_pagination_widget.dart';
import 'package:flutter_englearn/features/dictionary/widgets/meaning_dictionary_widget.dart';
import 'package:flutter_englearn/features/dictionary/widgets/phonetics_dictionary_widget.dart';
import 'package:flutter_englearn/model/response/dictionary_api_word_response.dart';

class APIDictionaryWidget extends StatefulWidget {
  const APIDictionaryWidget({
    super.key,
    required this.vocabulary,
    required this.isSearch,
    required this.height,
  });

  final List<DictionaryAPIWordResponse>? vocabulary;
  final bool isSearch;
  final double height;

  @override
  State<APIDictionaryWidget> createState() => _APIDictionaryWidgetState();
}

class _APIDictionaryWidgetState extends State<APIDictionaryWidget> {
  int currentIndex = 0;
  DictionaryAPIWordResponse? word;
  @override
  Widget build(BuildContext context) {
    if (widget.vocabulary != null) {
      if (widget.vocabulary!.isNotEmpty) {
        word = widget.vocabulary![currentIndex];
      }
    }

    if (widget.isSearch) {
      return word == null
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 50),
                  Text(
                    'Từ này không có trong từ điển hoặc từ không hợp lệ!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : SizedBox(
              height: widget.height,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),
                child: Stack(
                  children: [
                    SizedBox(
                      height: widget.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              word!.word,
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Divider(),
                          if (word!.phonetic != null)
                            Row(
                              children: [
                                const Text(
                                  'Phonetic: ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  word!.phonetic!,
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                          if (word!.phonetics != null ||
                              word!.phonetics!.isNotEmpty) ...[
                            PhoneticsItemWidget(word: word),
                          ],
                          if (word!.meanings != null) ...[
                            const SizedBox(height: 10),
                            MeaningDictionaryWidget(word: word),
                          ],
                          widget.vocabulary!.length > 1
                              ? const SizedBox(height: 50)
                              : const SizedBox(),
                        ],
                      ),
                    ),
                    NumberDictionaryDetailsPagination(
                      length: widget.vocabulary!.length,
                      currentIndex: currentIndex,
                      onTap: (index) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    ),
                  ],
                ),
              ),
            );
    } else {
      return Container();
    }
  }
}
