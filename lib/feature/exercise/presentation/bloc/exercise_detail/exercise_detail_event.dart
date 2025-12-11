abstract class ExerciseDetailEvent {}

class GetExerciseDetailEvent extends ExerciseDetailEvent {
  final String exerciseId;

  GetExerciseDetailEvent({required this.exerciseId});
}
