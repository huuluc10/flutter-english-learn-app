import 'package:flutter/material.dart';
import 'package:flutter_englearn/model/response/dictionary_api_word_response.dart';

class PhoneticsItemWidget extends StatelessWidget {
  const PhoneticsItemWidget({
    super.key,
    required this.word,
  });

  final DictionaryAPIWordResponse? word;

  @override
  Widget build(BuildContext context) {
    return Row(
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
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                (word!.phonetics![index].audio != null &&
                        word!.phonetics![index].audio != "")
                    ? Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              print(
                                  'Play audio: ${word!.phonetics![index].audio}');
                            },
                            icon: const Icon(Icons.volume_up),
                          ),
                          // show country pronunciation
                          Text(
                            word!.phonetics![index].audio!
                                .substring(
                                  word!.phonetics![index].audio!
                                          .lastIndexOf('-') +
                                      1,
                                  word!.phonetics![index].audio!
                                      .lastIndexOf('.'),
                                )
                                .toUpperCase(),
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    : Container(),
                // Sized
                //Box(width: 6),
                if (word!.phonetics![index].text != null)
                  Text(
                    word!.phonetics![index].text!,
                    style: const TextStyle(fontSize: 17),
                  ),
                const SizedBox(width: 5),
              ],
            ),
          ),
        ),
      ],
    );
  }
}