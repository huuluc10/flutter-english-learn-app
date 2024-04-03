import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/auth/provider/auth_provider.dart';
import 'package:flutter_englearn/features/user_info/providers/user_info_provider.dart';
import 'package:flutter_englearn/model/request/change_password_request.dart';
import 'package:flutter_englearn/utils/helper/helper.dart';
import 'package:flutter_englearn/utils/widgets/line_gradient_background_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangePasswordScreen extends ConsumerWidget {
  const ChangePasswordScreen({super.key});

  static const String routeName = '/change-password-screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController oldPasswordController = TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    void changePassword(
        BuildContext context, String oldPassword, String newPasswword) async {
      ChangePasswordRequest request = ChangePasswordRequest(
        username: '',
        oldPassword: oldPassword,
        newPassword: newPasswword,
      );
      int resultChangePassword =
          await ref.read(userInfoServiceProvider).changePassword(request);

      if (resultChangePassword == 401) {
        if (!context.mounted) {
          return;
        }
        showSnackBar(context, 'Phiên đăng nhập đã hết hạn');
        await ref.read(authServiceProvicer).logout(context);
      } else if (resultChangePassword == 400) {
        if (!context.mounted) {
          return;
        }
        showSnackBar(context, 'Đổi mật khẩu thất bại');
      } else {
        if (!context.mounted) {
          return;
        }
        showSnackBar(context, 'Đổi mật khẩu thành công');
      }
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Đổi mật khẩu'),
        backgroundColor: Colors.transparent,
      ),
      body: LineGradientBackgroundWidget(
        child: SizedBox(
          width: double.infinity,
          child: Container(
            height: 325,
            margin: const EdgeInsets.only(
              top: 55,
              left: 14,
              right: 14,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.black54.withOpacity(0.5),
            ),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 25),
                TextField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  controller: oldPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Mật khẩu cũ',
                    labelStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    focusColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  controller: newPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Mật khẩu mới',
                    labelStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    focusColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Nhập lại mật khẩu mới',
                    labelStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    focusColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (oldPasswordController.text.isEmpty ||
                        newPasswordController.text.isEmpty ||
                        confirmPasswordController.text.isEmpty) {
                      showSnackBar(context, 'Vui lòng điền đầy đủ thông tin');
                    } else if (newPasswordController.text.trim() !=
                        confirmPasswordController.text.trim()) {
                      showSnackBar(context, 'Mật khẩu không khớp');
                    } else {
                      changePassword(
                        context,
                        oldPasswordController.text,
                        newPasswordController.text,
                      );
                    }
                  },
                  child: const Text('Xác nhận'),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
