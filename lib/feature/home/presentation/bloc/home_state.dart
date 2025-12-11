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

  final String subtitleNextLevel;
  final String nextLevelId;
  final String nextExerciseId;

  const HomeLoaded({
    required this.streakDays,
    required this.totalXP,
    required this.completedSessions,
    required this.accuracy,
    required this.missions,
    required this.subtitleNextLevel,
    required this.nextLevelId,
    required this.nextExerciseId,
  });
  @override
  List<Object> get props => [
    streakDays,
    totalXP,
    completedSessions,
    accuracy,
    missions,
    subtitleNextLevel,
    nextLevelId,
    nextExerciseId,
  ];
}

class HomeFailure extends HomeState {
  final String message;
  const HomeFailure(this.message);

  @override
  List<Object> get props => [message];
}

class NextLevelSuccess extends HomeState {
  final Map<String, dynamic> data;
  NextLevelSuccess(this.data);
}

class NextLevelFailure extends HomeState {
  final String message;
  NextLevelFailure(this.message);
}


