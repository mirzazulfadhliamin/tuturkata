import 'exercise_model.dart';

abstract class ExerciseState {}

class ExerciseInitial extends ExerciseState {}

class ExerciseLoading extends ExerciseState {}

class ExerciseSuccess extends ExerciseState {
  final List<ExerciseModel> exercises;

  ExerciseSuccess({
    required this.exercises
  });
}

class ExerciseFailure extends ExerciseState {
  final String message;

  ExerciseFailure({
    required this.message
  });
}
