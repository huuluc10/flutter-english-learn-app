import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/auth/pages/login_screen.dart';
import 'package:flutter_englearn/utils/widgets/line_gradient_background_widget.dart';
import 'package:flutter_englearn/features/auth/widgets/auth_text_field_widget.dart';
import 'package:flutter_englearn/features/auth/widgets/gender_choose_widget.dart';

class AddingInfoSignUpScreen extends StatefulWidget {
  const AddingInfoSignUpScreen({Key? key}) : super(key: key);
  static const routeName = '/adding-info-signup-screen';

  @override
  State<AddingInfoSignUpScreen> createState() => _AddingInfoSignUpScreenState();
}

class _AddingInfoSignUpScreenState extends State<AddingInfoSignUpScreen> {
  DateTime? _date;
  bool _isMale = true;

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
          _date = index;
        });
      },
      onSubmit: (index) {
        setState(() {
          _date = index;
        });
      },
      bottomPickerTheme: BottomPickerTheme.plumPlate,
    ).show(context);
  }

  void _updateGender(bool isMale) {
    setState(() {
      _isMale = isMale;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: LineGradientBackgroundWidget(
        child: SingleChildScrollView(
          reverse: true,
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Bổ sung thông tin tài khoản mới',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  GenderChooseWidget(
                    isMale: _isMale,
                    onChanged: _updateGender,
                  ),
                  AuthTextField(
                    labelText: 'Họ và tên',
                    isPassword: false,
                    controller: controller,
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Ngày sinh',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          _date == null
                              ? 'Chưa chọn'
                              : '${_date!.day}/${_date!.month}/${_date!.year}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _openDatePicker(context);
                        },
                        icon: const Icon(
                          Icons.calendar_today,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Todo: Check if name and date is not empty
                      // If not empty, call sign up API
                      // If sign up success, navigate to home screen
                      // If sign up fail, show error message
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        LoginScreen.routeName,
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Hoàn tất',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
