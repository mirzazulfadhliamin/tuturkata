import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/color_styles.dart';
import '../../../../core/theme/text_styles.dart';
import '../bloc/exercise/exercise_bloc.dart';
import '../bloc/exercise/exercise_event.dart';
import '../bloc/exercise/exercise_state.dart';
import 'widgets/learning_card.dart';
import 'exercise_detail.dart';

class ExercisePage extends StatelessWidget {
  const ExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      print('Dispatching GetUserExercisesEvent');
      context.read<ExerciseBloc>().add(GetUserExercisesEvent());
    });

    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: BlocBuilder<ExerciseBloc, ExerciseState>(
          builder: (context, state) {
            // Loading state
            if (state is ExerciseLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColor.primary,
                ),
              );
            }

            // Failure state
            if (state is ExerciseFailure) {
              print('Exercise failure: ${state.message}');
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: AppColor.error,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        state.message,
                        style: tsBodyMediumRegular(AppColor.textSecondary),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          context.read<ExerciseBloc>().add(GetUserExercisesEvent());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primary,
                          foregroundColor: AppColor.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Coba Lagi',
                          style: tsBodyMediumSemiBold(AppColor.white),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            // Success state (ExerciseSuccess)
            if (state is ExerciseSuccess) {
              // Check if exercises list is empty
              if (state.exercise.isEmpty) {
                print('No exercises available');
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      'No exercises available',
                      style: tsBodyMediumRegular(AppColor.textSecondary),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }

              print('Exercises loaded: ${state.exercise.length}');
              return SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      child: Column(
                        children: [
                          ...state.exercise.asMap().entries.map((entry) {
                            final exercise = entry.value;
                            final index = entry.key;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: LearningCard(
                                title: exercise.title,
                                subtitle: exercise.desc,
                                progress: exercise.progressPercentage,
                                isCompleted: exercise.isCompleted,
                                icon: CupertinoIcons.book,
                                iconColor: _getIconColorForIndex(index)
                                    .withOpacity(0.1),
                                iconBackground: _getIconColorForIndex(index),
                                gradientColors: _getGradientForIndex(index),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ExerciseDetailPage(
                                        id: exercise.exerciseId,
                                        title: exercise.title,
                                        desc: exercise.desc
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

            return const SizedBox(); // Default case, shouldn't happen
          },
        ),
      ),
    );
  }

  Color _getIconColorForIndex(int index) {
    switch (index) {
      case 0:
        return AppColor.blue;
      case 1:
        return AppColor.green;
      case 2:
        return AppColor.purple;
      case 3:
        return AppColor.orange;
      default:
        return AppColor.primary;
    }
  }

  List<Color> _getGradientForIndex(int index) {
    switch (index) {
      case 0:
        return [AppColor.blue, AppColor.blueLight];
      case 1:
        return [AppColor.green, AppColor.greenLight];
      case 2:
        return [AppColor.purple, AppColor.purpleLight];
      case 3:
        return [AppColor.orange, AppColor.orangeLight];
      default:
        return [AppColor.primary, AppColor.primaryLight];
    }
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pilih Kategori Latihan",
            style: tsBodyLargeMedium(AppColor.textPrimary),
          ),
          const SizedBox(height: 6),
          Text(
            "Setiap kategori memiliki 4 level dari mudah ke sulit",
            style: tsBodySmallRegular(AppColor.textSecondary),
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
          gradient: AppColor.gradientHorizontal(AppColor.pink, AppColor.purple),
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
                  color: AppColor.white.withOpacity(0.35),
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
