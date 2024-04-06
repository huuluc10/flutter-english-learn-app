import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/auth/provider/auth_provider.dart';
import 'package:flutter_englearn/model/request/sign_up_request.dart';
import 'package:flutter_englearn/utils/helper/helper.dart';
import 'package:flutter_englearn/utils/widgets/line_gradient_background_widget.dart';
import 'package:flutter_englearn/features/auth/widgets/gender_choose_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddingInfoSignUpScreen extends ConsumerStatefulWidget {
  const AddingInfoSignUpScreen({Key? key, required this.signUpRequest})
      : super(key: key);
  static const routeName = '/adding-info-signup-screen';

  final SignUpRequest signUpRequest;

  @override
  ConsumerState<AddingInfoSignUpScreen> createState() =>
      _AddingInfoSignUpScreenState();
}

class _AddingInfoSignUpScreenState
    extends ConsumerState<AddingInfoSignUpScreen> {
  DateTime? _date;
  bool _isMale = true;
  final TextEditingController textController = TextEditingController();

  void signUp() {
    // Check if name and date is not empty
    if (textController.text.isEmpty || _date == null) {
      showSnackBar(context, 'Nhập đầy đủ thông tin!');
      return;
    }

    // Check date of birth > 3 years or in the future
    if (_date!.isAfter(DateTime.now())) {
      showSnackBar(context, "Ngày sinh không hợp lệ!");
      return;
    } else if (DateTime.now().difference(_date!).inDays < 3 * 365) {
      showSnackBar(context, 'Trẻ quá nhỏ để học nhiều!');
      return;
    } else {
      // Call sign up API
      SignUpRequest request = widget.signUpRequest;
      request.fullName = textController.text.trim();
      request.dateOfBirth = _date!;
      request.gender = _isMale;

      ref.watch(authServiceProvicer).signUp(context, request);
    }
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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: LineGradientBackgroundWidget(
        child: SingleChildScrollView(
          reverse: true,
          child: SizedBox(
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
                  TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 233, 224, 224),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                      hintText: 'Họ và tên',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
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
                    onPressed: signUp,
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
