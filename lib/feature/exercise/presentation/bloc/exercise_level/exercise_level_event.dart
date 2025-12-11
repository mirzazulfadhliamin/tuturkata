abstract class ExerciseLevelEvent {}

class GetExerciseLevelEvent extends ExerciseLevelEvent {
  final String levelId;

  GetExerciseLevelEvent({required this.levelId});
}

class PostAITranscribe extends ExerciseLevelEvent {
  final String filePath;

  PostAITranscribe({required this.filePath});
}
