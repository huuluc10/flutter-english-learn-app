import 'package:flutter/material.dart';

class GenderInfoWidget extends StatefulWidget {
  int value;
  bool isEdit;

  GenderInfoWidget({super.key, required this.value, this.isEdit = false});

  @override
  _GenderWidgetState createState() => _GenderWidgetState();
}

class _GenderWidgetState extends State<GenderInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: <Widget>[
              const Text(
                'Giới tính',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () {
                  setState(() {
                    widget.isEdit = !widget.isEdit;
                  });
                },
                icon: const Icon(
                  Icons.mode_edit_outlined,
                  color: Color.fromARGB(255, 201, 201, 201),
                  size: 30,
                ),
              ),
            ],
          ),
          widget.isEdit
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.value == 0 ? 'Nữ' : 'Nam',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 209, 209, 209),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          widget.value = widget.value == 0 ? 1 : 0;
                          widget.isEdit = !widget.isEdit;
                        });
                      },
                      icon: const Icon(
                        Icons.change_circle_outlined,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                )
              : Text(
                  widget.value == 0 ? 'Nữ' : 'Nam',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 209, 209, 209),
                  ),
                ),
        ],
      ),
    );
  }
}
