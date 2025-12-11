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

      // Tetap di exercise saat ini saat memproses transcribe & validate
      emit(ExerciseLevelLoading());

      try {
        final filePath = event.filePath;
        print("Bloc menerima file path: $filePath");

        // Transcribe dapatkan spoken_text
        final spokenText = await repository.postAITranscribe(filePath);

        // Ambil instruction & speech_text dari exercise saat ini
        if (currentIndex >= 0 && currentIndex < currentExercises.length) {
          final currentExercise = currentExercises[currentIndex];

          // Validate
          final message = await repository.getAIValidate(
            instruction: currentExercise.instruction,
            speechText: currentExercise.speechText,
            spokenText: spokenText,
          );

          if (message.toLowerCase() == 'complete') {
            emit(ExerciseLevelValidatedSuccess(
              exerciseLevel: currentExercises,
              currentIndex: currentIndex,
              message: message,
            ));
          } else {
            // Dapat feedback, panggil TTS
            String? ttsUrl;
            try {
              ttsUrl = await repository.getAITTS(message: message);
            } catch (_) {
              ttsUrl = null; // tetap tampilkan feedback meski TTS gagal
            }

            emit(ExerciseLevelValidatedFeedback(
              exerciseLevel: currentExercises,
              currentIndex: currentIndex,
              feedbackMessage: message,
              ttsUrl: ttsUrl,
            ));
          }
        } else {
          emit(ExerciseLevelFailure(message: 'Invalid exercise index'));
        }
      } catch (e) {
        emit(ExerciseLevelFailure(message: e.toString()));
      }
    });

    on<ProceedToNextQuizEvent>((event, emit) async {
      try {
        if (state is ExerciseLevelSuccess) {
          final s = state as ExerciseLevelSuccess;
          final nextIndex = s.currentIndex + 1;
          if (nextIndex < s.exerciseLevel.length) {
            emit(ExerciseLevelSuccess(exerciseLevel: s.exerciseLevel, currentIndex: nextIndex));
          } else {
            emit(ExerciseLevelFinished());
          }
        } else if (state is ExerciseLevelValidatedSuccess) {
          final s = state as ExerciseLevelValidatedSuccess;
          final nextIndex = s.currentIndex + 1;
          if (nextIndex < s.exerciseLevel.length) {
            emit(ExerciseLevelSuccess(exerciseLevel: s.exerciseLevel, currentIndex: nextIndex));
          } else {
            emit(ExerciseLevelFinished());
          }
        } else if (state is ExerciseLevelValidatedFeedback) {
          final s = state as ExerciseLevelValidatedFeedback;
          // Jika masih feedback, tetap bisa lanjut jika user menekan tombol lanjut (opsional)
          final nextIndex = s.currentIndex + 1;
          if (nextIndex < s.exerciseLevel.length) {
            emit(ExerciseLevelSuccess(exerciseLevel: s.exerciseLevel, currentIndex: nextIndex));
          } else {
            emit(ExerciseLevelFinished());
          }
        }
      } catch (e) {
        emit(ExerciseLevelFailure(message: e.toString()));
      }
    });
  }
}