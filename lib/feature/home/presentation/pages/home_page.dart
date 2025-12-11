import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import 'package:tutur_kata/feature/home/presentation/pages/widgets/continue_learning_card.dart';
import 'package:tutur_kata/feature/home/presentation/pages/widgets/daily_missions.dart';
import 'package:tutur_kata/feature/home/presentation/pages/widgets/home_header.dart';
import 'package:tutur_kata/feature/home/presentation/pages/widgets/loading_simmer.dart';
import 'package:tutur_kata/feature/home/presentation/pages/widgets/stats_card.dart';
import 'package:tutur_kata/feature/home/presentation/pages/widgets/weekly_challenge_card.dart';

import '../../../../../core/theme/color_styles.dart';
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
    context.read<HomeBloc>().add(LoadHomeData());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColor.background,
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<HomeBloc>().add(LoadHomeData());
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
            onTap: () {},
          ),
          const SizedBox(height: 30),

          StatsCard(
            stats: [
              StatItem(
                title: 'Streak',
                value: '${state.streakDays}',
                startColor: AppColor.orangeLight,
                endColor: AppColor.orangeDark,
                icon: SvgPicture.asset(
                  'assets/svg/streak.svg',
                  width: 28,
                  height: 28,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Hari Berturut',
              ),
              StatItem(
                title: 'XP',
                value: '${state.totalXP}',
                startColor: AppColor.purpleLight,
                endColor: AppColor.purpleDark,
                icon:SvgPicture.asset(
                  'assets/svg/trophy.svg',
                  width: 28,
                  height: 28,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Total XP',
              ),
              StatItem(
                title: 'Sessions',
                value: '${state.completedSessions}',
                startColor: AppColor.greenLight,
                endColor: AppColor.greenDark,
                icon: SvgPicture.asset(
                  'assets/svg/message.svg',
                  width: 28,
                  height: 28,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Sesi Selesai',
              ),
              StatItem(
                title: 'Accuracy',
                value: '${state.accuracy}%',
                startColor: AppColor.blueLight,
                endColor: AppColor.blueDark,
                icon: SvgPicture.asset(
                  'assets/svg/circle.svg',
                  width: 28,
                  height: 28,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
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
            progress: 7,
            total: 15,
            daysLeft: 3,
          ),

          const SizedBox(height: 30),
        ],
      );
    }

    return const LoadingShimmer();
  }
}
