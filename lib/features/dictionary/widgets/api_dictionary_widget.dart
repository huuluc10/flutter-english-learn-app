import 'package:flutter/material.dart';
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
      word = widget.vocabulary![currentIndex];
    }

    return widget.isSearch
        ? widget.vocabulary == null
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                          if (word!.phonetics != null) ...[
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Phonetics: ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Column(
                                  children: List.generate(
                                    word!.phonetics!.length,
                                    (index) => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        if (word!.phonetics![index].text !=
                                            null)
                                          Text(
                                            word!.phonetics![index].text!,
                                            style:
                                                const TextStyle(fontSize: 17),
                                          ),
                                        const SizedBox(width: 5),
                                        (word!.phonetics![index].audio !=
                                                    null &&
                                                word!.phonetics![index].audio !=
                                                    "")
                                            ? IconButton(
                                                onPressed: () {
                                                  print(
                                                      'Play audio: ${word!.phonetics![index].audio}');
                                                },
                                                icon:
                                                    const Icon(Icons.volume_up),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
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
                      // if (widget.vocabulary!.length > 1)
                      //   Positioned(
                      //     bottom: 0,
                      //     left: 0,
                      //     right: 0,
                      //     child: SingleChildScrollView(
                      //       scrollDirection: Axis.horizontal,
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: List.generate(
                      //           widget.vocabulary!.length,
                      //           (index) => ElevatedButton(
                      //             onPressed: () {
                      //               setState(() {
                      //                 currentIndex = index;
                      //               });
                      //             },
                      //             style: ButtonStyle(
                      //               backgroundColor: MaterialStateProperty.all(
                      //                 index == currentIndex
                      //                     ? Colors.blue
                      //                     : const Color.fromARGB(
                      //                         255,
                      //                         238,
                      //                         238,
                      //                         238,
                      //                       ),
                      //               ),
                      //               shape: MaterialStateProperty.all(
                      //                 const CircleBorder(
                      //                   side: BorderSide(
                      //                     color: Colors.blue,
                      //                     width: 1,
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             child: Text(
                      //               (index + 1).toString(),
                      //               style: const TextStyle(
                      //                 color: Colors.black,
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // Container(),
                    ],
                  ),
                ),
              )
        : Container();
  }
}

class NumberDictionaryDetailsPagination extends StatefulWidget {
  const NumberDictionaryDetailsPagination({
    super.key,
    required this.length,
    required this.currentIndex,
    required this.onTap,
  });

  final int length;
  final int currentIndex;
  final Function(int) onTap;

  @override
  State<NumberDictionaryDetailsPagination> createState() =>
      _NumberDictionaryDetailsPaginationState();
}

class _NumberDictionaryDetailsPaginationState
    extends State<NumberDictionaryDetailsPagination> {
  @override
  Widget build(BuildContext context) {
    return widget.length > 1
        ? Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.length,
                  (index) => ElevatedButton(
                    onPressed: () {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        widget.onTap(index);
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        index == widget.currentIndex
                            ? Colors.blue
                            : const Color.fromARGB(
                                255,
                                238,
                                238,
                                238,
                              ),
                      ),
                      shape: MaterialStateProperty.all(
                        const CircleBorder(
                          side: BorderSide(
                            color: Colors.blue,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    child: Text(
                      (index + 1).toString(),
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        : Container();
  }
}
