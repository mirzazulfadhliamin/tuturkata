import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tutur_kata/core/theme/color_styles.dart';
import 'package:tutur_kata/core/theme/text_styles.dart';

class ExerciseDetailPage extends StatelessWidget {
  final String id;
  final String title;

  const ExerciseDetailPage({
    super.key,
    required this.id,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              _buildCategoryCard(),

              const SizedBox(height: 18),
              _buildTipsCard(),

              const SizedBox(height: 28),
              _buildLevelList(),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }


  // CATEGORY CARD ---------------------------------------------------
  Widget _buildCategoryCard() {
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
              "Latihan pengucapan kata dasar",
              style: tsTitleSmallSemiBold(Colors.white),
            ),
          )
        ],
      ),
    );
  }

  // TIPS CARD -------------------------------------------------------
  Widget _buildTipsCard() {
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

  // LEVEL LIST -----------------------------------------------------
  Widget _buildLevelList() {
    return Column(
      children: [
        _buildLevelItem(
          level: 1,
          title: "Level 1 - Pemula",
          subtitle: "Kata-kata sederhana",
          stars: 3,
          locked: false,
        ),
        _buildDividerLine(false),

        _buildLevelItem(
          level: 2,
          title: "Level 2 - Dasar",
          subtitle: "Kata-kata umum",
          stars: 2,
          locked: false,
        ),
        _buildDividerLine(false),

        _buildLevelItem(
          level: 3,
          title: "Level 3 - Menengah",
          subtitle: "Kata-kata pendek",
          stars: 1,
          locked: false,
        ),
        _buildDividerLine(false),

        _buildLevelItem(
          level: 4,
          title: "Level 4 - Lanjutan",
          subtitle: "Kata-kata kompleks",
          stars: 0,
          locked: true,
        ),
        _buildDividerLine(true),

        _buildLevelItem(
          level: 5,
          title: "Level 5 - Mahir",
          subtitle: "Kata-kata lengkap",
          stars: 0,
          locked: true,
        ),
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: locked ?  AppColor.silver : AppColor.white,
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
              Transform.translate(
                offset: stars == 3
                    ? const Offset(0, -12)
                    : Offset.zero,
                child: _buildStars(stars),
              ),
              if (stars == 3) ...[
                const SizedBox(width: 8),
                SvgPicture.asset(
                  'assets/svg/trophy.svg',
                  color: AppColor.gold,
                  width: 20,
                  height: 20,
                ),
              ],
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
          style: tsTitleSmallRegular(
         AppColor.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: tsBodyMediumRegular(AppColor.textSecondary),
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
          color: AppColor.gold  ,
          size: 20,
        ),
      ),
    );
  }
}
