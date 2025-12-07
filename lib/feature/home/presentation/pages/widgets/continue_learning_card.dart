import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/color_styles.dart';
import '../../../../../core/theme/text_styles.dart';

class ContinueLearningCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const ContinueLearningCard({
    Key? key,
    required this.title,
    required this.subtitle,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColor.gradientVertical(
          AppColor.primaryBright,
          AppColor.primaryMedium,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColor.shadow,
            blurRadius: 6,
            offset: const Offset(0, 4),
            spreadRadius: -4,
          ),
          BoxShadow(
            color: AppColor.shadowMedium,
            blurRadius: 15,
            offset: const Offset(0, 10),
            spreadRadius: -3,
          ),
        ],
      ),
      child: Row(
        children: [
          // ICON WRAPPER
          Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.only(right: 0.02),
            decoration: BoxDecoration(
              color: AppColor.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              CupertinoIcons.play,
              color: AppColor.white,
              size: 28,
            ),
          ),

          const SizedBox(width: 16),

          // TITLE & SUBTITLE
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: tsBodyMediumRegular(AppColor.white),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: tsBodyMediumRegular(AppColor.white.withOpacity(0.8)),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // BUTTON "LANJUT"
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 83,
              height: 44,
              decoration: BoxDecoration(
                color: AppColor.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(
                  'Lanjut',
                  style: tsBodyMediumRegular(AppColor.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
