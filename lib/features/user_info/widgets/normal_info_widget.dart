// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class NormalInfoAttributeWidget extends StatefulWidget {
  const NormalInfoAttributeWidget({
    Key? key,
    required this.title,
    required this.value,
    this.havePermission = false,
  }) : super(key: key);

  final String title;
  final String value;
  final bool havePermission;

  @override
  State<NormalInfoAttributeWidget> createState() =>
      _NormalInfoAttributeWidgetState();
}

class _NormalInfoAttributeWidgetState extends State<NormalInfoAttributeWidget> {
  final TextEditingController controller = TextEditingController();
  bool? _isEdit;

  @override
  void initState() {
    super.initState();
    _isEdit = false;
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
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              widget.havePermission
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          _isEdit = !_isEdit!;
                        });
                      },
                      icon: const Icon(
                        Icons.mode_edit_outlined,
                        color: Color.fromARGB(255, 201, 201, 201),
                        size: 30,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          _isEdit!
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.55,
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 5),
                          hintText: widget.title,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _isEdit = !_isEdit!;
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black45),
                      ),
                      icon: const Icon(
                        Icons.done,
                        color: Colors.green,
                        size: 30,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _isEdit = !_isEdit!;
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black45),
                      ),
                      icon: const Icon(
                        Icons.cancel,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                  ],
                )
              : Text(
                  widget.value,
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
