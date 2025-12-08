import 'package:flutter/material.dart';
import 'package:tutur_kata/core/theme/text_styles.dart';
import '../../../../../core/theme/color_styles.dart';

class LearningCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final int progress;
  final bool isCompleted;
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final List<Color> gradientColors;
  final VoidCallback onTap;

  const LearningCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.isCompleted,
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.gradientColors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            width: 2,
            color:
            isCompleted ? AppColor.successTransparent : AppColor.grayLight,
          ),
        ),
        child: Row(
          children: [
            _buildIcon(),
            const SizedBox(width: 16),
            _buildContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: iconColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(icon, color: iconBackground, size: 28),
    );
  }

  Widget _buildContent() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleSubtitle(),
          const SizedBox(height: 12),
          _buildProgressBar(),
        ],
      ),
    );
  }

  Widget _buildTitleSubtitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: tsBodyLargeRegular(AppColor.textPrimary)
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: tsBodyMediumRegular(AppColor.textHint)
              ),
            ],
          ),
        ),
        _buildArrow(),
      ],
    );
  }

  Widget _buildProgressBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 6,
            decoration: BoxDecoration(
              color: AppColor.silver,
              borderRadius: BorderRadius.circular(3),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress / 100,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradientColors,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          '$progress%',
          style: tsBodyMediumRegular(AppColor.gray)
        ),
      ],
    );
  }

  Widget _buildArrow() {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: AppColor.silver,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(
        Icons.arrow_forward_ios,
        color: isCompleted ? AppColor.greenDark : AppColor.textSecondary,
        size: 16,
      ),
    );
  }
}
