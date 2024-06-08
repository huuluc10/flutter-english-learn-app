import 'package:flutter_englearn/features/auth/provider/auth_provider.dart';
import 'package:flutter_englearn/features/exercise/repository/exercise_repository.dart';
import 'package:flutter_englearn/features/exercise/service/exercise_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final exerciseRepositoryProvider = Provider.autoDispose<ExerciseRepository>((ref) {
  return ExerciseRepository(authRepository: ref.read(authRepositoryProvider));
});

final exerciseServiceProvider = Provider.autoDispose((ref) {
  return ExerciseService(
      exerciseRepository: ref.read(exerciseRepositoryProvider));
});

class UserProgress extends StateNotifier<int> {
  UserProgress() : super(0);

  int get correctAnswersInARow => state;

  void incrementCorrectAnswers() {
    state++;
  }

  void resetCorrectAnswers() {
    state = 0;
  }


  bool get fiveConsecutiveCorrectAnswers => correctAnswersInARow >= 5;
}

final userProgressProvider = StateNotifierProvider<UserProgress, int>((ref) => UserProgress());
