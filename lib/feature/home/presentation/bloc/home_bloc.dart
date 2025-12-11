import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/daily_mission_model.dart';
import 'home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;

  HomeBloc(this.repository) : super(HomeInitial()) {
    on<LoadHomeData>(_onLoadData);
  }

  Future<void> _onLoadData(
      LoadHomeData event,
      Emitter<HomeState> emit,
      ) async {
    emit(HomeLoading());

    try {
      final summary = await repository.getWeeklySummary();
      final missions = await repository.getDailyMissions();
      final nextLevel = await repository.getNextLevel();

      emit(HomeLoaded(
        streakDays: summary["streak"] ?? 0,
        totalXP: summary["exp"] ?? 0,
        completedSessions: summary["exercise_total"] ?? 0,
        accuracy: summary["accuration"] ?? 0,
        missions: missions,
        subtitleNextLevel: nextLevel.title,
        nextLevelId: nextLevel.levelId,
        nextExerciseId: nextLevel.exerciseId,
      ));

    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }
}
