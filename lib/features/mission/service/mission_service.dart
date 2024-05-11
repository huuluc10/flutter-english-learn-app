import 'package:flutter/cupertino.dart';
import 'package:flutter_englearn/features/auth/pages/welcome_screen.dart';
import 'package:flutter_englearn/features/mission/repository/mission_repository.dart';
import 'package:flutter_englearn/model/response/mission_response.dart';
import 'package:flutter_englearn/common/helper/helper.dart';

class MissionService {
  final MissionRepository missionRepository;

  MissionService({required this.missionRepository});

  Future<List<MissionResponse>> getMissionList(BuildContext context) async {
    final result = await missionRepository.getMissionList();
    if (result.httpStatusCode == 401) {
      showSnackBar(
          context, "Phiên đăng nhập đã hết hạn, vui lòng đăng nhập lại");
      Navigator.pushNamedAndRemoveUntil(
          context, WelcomeScreen.routeName, (route) => false);
    } else if (result.httpStatusCode == 400) {
      showSnackBar(context, 'Lấy danh sách nhiệm vụ hằng ngày thất bại');
      return [];
    }
    return result.data as List<MissionResponse>;
  }
}
