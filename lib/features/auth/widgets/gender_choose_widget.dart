import 'package:flutter/material.dart';

class GenderChooseWidget extends StatefulWidget {
  final bool isMale;
  final ValueChanged<bool> onChanged;

  const GenderChooseWidget(
      {super.key, required this.isMale, required this.onChanged});

  @override
  State<GenderChooseWidget> createState() => _GenderChooseWidgetState();
}

class _GenderChooseWidgetState extends State<GenderChooseWidget> {
  bool? _isMale;

  @override
  void initState() {
    super.initState();
    _isMale = widget.isMale;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isMale = !_isMale!;
                widget.onChanged(_isMale!);
              });
            },
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: widget.isMale
                          ? const Color.fromARGB(255, 0, 140, 255)
                          : Colors.transparent,
                      width: 5,
                    ),
                  ),
                  child: const Image(
                      image: AssetImage("assets/male.jpg"),
                      width: 120,
                      height: 120),
                ),
                const Text('Nam')
              ],
            ),
          ),
          const SizedBox(width: 40),
          GestureDetector(
            onTap: () {
              setState(() {
                _isMale = !_isMale!;
                widget.onChanged(_isMale!);
              });
            },
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: widget.isMale
                          ? Colors.transparent
                          : const Color.fromARGB(255, 0, 140, 255),
                      width: 5,
                    ),
                  ),
                  child: const Image(
                      image: AssetImage("assets/female.jpg"),
                      width: 120,
                      height: 120),
                ),
                const Text('Nữ'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
