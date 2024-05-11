import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/auth/provider/auth_provider.dart';
import 'package:flutter_englearn/features/user_info/providers/user_info_provider.dart';
import 'package:flutter_englearn/common/widgets/line_gradient_background_widget.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OTPInputScreen extends ConsumerWidget {
  const OTPInputScreen({
    super.key,
    required this.email,
    required this.iSResetPassword,
    required this.username,
  });

  static const String routeName = '/otp_input_screen';

  final String email;
  final bool iSResetPassword;
  final String? username;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: LineGradientBackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Image(
                    image: AssetImage('assets/password.png'), width: 180),
                const SizedBox(height: 5),
                const Text(
                  'Nhập mã OTP',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Mã OTP đã được gửi đến email của bạn. Vui lòng kiểm tra và nhập mã OTP",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Mã OTP sẽ hết hạn sau 5 phút",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 20),
                OtpTextField(
                  filled: true,
                  numberOfFields: 6,
                  borderColor: const Color.fromARGB(255, 72, 0, 241),
                  // disabledBorderColor: Colors.black,
                  enabledBorderColor: Colors.black,
                  //set to true to show as box or false to show as dash
                  showFieldAsBox: true,
                  //runs when a code is typed in
                  onCodeChanged: (String code) {
                    //handle validation or checks here
                  },
                  //runs when every textfield is filled
                  onSubmit: (String verificationCode) {
                    iSResetPassword
                        ? ref.read(authServiceProvicer).verifyOTPResetPass(
                              context,
                              email,
                              verificationCode,
                            )
                        : ref.read(userInfoServiceProvider).verifyCodeAddEmail(
                              context,
                              email,
                              verificationCode,
                              username!,
                            );
                  }, // end onSubmit
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
