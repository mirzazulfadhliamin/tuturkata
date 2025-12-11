import 'exercise_model.dart';

abstract class ExerciseState {}

class ExerciseInitial extends ExerciseState {}

class ExerciseLoading extends ExerciseState {}

class ExerciseSuccess extends ExerciseState {
  final List<ExerciseModel> exercise;

  ExerciseSuccess({required this.exercise});
}

class ExerciseFailure extends ExerciseState {
  final String message;

  ExerciseFailure({required this.message});
}
