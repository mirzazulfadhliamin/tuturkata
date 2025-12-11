part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final int streakDays;
  final int totalXP;
  final int completedSessions;
  final int accuracy;

  final List<DailyMission> missions;

  const HomeLoaded({
    required this.streakDays,
    required this.totalXP,
    required this.completedSessions,
    required this.accuracy,
    required this.missions,
  });

  @override
  List<Object> get props => [
    streakDays,
    totalXP,
    completedSessions,
    accuracy,
    missions,
  ];
}

class HomeFailure extends HomeState {
  final String message;
  const HomeFailure(this.message);

  @override
  List<Object> get props => [message];
}

