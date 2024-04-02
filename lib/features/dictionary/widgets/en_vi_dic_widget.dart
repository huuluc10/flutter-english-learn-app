import 'package:en_vi_dic/en_vi_dic.dart';
import 'package:flutter/material.dart';

class EnViDicWidget extends StatelessWidget {
  const EnViDicWidget({
    super.key,
    required this.vocabulary,
    required this.isSearch,
  });

  final Vocabulary? vocabulary;
  final bool isSearch;

  @override
  Widget build(BuildContext context) {
    return isSearch
        ? vocabulary == null
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
            : Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        vocabulary!.vocabulary,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          'Phát âm: ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          vocabulary!.ipa,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    const Divider(thickness: 2),
                    vocabulary!.details.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Chi tiết:',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              for (Detail detail in vocabulary!.details)
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.only(top: 10),
                                  width: MediaQuery.sizeOf(context).width,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          const Text(
                                            'Loại từ: ',
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            detail.pos,
                                            style: const TextStyle(
                                              fontSize: 17,
                                            ),
                                            softWrap: true,
                                          ),
                                        ],
                                      ),
                                      for (Mean mean in detail.means)
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                const Text(
                                                  'Nghĩa: ',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Flexible(
                                                  child: Text(
                                                    mean.mean,
                                                    style: const TextStyle(
                                                      fontSize: 17,
                                                    ),
                                                    softWrap: true,
                                                    textAlign:
                                                        TextAlign.justify,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                            ],
                          )
                        : Container()
                  ],
                ),
              )
        : Container();
  }
}
