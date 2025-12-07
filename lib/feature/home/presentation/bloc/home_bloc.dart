import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadHomeData>((event, emit) async {
      emit(HomeLoading());
      await Future.delayed(const Duration(seconds: 2)); // Simulasi loading
      emit(const HomeLoaded(
        streakDays: 8,
        totalXP: 1240,
        completedSessions: 32,
        accuracy: 86,
        completedDailyMissions: 1,
        totalDailyMissions: 3,
        weeklyChallengeProgress: 14,
        weeklyChallengeTotal: 20,
        daysLeftInWeek: 3,
      ));
    });
  }
}