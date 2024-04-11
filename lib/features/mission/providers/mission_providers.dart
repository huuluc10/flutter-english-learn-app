import 'package:flutter_englearn/features/auth/provider/auth_provider.dart';
import 'package:flutter_englearn/features/mission/repository/mission_repository.dart';
import 'package:flutter_englearn/features/mission/service/mission_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final missionRepositoryProvider = Provider<MissionRepository>((ref) {
  return MissionRepository(authRepository: ref.read(authRepositoryProvider));
});

final missionServiceProvider = Provider<MissionService>((ref) {
  return MissionService(missionRepository: ref.read(missionRepositoryProvider));
});
