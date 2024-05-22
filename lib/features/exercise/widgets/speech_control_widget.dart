import 'package:flutter/material.dart';

/// Controls to start and stop speech recognition
class SpeechControlWidget extends StatefulWidget {
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
  State<SpeechControlWidget> createState() => _SpeechControlWidgetState();
}

class _SpeechControlWidgetState extends State<SpeechControlWidget> {
  bool isListening = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Expanded(
          child: Text(
            'Nhấn biểu tượng bên cạnh để nói',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(width: 10),
        SizedBox(
          width: 150,
          child: Row(
            children: [
              GestureDetector(
                onLongPress: () {
                  if (!widget.hasSpeech || widget.isListening) {
                    return;
                  }
                  setState(() {
                    isListening = true;
                    widget.startListening();
                  });
                },
                onLongPressEnd: (details) {
                  if (widget.isListening) {
                    setState(() {
                      isListening = false;
                      widget.stopListening();
                    });
                  }
                },
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      height: 60,
                      width: 60,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: 60,
                        height: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: .26,
                              spreadRadius: widget.level * 1.5,
                              color: Colors.black.withOpacity(.1),
                            )
                          ],
                          color: Colors.blueAccent,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                        ),
                        child: const Icon(Icons.mic),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              isListening
                  ? const CircularProgressIndicator()
                  : const SizedBox(
                      width: 10,
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
