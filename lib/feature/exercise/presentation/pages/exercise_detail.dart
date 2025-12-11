import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutur_kata/core/theme/color_styles.dart';
import 'package:tutur_kata/core/theme/text_styles.dart';

import '../bloc/exercise_detail/exercise_detail_bloc.dart';
import '../bloc/exercise_detail/exercise_detail_event.dart';
import '../bloc/exercise_detail/exercise_detail_model.dart';
import '../bloc/exercise_detail/exercise_detail_state.dart';

class ExerciseDetailPage extends StatelessWidget {
  final String id;
  final String title;
  final String desc;

  const ExerciseDetailPage({
    super.key,
    required this.id,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    // Dispatch the event to fetch exercise details when this page is loaded
    Future.delayed(Duration.zero, () {
      print('Dispatching GetExerciseDetailEvent with exerciseId: $id');
      context.read<ExerciseDetailBloc>().add(GetExerciseDetailEvent(exerciseId: id));
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Latihan $title",
          style: tsTitleSmallRegular(AppColor.textPrimary),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF7F7FC),
      body: SafeArea(
        child: BlocBuilder<ExerciseDetailBloc, ExerciseDetailState>(
          builder: (context, state) {
            // Loading state
            if (state is ExerciseDetailLoading) {
              print('ExerciseDetailLoading state received');
              return Center(
                child: CircularProgressIndicator(
                  color: AppColor.primary,
                ),
              );
            }

            // Failure state
            if (state is ExerciseDetailFailure) {
              print('ExerciseDetailFailure state received: ${state.message}');
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
                          print('Retrying to fetch exercise detail');
                          context.read<ExerciseDetailBloc>().add(
                              GetExerciseDetailEvent(exerciseId: id));
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

            if (state is ExerciseDetailSuccess) {
              print('ExerciseDetailSuccess state received');
              final exerciseDetailList = state.exerciseDetail;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    _buildCategoryCard(desc),
                    const SizedBox(height: 18),
                    _buildTipsCard(),
                    const SizedBox(height: 28),
                    _buildLevelList(exerciseDetailList),
                    const SizedBox(height: 28),
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

  Widget _buildCategoryCard(String title) {
    print('Building category card with title: $title');
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColor.gradientVertical(AppColor.primary, AppColor.primaryMedium),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              CupertinoIcons.book,
              size: 36,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Text(
              title,
              style: tsTitleSmallRegular(Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipsCard() {
    print('Building tips card');
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Tips", style: tsBodyLargeSemiBold(AppColor.textPrimary)),
          const SizedBox(height: 6),
          Text(
            "Selesaikan setiap level dengan minimal 2 bintang untuk membuka level selanjutnya. Dapatkan 3 bintang untuk reward maksimal!",
            style: tsBodyMediumRegular(AppColor.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelList(List<ExerciseDetailModel> exerciseDetailList) {
    print('Building level list with ${exerciseDetailList.length} items');
    return Column(
      children: [
        for (var i = 0; i < exerciseDetailList.length; i++) ...[
          _buildLevelItem(
            level: exerciseDetailList[i].order,
            title: "Level ${exerciseDetailList[i].order} - ${exerciseDetailList[i].title}",
            subtitle: exerciseDetailList[i].desc,
            stars: exerciseDetailList[i].star,
            locked: i != 0 && !exerciseDetailList[i - 1].isCompleted,
          ),
          if (i != exerciseDetailList.length - 1)
            _buildDividerLine(i != 0 && !exerciseDetailList[i - 1].isCompleted),
        ],
      ],
    );
  }

  Widget _buildDividerLine(bool aboveLocked) {
    return Container(
      height: 32,
      width: 4,
      color: aboveLocked ? AppColor.grayBlue : AppColor.primary,
    );
  }

  Widget _buildLevelItem({
    required int level,
    required String title,
    required String subtitle,
    required int stars,
    required bool locked,
  }) {
    print('Building level item for Level $level');
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: locked ? AppColor.silver : AppColor.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          _buildLevelBadge(level, locked),
          const SizedBox(width: 16),
          Expanded(
            child: _buildLevelTexts(title, subtitle, locked),
          ),
          locked
              ? const SizedBox.shrink()
              : Row(
            children: [
              _buildStars(stars),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLevelBadge(int level, bool locked) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: locked ? AppColor.grayBlue : AppColor.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: locked
          ? const Icon(
        CupertinoIcons.lock,
        color: AppColor.grayDark,
        size: 22,
      )
          : Text(
        "Lv.$level",
        style: tsBodyMediumSemiBold(Colors.white),
      ),
    );
  }

  Widget _buildLevelTexts(String title, String subtitle, bool locked) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: tsBodySmallRegular(AppColor.textPrimary),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: tsLabelLargeRegular(AppColor.textSecondary),
        ),
      ],
    );
  }

  Widget _buildStars(int count) {
    return Row(
      children: List.generate(
        count,
            (index) => const Icon(
          Icons.star_rounded,
          color: AppColor.gold,
          size: 20,
        ),
      ),
    );
  }
}
