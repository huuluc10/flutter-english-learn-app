import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:developer';

class SpeakingQuestionTextWidget extends StatefulWidget {
  const SpeakingQuestionTextWidget({
    super.key,
    required this.height,
    required this.questionHaveImage,
    required this.question,
    required this.pronounce,
    required this.imageUrl,
  });

  final double height;
  final bool questionHaveImage;
  final String question;
  final String? pronounce;
  final String? imageUrl;

  @override
  State<SpeakingQuestionTextWidget> createState() =>
      _SpeakingQuestionTextWidgetState();
}

class _SpeakingQuestionTextWidgetState
    extends State<SpeakingQuestionTextWidget> {
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    initializeTts();
  }

  Future<void> initializeTts() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine == null) {
      return;
    }

    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.6);
    await flutterTts.setVolume(1);
    await flutterTts.setPitch(1);

    flutterTts.setStartHandler(() {
      log("Playing");
    });
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 233, 233, 233),
        borderRadius: BorderRadius.circular(10),
      ),
      constraints: BoxConstraints(
        minHeight: 120,
        maxHeight: widget.height * 0.20,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: !widget.questionHaveImage
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.question,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          widget.pronounce!,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            await flutterTts.speak(widget.pronounce!);
                          },
                          icon: const Icon(Icons.volume_up),
                        ),
                      ],
                    ),
                  ],
                )
              : Column(
                  children: [
                    Text(
                      widget.question,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CachedNetworkImage(
                      imageUrl: widget.imageUrl!,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
