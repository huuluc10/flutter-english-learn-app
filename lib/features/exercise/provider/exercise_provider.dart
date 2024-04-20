import 'package:flutter_englearn/features/auth/provider/auth_provider.dart';
import 'package:flutter_englearn/features/exercise/repository/exercise.repository.dart';
import 'package:flutter_englearn/features/exercise/service/exercise_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final exerciseRepositoryProvider = Provider<ExerciseRepository>((ref) {
  return ExerciseRepository(authRepository: ref.read(authRepositoryProvider));
});

final exerciseServiceProvider = Provider.autoDispose((ref) {
  return ExerciseService(
      exerciseRepository: ref.read(exerciseRepositoryProvider));
});
