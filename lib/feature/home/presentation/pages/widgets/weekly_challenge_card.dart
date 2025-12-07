import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/theme/color_styles.dart';
import '../../../../../core/theme/text_styles.dart';

class WeeklyChallengeCard extends StatelessWidget {
  final int progress;
  final int total;
  final int daysLeft;
  final int xpReward;

  const WeeklyChallengeCard({
    Key? key,
    required this.progress,
    required this.total,
    required this.daysLeft,
    this.xpReward = 500,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final percentage = progress / total;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColor.gradientDiagonal(AppColor.purpleLight, AppColor.purpleDark),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
          Row(
            children: [
              Container(
                width: 50,
                height: 53,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColor.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: SvgPicture.asset(
                  'assets/svg/trophy.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    AppColor.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tantangan Minggu Ini',
                      style: tsBodyMediumRegular(AppColor.white),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Selesaikan $total latihan dalam seminggu',
                      style: tsBodyMediumRegular(AppColor.silver),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// PROGRESS
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$progress/$total latihan',
                    style: tsBodyMediumRegular(AppColor.white),
                  ),
                  Text(
                    '$daysLeft hari lagi',
                    style: tsBodyMediumRegular(AppColor.white),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              /// PROGRESS BAR
              Container(
                height: 12,
                decoration: BoxDecoration(
                  color: AppColor.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: percentage,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// XP REWARD
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColor.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/svg/giftBox.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    AppColor.white,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  '+$xpReward XP',
                  style: tsBodyMediumRegular(AppColor.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
