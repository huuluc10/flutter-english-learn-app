import 'package:flutter/material.dart';

/// Controls to start and stop speech recognition
class SpeechControlWidget extends StatelessWidget {
  const SpeechControlWidget({
    Key? key,
    required this.hasSpeech,
    required this.isListening,
    required this.startListening,
    required this.stopListening,
    required this.level,
  }) : super(key: key);

  final bool hasSpeech;
  final bool isListening;
  final void Function() startListening;
  final void Function() stopListening;
  final double level;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onLongPress: !hasSpeech || isListening ? null : startListening,
          onLongPressEnd: (details) {
            isListening ? stopListening : null;
          },
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                height: 40,
                width: 40,
              ),
              Positioned.fill(
                bottom: 10,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: .26,
                            spreadRadius: level * 1.5,
                            color: Colors.black.withOpacity(.05))
                      ],
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                    ),
                    child: const Icon(Icons.mic),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          color: Theme.of(context).colorScheme.background,
          child: Center(
            child: isListening
                ? SizedBox(
                    width: 50,
                    child: const Text(
                      "Đang nghe...",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                : SizedBox(
                    width: 50,
                  ),
          ),
        )
      ],
    );
  }
}
