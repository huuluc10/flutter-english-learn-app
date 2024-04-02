import 'package:flutter/material.dart';
import 'package:flutter_englearn/model/response/dictionary_api_word_response.dart';
import 'package:flutter_englearn/utils/helper/helper.dart';

class MeaningDictionaryWidget extends StatelessWidget {
  const MeaningDictionaryWidget({
    super.key,
    required this.word,
  });

  final DictionaryAPIWordResponse? word;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SingleChildScrollView(
        // Wrap with SingleChildScrollView
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            const Text(
              'Meanings:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: word!.meanings!.length,
              itemBuilder: (context, index) {
                final meaning = word!.meanings![index];
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Text(
                        meaning.partOfSpeech.toCapitalized(),
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: meaning.definitions.length,
                          itemBuilder: (context, index) {
                            final definition = meaning.definitions[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 5),
                                Text(
                                  '- ${definition.definition}',
                                  style: const TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                                if (definition.example != null)
                                  Text(
                                    'Example: ${definition.example}',
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                if (meaning.synonyms != null &&
                                    meaning.synonyms!.isNotEmpty)
                                  Text(
                                    'Synonyms: ${meaning.synonyms!.join(', ')}',
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                if (meaning.antonyms != null &&
                                    meaning.antonyms!.isNotEmpty)
                                  Text(
                                    'Antonyms: ${meaning.antonyms!.join(', ')}',
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                      if (meaning.synonyms != null &&
                          meaning.synonyms!.isNotEmpty) ...[
                        const Divider(),
                        RichText(
                          text: TextSpan(
                            text: 'Synonyms: ',
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: meaning.synonyms!.join(', '),
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      if (meaning.antonyms != null &&
                          meaning.antonyms!.isNotEmpty) ...[
                        const Divider(),
                        RichText(
                          text: TextSpan(
                            text: 'Antonyms: ',
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                            ),
                            children: [
                              TextSpan(
                                text: meaning.antonyms!.join(', '),
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
