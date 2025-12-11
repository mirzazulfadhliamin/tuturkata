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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
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
                  const SizedBox(height: 2),
                  Text(
                    "Level - $subtitle",
                    style: tsBodySmallRegular(AppColor.white.withOpacity(0.8)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
