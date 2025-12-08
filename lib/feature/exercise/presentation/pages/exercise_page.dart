// exercise_page.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutur_kata/core/theme/color_styles.dart';
import 'package:tutur_kata/core/theme/text_styles.dart';
import 'package:tutur_kata/feature/exercise/presentation/pages/widgets/learning_card.dart';
import '../bloc/exercise_bloc.dart';
import '../bloc/exercise_event.dart';
import '../bloc/exercise_state.dart';
import 'exercise_detail.dart';

class ExercisePage extends StatelessWidget {
  final String categoryName;
  final int level;

  const ExercisePage({
    Key? key,
    required this.categoryName,
    required this.level,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ExerciseBloc()..add(LoadExercisesEvent()),
        child: Scaffold(
          backgroundColor: const Color(0xFFF7F7FC),
          body: SafeArea(
            child: BlocBuilder<ExerciseBloc, ExerciseState>(
              builder: (context, state) {
                if (state is ExerciseLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ExerciseLoaded) {
                  final loaded = state;

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildHeader(context),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                          child: Column(
                            children: [
                              ...loaded.exercises.asMap().entries.map((entry) {
                                final item = entry.value;
                                final index = entry.key;
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: LearningCard(
                                    title: item.title,
                                    subtitle: item.subtitle,
                                    progress: item.progress,
                                    isCompleted: item.completed,
                                    icon: _getIconForIndex(index),
                                    iconColor: Color(item.iconColor),
                                    iconBackground: Color(item.iconBg),
                                    gradientColors: item.gradient.map((hex) => Color(hex)).toList(),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => ExerciseDetailPage(
                                            id: item.id,
                                            title: item.title, // kalau butuh title
                                          ),
                                        ),
                                      );
                                    },

                                  ),
                                );
                              }),
                              _buildEndlessModeCard(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        )
    );
  }

  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0:
        return CupertinoIcons.book;
      case 1:
        return CupertinoIcons.book;
      case 2:
        return CupertinoIcons.book;
      case 3:
        return CupertinoIcons.book;
      default:
        return CupertinoIcons.book;
    }
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pilih Kategori Latihan",
            style: tsTitleSmallRegular(AppColor.textPrimary),
          ),
          const SizedBox(height: 6),
          Text(
            "Setiap kategori memiliki 4 level dari mudah ke sulit",
            style: tsBodyMediumRegular(AppColor.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildEndlessModeCard() {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to endless mode
      },
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.pinkPrimary, AppColor.purplePrimary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColor.white.withOpacity(0.35  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  CupertinoIcons.chevron_forward,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColor.white.withOpacity(0.35),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    CupertinoIcons.infinite,
                    color: Colors.white,
                    size: 30,
                  ),
                ),

                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Endless Mode',
                        style: tsBodyLargeSemiBold(Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Tantang dirimu\nlatihan tanpa batas',
                        style: tsBodyMediumRegular(
                          Colors.white.withOpacity(0.85),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
