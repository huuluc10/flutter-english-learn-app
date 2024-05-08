import 'package:flutter_englearn/features/auth/provider/auth_provider.dart';
import 'package:flutter_englearn/features/chat/repository/chat_repository.dart';
import 'package:flutter_englearn/features/chat/service/chat_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return ChatRepository(authRepository: authRepository);
});

final chatServiceProvider = Provider<ChatService>((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatService(chatRepository: chatRepository);
});
