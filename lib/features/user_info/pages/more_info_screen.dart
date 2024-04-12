// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/user_info/providers/user_info_provider.dart';
import 'package:flutter_englearn/features/user_info/widgets/date_of_birth_info_widget.dart';
import 'package:flutter_englearn/features/user_info/widgets/gender_info_widget.dart';
import 'package:flutter_englearn/features/user_info/widgets/normal_info_widget.dart';
import 'package:flutter_englearn/model/request/update_info_request.dart';
import 'package:flutter_englearn/model/response/user_info_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_englearn/utils/widgets/line_gradient_background_widget.dart';
import 'dart:developer';

class MoreUserInfoScreen extends ConsumerStatefulWidget {
  const MoreUserInfoScreen({
    super.key,
    required this.havePermission,
    required this.userInfo,
  });
  static const String routeName = '/more-user-info-screen';

  final bool havePermission;
  final UserInfoResponse userInfo;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MoreUserInfoScreenState();
}

class _MoreUserInfoScreenState extends ConsumerState<MoreUserInfoScreen> {
  late UserInfoResponse userInfo;

  @override
  void initState() {
    super.initState();
    userInfo = widget.userInfo;
  }

  Future<void> updateFullName(String fullName) async {
    log('Update full name', name: 'MoreUserInfoScreen');
    UpdateInfoRequest request = UpdateInfoRequest.fromResponse(userInfo);
    request.fullName = fullName;
    await ref.read(userInfoServiceProvider).updateUserInfo(context, request);
    setState(() {
      userInfo.fullName = fullName;
    });
  }

  Future<void> updateEmail(String email) async {
    log('Update email', name: 'MoreUserInfoScreen');
    UpdateInfoRequest request = UpdateInfoRequest.fromResponse(userInfo);
    request.email = email;
    await ref
        .read(userInfoServiceProvider)
        .addEmail(context, email, userInfo.username);
  }

  Future<void> updateGender(bool value) async {
    log('Update gender', name: 'MoreUserInfoScreen');
    UpdateInfoRequest request = UpdateInfoRequest.fromResponse(userInfo);
    request.gender = value;
    await ref.read(userInfoServiceProvider).updateUserInfo(context, request);
    setState(() {
      userInfo.gender = value;
    });
  }

  Future<void> updateDateOfBirth(DateTime dateOfBirth) async {
    log('Update date of birth', name: 'MoreUserInfoScreen');
    UpdateInfoRequest request = UpdateInfoRequest.fromResponse(userInfo);
    request.dateOfBirth = dateOfBirth;
    await ref.read(userInfoServiceProvider).updateUserInfo(context, request);
    setState(() {
      userInfo.dateOfBirth = dateOfBirth;
    });
  }

  @override
  Widget build(BuildContext context) {
    log('Build more user info screen', name: 'MoreUserInfoScreen');
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
                child: SingleChildScrollView(
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
                        havePermission: widget.havePermission,
                        onChanged: updateFullName,
                      ),
                      NormalInfoAttributeWidget(
                        title: 'Email',
                        value: userInfo.email ?? '',
                        havePermission: widget.havePermission,
                        onChanged: updateEmail,
                      ),
                      DateAttributeWidget(
                        value: userInfo.dateOfBirth,
                        havePermission: widget.havePermission,
                        onChanged: updateDateOfBirth,
                      ),
                      GenderInfoWidget(
                        value: userInfo.gender,
                        havePermission: widget.havePermission,
                        onChanged: updateGender,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
