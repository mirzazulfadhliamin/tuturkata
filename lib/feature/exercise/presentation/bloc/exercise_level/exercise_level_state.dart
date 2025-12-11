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

class ExerciseLevelValidatedSuccess extends ExerciseLevelState {
  final List<ExerciseLevelModel> exerciseLevel;
  final int currentIndex;
  final String message; // expected "complete"

  ExerciseLevelValidatedSuccess({
    required this.exerciseLevel,
    required this.currentIndex,
    required this.message,
  });
}

class ExerciseLevelValidatedFeedback extends ExerciseLevelState {
  final List<ExerciseLevelModel> exerciseLevel;
  final int currentIndex;
  final String feedbackMessage;
  final String? ttsUrl;

  ExerciseLevelValidatedFeedback({
    required this.exerciseLevel,
    required this.currentIndex,
    required this.feedbackMessage,
    this.ttsUrl,
  });
}
