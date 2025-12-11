import 'exercise_level_model.dart';

abstract class ExerciseLevelState {}

class ExerciseLevelInitial extends ExerciseLevelState {}

class ExerciseLevelLoading extends ExerciseLevelState {}

class ExerciseLevelSuccess extends ExerciseLevelState {
  final List<ExerciseLevelModel> exerciseLevel;
  final int currentIndex;

  ExerciseLevelSuccess({
    required this.exerciseLevel,
    this.currentIndex = 0
  });

  @override
  List<Object> get props => [exerciseLevel, currentIndex];
}

class ExerciseLevelFailure extends ExerciseLevelState {
  final String message;

  ExerciseLevelFailure({required this.message});
}

class ExerciseLevelFinished extends ExerciseLevelState {}
