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
  final int completedDailyMissions;
  final int totalDailyMissions;
  final int weeklyChallengeProgress;
  final int weeklyChallengeTotal;
  final int daysLeftInWeek;

  const HomeLoaded({
    required this.streakDays,
    required this.totalXP,
    required this.completedSessions,
    required this.accuracy,
    required this.completedDailyMissions,
    required this.totalDailyMissions,
    required this.weeklyChallengeProgress,
    required this.weeklyChallengeTotal,
    required this.daysLeftInWeek,
  });

  @override
  List<Object> get props => [
    streakDays,
    totalXP,
    completedSessions,
    accuracy,
    completedDailyMissions,
    totalDailyMissions,
    weeklyChallengeProgress,
    weeklyChallengeTotal,
    daysLeftInWeek,
  ];
}