import 'package:flutter_englearn/features/auth/provider/auth_provider.dart';
import 'package:flutter_englearn/features/auth/repository/auth_repository.dart';
import 'package:flutter_englearn/features/friend/repository/friend_repository.dart';
import 'package:flutter_englearn/features/friend/service/friend_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final friendRepositoryProvider = Provider((ref) {
  AuthRepository authRepository = ref.read(authRepositoryProvider);
  return FriendRepository(authRepository: authRepository);
});

final friendServiceProvider = Provider((ref) {
  FriendRepository friendRepository = ref.read(friendRepositoryProvider);
  return FriendService(friendRepository: friendRepository);
});
