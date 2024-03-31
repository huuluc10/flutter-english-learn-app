import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/dictionary/providers/control_source_dictionary.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonChooseSourceDictionary extends ConsumerWidget {
  const ButtonChooseSourceDictionary({
    super.key,
    required this.sourceDictionaryName,
    required this.from,
  });

  final String sourceDictionaryName;
  final ControlSourceDictionary from;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onSourceDictionaryChanged(ControlSourceDictionary value) {
      ref.read(controlSourceDictionary.notifier).update((state) => value);
    }

    //Get source dictionary
    final sourceDictionary = ref.watch(controlSourceDictionary);

    return ElevatedButton(
      onPressed: () {
        onSourceDictionaryChanged(from);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            sourceDictionary == from ? Colors.white : Colors.grey[300],
      ),
      child: Text(
        sourceDictionaryName,
        textAlign: TextAlign.center,
        style: sourceDictionary == from
            ? const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              )
            : const TextStyle(
                color: Colors.black, // Change this to a visible color
                fontWeight: FontWeight.normal,
              ),
      ),
    );
  }
}
