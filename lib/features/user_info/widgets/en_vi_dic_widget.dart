import 'package:en_vi_dic/en_vi_dic.dart';
import 'package:flutter/material.dart';

class EnViDicWidget extends StatefulWidget {
  const EnViDicWidget({
    super.key,
    required this.vocabulary,
    required this.isSearch,
  });

  final Vocabulary? vocabulary;
  final bool isSearch;

  @override
  State<EnViDicWidget> createState() => _EnViDicWidgetState();
}

class _EnViDicWidgetState extends State<EnViDicWidget> {
  @override
  Widget build(BuildContext context) {
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
                        widget.vocabulary!.vocabulary,
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
                          widget.vocabulary!.ipa,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    const Divider(thickness: 2),
                    widget.vocabulary!.details.isNotEmpty
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
                              for (Detail detail in widget.vocabulary!.details)
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.only(top: 10),
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
                                              // fontFamily: 'Roboto',
                                            ),
                                          ),
                                          Text(
                                            detail.pos,
                                            style: const TextStyle(
                                              fontSize: 17,
                                            ),
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
                                                    // fontFamily: 'Roboto',
                                                  ),
                                                ),
                                                Text(
                                                  mean.mean,
                                                  style: const TextStyle(
                                                    fontSize: 17,
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
