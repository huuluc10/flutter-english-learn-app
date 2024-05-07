import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/auth/provider/auth_provider.dart';
import 'package:flutter_englearn/model/request/sign_up_request.dart';
import 'package:flutter_englearn/common/utils/helper/helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> signUp(
  BuildContext context,
  WidgetRef ref,
  SignUpRequest request,
  String fullname,
  DateTime? dateOfBirth,
  bool gender,
) async {
  // Check if name and date is not empty
  if (fullname.isEmpty || dateOfBirth == null) {
    showSnackBar(context, 'Nhập đầy đủ thông tin!');
    return;
  }

  // Check date of birth > 3 years or in the future
  if (dateOfBirth.isAfter(DateTime.now())) {
    showSnackBar(context, "Ngày sinh không hợp lệ!");
    return;
  } else if (DateTime.now().difference(dateOfBirth).inDays < 3 * 365) {
    showSnackBar(context, 'Trẻ quá nhỏ để học nhiều!');
    return;
  } else {
    // Call sign up API
    SignUpRequest signUpRequest = request;
    signUpRequest.fullName = fullname;
    signUpRequest.dateOfBirth = dateOfBirth;
    signUpRequest.gender = gender;

    await ref.watch(authServiceProvicer).signUp(context, signUpRequest);
  }
}

Future<void> login(BuildContext context, WidgetRef ref, String username,
    String password) async {
  // Check if username and password is not empty
  if (username.isEmpty || password.isEmpty) {
    showSnackBar(context, "Nhập đây đủ thông tin tài khoản và mật khẩu!");
  } else if (isHTML(username) || isHTML(password)) {
    showSnackBar(context, "Vui lòng không chèn ký tự đặc biệt!");
  } else {
    // Call login API
    ref.watch(authServiceProvicer).login(
          context,
          username,
          password,
        );
  }
}

Future<void> createResetPassword(
  BuildContext context,
  WidgetRef ref,
  String email,
) async {
  const String regrexEmail = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

  if (email.isNotEmpty) {
    //check valid email
    if (RegExp(regrexEmail).hasMatch(email)) {
      await ref.watch(authServiceProvicer).resetPassword(context, email);
    } else {
      showSnackBar(context, 'Email không hợp lệ');
    }
  }
}

Future<void> resetPassword(BuildContext context, WidgetRef ref, String email, String password, String confirmPassword) async {
      if (password.isEmpty || confirmPassword.isEmpty) {
        showSnackBar(context, 'Vui lòng nhập đầy đủ thông tin');
        return;
      }
      if (password != confirmPassword) {
        showSnackBar(context, 'Mật khẩu không trùng khớp');
        return;
      }
      await ref
          .watch(authServiceProvicer)
          .changeResetPassword(context, email, password);
    }

void openDatePicker(BuildContext context, Function(dynamic) onDone) {
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
      onDone(index);
    },
    onSubmit: (index) {
      onDone(index);
    },
    bottomPickerTheme: BottomPickerTheme.plumPlate,
  ).show(context);
}
