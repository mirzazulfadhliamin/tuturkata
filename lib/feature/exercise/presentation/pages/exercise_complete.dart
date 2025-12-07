import 'package:flutter/material.dart';

import '../../../../core/theme/color_styles.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../home/presentation/pages/home_page.dart';

class ExerciseResultPage extends StatelessWidget {
  const ExerciseResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 40),
              _buildTrophyIcon(),
              const SizedBox(height: 24),
              _buildTitle(),
              const SizedBox(height: 24),
              _buildStars(),
              const SizedBox(height: 32),
              _buildScoreCard(),
              const SizedBox(height: 24),
              _buildUnlockBanner(),
              const Spacer(),
              _buildContinueButton(context),
              const SizedBox(height: 16),
              _buildActionButtons(context),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrophyIcon() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: AppColor.primary,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryTransparent,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Icon(
        Icons.emoji_events,
        size: 50,
        color: AppColor.white,
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Latihan Membaca Kata - Level 2',
      textAlign: TextAlign.center,
      style: tsBodyLargeMedium(AppColor.textSecondary),
    );
  }

  Widget _buildStars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStar(true),
        const SizedBox(width: 16),
        _buildStar(true),
        const SizedBox(width: 16),
        _buildStar(false),
      ],
    );
  }

  Widget _buildStar(bool filled) {
    return Icon(
      filled ? Icons.star : Icons.star_border,
      size: 48,
      color: filled ? AppColor.yellow : AppColor.gray,
    );
  }

  Widget _buildScoreCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColor.shadow,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Skor Akhir',
            style: tsBodyMediumRegular(AppColor.textSecondary),
          ),
          const SizedBox(height: 8),
          Text(
            '84% Akurasi',
            style: tsHeadingMediumBold(AppColor.textPrimary),
          ),
          const SizedBox(height: 16),
          Text(
            '+120 XP',
            style: tsTitleMediumSemiBold(AppColor.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildUnlockBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.purpleTransparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColor.purpleTransparent,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColor.purple,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.star,
              color: AppColor.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Level Baru Terbuka!',
                  style: tsBodyLargeSemiBold(AppColor.purple),
                ),
                const SizedBox(height: 4),
                Text(
                  'Latihan Membaca Kata - Level 3',
                  style: tsBodyMediumRegular(AppColor.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primary,
          foregroundColor: AppColor.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Lanjut ke Level 3',
              style: tsBodyLargeSemiBold(AppColor.white),
            ),
            const SizedBox(width: 8),
            Icon(Icons.arrow_forward, size: 20, color: AppColor.white),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: BorderSide(color: AppColor.border),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: Icon(Icons.refresh, color: AppColor.textSecondary, size: 20),
            label: Text(
              'Ulangi',
              style: tsBodyMediumSemiBold(AppColor.textSecondary),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: BorderSide(color: AppColor.border),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: Icon(Icons.home_outlined, color: AppColor.textSecondary, size: 20),
            label:  TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Beranda',
                style: tsBodyMediumSemiBold(AppColor.textSecondary),
              ),
            ),
          ),
        ),
      ],
    );
  }
}