import 'package:flutter/material.dart';

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
