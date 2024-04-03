// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/user_info/widgets/date_of_birth_info_widget.dart';
import 'package:flutter_englearn/features/user_info/widgets/gender_info_widget.dart';
import 'package:flutter_englearn/features/user_info/widgets/normal_info_widget.dart';
import 'package:flutter_englearn/model/response/user_info_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_englearn/utils/widgets/line_gradient_background_widget.dart';

class MoreUserInfoScreen extends ConsumerWidget {
  const MoreUserInfoScreen({
    super.key,
    required this.havePermission,
    required this.userInfo,
  });
  static const String routeName = '/more-user-info-screen';

  final bool havePermission;
  final UserInfoResponse userInfo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      body: LineGradientBackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 40,
          ),
          child: Container(
            height: MediaQuery.sizeOf(context).height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.black54,
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Row(
                      children: <Widget>[
                        Text(
                          'Thông tin cá nhân',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.info,
                          color: Colors.white,
                        ),
                      ],
                    ),
                     NormalInfoAttributeWidget(
                      title: 'Họ và tên',
                      value: userInfo.fullName,
                      havePermission: havePermission,
                    ),
                    NormalInfoAttributeWidget(
                      title: 'Email',
                      value: userInfo.email ?? '',
                      havePermission: havePermission,
                    ),
                    DateAttributeWidget(
                      value: userInfo.dateOfBirth,
                      havePermission: havePermission,
                    ),
                     GenderInfoWidget(
                      value: userInfo.gender,
                      havePermission: havePermission,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
