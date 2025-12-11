import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
      final data = await repository.getWeeklySummary();

      emit(HomeLoaded(
        streakDays: data["streak"] ?? 0,
        totalXP: data["exp"] ?? 0,
        completedSessions: data["exercise_total"] ?? 0,
        accuracy: data["accuration"] ?? 0,

        // UI kamu butuh ini, tapi API tidak punya.
        // Jadi kita isi default agar UI tetap jalan.
        completedDailyMissions: 0,
        totalDailyMissions: 0,
        weeklyChallengeProgress: 0,
        weeklyChallengeTotal: 0,
        daysLeftInWeek: 0,
      ));

    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }
}
