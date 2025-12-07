import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:tutur_kata/feature/home/presentation/pages/widgets/continue_learning_card.dart';
import 'package:tutur_kata/feature/home/presentation/pages/widgets/daily_missions.dart';
import 'package:tutur_kata/feature/home/presentation/pages/widgets/home_header.dart';
import 'package:tutur_kata/feature/home/presentation/pages/widgets/loading_simmer.dart';
import 'package:tutur_kata/feature/home/presentation/pages/widgets/stats_card.dart';
import 'package:tutur_kata/feature/home/presentation/pages/widgets/weekly_challenge_card.dart';

import '../bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Load data saat pertama kali dibuka
    context.read<HomeBloc>().add( LoadHomeData());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF7F7FC),
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<HomeBloc>().add( LoadHomeData());
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: _buildContent(state),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent(HomeState state) {
    if (state is HomeLoading) {
      return const LoadingShimmer();
    }

    if (state is HomeLoaded) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeHeader(),
          const SizedBox(height: 30),

          ContinueLearningCard(
            title: 'Lanjutkan Belajar',
            subtitle: 'Membaca Kata - Level 3',
            onTap: () {
              // Navigate to learning page
            },
          ),
          const SizedBox(height: 30),

          StatsCard(
            stats: [
              StatItem(
                title: 'Streak',
                value: '${state.streakDays}',
                startColor: const Color(0xFFFF8803),
                endColor: const Color(0xFFFF6800),
                icon: CupertinoIcons.flame_fill,
                label: 'Hari Berturut',
              ),
              StatItem(
                title: 'XP',
                value: '${state.totalXP}',
                startColor: const Color(0xFFAD46FF),
                endColor: const Color(0xFF9810FA),
                icon: CupertinoIcons.star_fill,
                label: 'Total XP',
              ),
              StatItem(
                title: 'Sessions',
                value: '${state.completedSessions}',
                startColor: const Color(0xFF00C850),
                endColor: const Color(0xFF00A63D),
                icon: CupertinoIcons.check_mark_circled_solid,
                label: 'Sesi Selesai',
              ),
              StatItem(
                title: 'Accuracy',
                value: '${state.accuracy}%',
                startColor: const Color(0xFF2B7FFF),
                endColor: const Color(0xFF155CFB),
                icon: CupertinoIcons.chart_bar_alt_fill,
                label: 'Akurasi',
              ),
            ],
          ),
          const SizedBox(height: 30),

          DailyMissions(
            missions: [
              MissionItem(
                title: 'Selesaikan 2 latihan',
                progress: '1/2',
                current: 1,
                total: 2,
                completed: false,
              ),
              MissionItem(
                title: 'Latihan 10 menit',
                progress: '7/10',
                current: 7,
                total: 10,
                completed: false,
              ),
              MissionItem(
                title: 'Capai akurasi 80%',
                progress: '80/80',
                current: 80,
                total: 80,
                completed: true,
              ),
            ],
            completedCount: state.completedDailyMissions,
            totalCount: state.totalDailyMissions,
          ),
          const SizedBox(height: 30),

          WeeklyChallengeCard(
            progress: state.weeklyChallengeProgress,
            total: state.weeklyChallengeTotal,
            daysLeft: state.daysLeftInWeek,
          ),
          const SizedBox(height: 30),
        ],
      );
    }

    // Initial state
    return const LoadingShimmer();
  }
}