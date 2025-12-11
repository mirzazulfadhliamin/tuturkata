import 'package:flutter_bloc/flutter_bloc.dart';
import 'exercise_detail_event.dart';
import 'exercise_detail_repository.dart';
import 'exercise_detail_state.dart';

class ExerciseDetailBloc extends Bloc<ExerciseDetailEvent, ExerciseDetailState> {
  final ExerciseDetailRepository repository;

  ExerciseDetailBloc(this.repository) : super(ExerciseDetailInitial()) {
    on<GetExerciseDetailEvent>((event, emit) async {
      emit(ExerciseDetailLoading());
      try {
        final exerciseDetail = await repository.getExerciseDetail(event.exerciseId);
        emit(ExerciseDetailSuccess(exerciseDetail: exerciseDetail));
      } catch (e) {
        emit(ExerciseDetailFailure(message: e.toString()));
      }
    });
  }
}
