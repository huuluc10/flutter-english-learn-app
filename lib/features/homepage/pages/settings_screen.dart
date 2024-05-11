import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/auth/provider/auth_provider.dart';
import 'package:flutter_englearn/features/homepage/pages/about_screen.dart';
import 'package:flutter_englearn/features/user_info/pages/change_password_screen.dart';
import 'package:flutter_englearn/common/widgets/line_gradient_background_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static const String routeName = '/settings-screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Cài đặt'),
        backgroundColor: Colors.transparent,
      ),
      body: LineGradientBackgroundWidget(
        child: Stack(
          children: [
            Opacity(
              opacity: 0.2,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Color.fromARGB(169, 194, 194, 194),
                      Color.fromARGB(169, 238, 238, 238),
                    ],
                    tileMode: TileMode.mirror,
                  ),
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
            Column(
              children: <Widget>[
                const SizedBox(height: 65),
                ButtonSettingScreenWidget(
                  onPressed: () {
                    // Todo: Implement sign out
                    // Call API to sign out
                    // Get status code
                    // * Important: If status code is 200, then sign out successfully by delete token and user info in local storage then navigate to welcome
                    // If status code is 401, then token is expired
                    Navigator.pushNamed(
                      context,
                      ChangePasswordScreen.routeName,
                    );
                  },
                  text: 'Đổi mật khẩu',
                ),
                ButtonSettingScreenWidget(
                  onPressed: () {
                    ref.watch(authServiceProvicer).logout(context);
                  },
                  text: 'Đăng xuất',
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 14,
                  ),
                  child: Divider(
                    color: Colors.white,
                    height: 2,
                  ),
                ),
                ButtonSettingScreenWidget(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AboutScreen.routeName,
                    );
                  },
                  text: 'Về chúng tôi',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonSettingScreenWidget extends StatelessWidget {
  const ButtonSettingScreenWidget({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              Colors.grey[200]!,
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(64.0),
              ),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
