import 'exercise_detail_model.dart';

abstract class ExerciseDetailState {}

class ExerciseDetailInitial extends ExerciseDetailState {}

class ExerciseDetailLoading extends ExerciseDetailState {}

class ExerciseDetailSuccess extends ExerciseDetailState {
  final List<ExerciseDetailModel> exerciseDetail;

  ExerciseDetailSuccess({required this.exerciseDetail});
}

class ExerciseDetailFailure extends ExerciseDetailState {
  final String message;

  ExerciseDetailFailure({required this.message});
}
