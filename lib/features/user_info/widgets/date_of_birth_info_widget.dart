import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateAttributeWidget extends StatefulWidget {
  const DateAttributeWidget({
    Key? key,
    required this.value,
    required this.havePermission,
    required this.onChanged,
  }) : super(key: key);

  final DateTime value;
  final bool havePermission;
  final Function(DateTime) onChanged;

  @override
  State<DateAttributeWidget> createState() => _DateAttributeWidgetState();
}

class _DateAttributeWidgetState extends State<DateAttributeWidget> {
  DateTime? _value;
  bool _isEdit = false;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  void _openDatePicker(BuildContext context) {
    BottomPicker.date(
      title: 'Chọn ngày sinh',
      dateOrder: DatePickerDateOrder.dmy,
      pickerTextStyle: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      titleStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Colors.blue,
      ),
      buttonContent: const Center(
        child: Text(
          'Xong',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
      onChange: (index) {
        setState(() {
          _value = index;
          if (_value != null) {
            widget.onChanged(_value!);
          }
        });
      },
      onSubmit: (index) {
        setState(() {
          _value = index;
          if (_value != null) {
            widget.onChanged(_value!);
          }
        });
      },
      bottomPickerTheme: BottomPickerTheme.plumPlate,
    ).show(context);
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
                'Ngày sinh',
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
          widget.havePermission
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${widget.value.day}/${widget.value.month}/${widget.value.year}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 209, 209, 209),
                      ),
                    ),
                    _isEdit
                        ? IconButton(
                            onPressed: () {
                              _openDatePicker(context);
                            },
                            icon: const Icon(
                              Icons.calendar_today,
                              color: Colors.blue,
                            ),
                          )
                        : Container(),
                  ],
                )
              : Text(
                  '${widget.value.day}/${widget.value.month}/${widget.value.year}',
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
