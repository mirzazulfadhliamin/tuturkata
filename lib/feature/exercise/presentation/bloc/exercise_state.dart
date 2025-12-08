// exercise_state.dart
import 'exercise_model.dart';

class ExerciseState {
  final List<ExerciseModel> exercises;

  ExerciseState({required this.exercises});

  factory ExerciseState.initial() {
    return ExerciseState(exercises: []);
  }
}