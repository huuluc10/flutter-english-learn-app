import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/auth/controller/auth_controller.dart';
import 'package:flutter_englearn/model/request/sign_up_request.dart';
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
                          openDatePicker(context, (index) {
                            setState(() {
                              _date = index;
                            });
                          });
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
                    onPressed: () async {
                      await signUp(
                        context,
                        ref,
                        widget.signUpRequest,
                        textController.text.trim(),
                        _date,
                        _isMale,
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
