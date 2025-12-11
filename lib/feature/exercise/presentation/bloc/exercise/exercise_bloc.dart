import 'package:flutter_bloc/flutter_bloc.dart';
import 'exercise_event.dart';
import 'exercise_repository.dart';
import 'exercise_state.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  final ExerciseRepository repository;

  ExerciseBloc(this.repository) : super(ExerciseInitial()) {
    on<GetUserExercisesEvent>((event, emit) async {
      emit(ExerciseLoading());
      try {
        final exercise = await repository.getUserExercises();
        emit(ExerciseSuccess(exercise: exercise));
      } catch (e) {
        emit(ExerciseFailure(message: e.toString()));
      }
    });
  }
}
