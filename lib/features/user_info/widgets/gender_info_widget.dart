import 'package:flutter/material.dart';

class GenderInfoWidget extends StatefulWidget {
  final bool value;
  final bool havePermission;

  const GenderInfoWidget(
      {super.key, required this.value, required this.havePermission});

  @override
  State<GenderInfoWidget> createState() => _GenderWidgetState();
}

class _GenderWidgetState extends State<GenderInfoWidget> {
  bool _isEdit = false;
  bool? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

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
                    _isEdit = !_isEdit;
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
          _isEdit
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
                          _value = _value == false ? true : false;
                          _isEdit = !_isEdit;
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
