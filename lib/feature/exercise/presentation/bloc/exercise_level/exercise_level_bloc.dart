import 'package:flutter_bloc/flutter_bloc.dart';
import 'exercise_level_event.dart';
import 'exercise_level_repository.dart';
import 'exercise_level_state.dart';
import 'exercise_level_model.dart';

class ExerciseLevelBloc extends Bloc<ExerciseLevelEvent, ExerciseLevelState> {
  final ExerciseLevelRepository repository;

  ExerciseLevelBloc(this.repository) : super(ExerciseLevelInitial()) {
    on<GetExerciseLevelEvent>((event, emit) async {
      emit(ExerciseLevelLoading());
      try {
        final exerciseLevel = await repository.getUserExerciseLevel(event.levelId);
        emit(ExerciseLevelSuccess(exerciseLevel: exerciseLevel, currentIndex: 0));
      } catch (e) {
        emit(ExerciseLevelFailure(message: e.toString()));
      }
    });

    on<PostAITranscribe>((event, emit) async {
      List<ExerciseLevelModel> currentExercises = [];
      int currentIndex = 0;

      if (state is ExerciseLevelSuccess) {
        currentExercises = (state as ExerciseLevelSuccess).exerciseLevel;
        currentIndex = (state as ExerciseLevelSuccess).currentIndex;
      }

      emit(ExerciseLevelLoading());

      try {
        final filePath = event.filePath;
        print("Bloc menerima file path: $filePath");

        await repository.postAITranscribe(filePath);

        if (currentIndex < currentExercises.length - 1) {
          emit(ExerciseLevelSuccess(
              exerciseLevel: currentExercises,
              currentIndex: currentIndex + 1
          ));
        } else {
          print("Latihan Selesai!");
          emit(ExerciseLevelFinished());
        }

      } catch (e) {
        emit(ExerciseLevelFailure(message: e.toString()));
      }
    });
  }
}