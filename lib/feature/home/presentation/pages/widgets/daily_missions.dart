import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/theme/color_styles.dart';
import '../../../../../core/theme/text_styles.dart';

class MissionItem {
  final String title;
  final String progress;
  final int current;
  final int total;
  final bool completed;

  const MissionItem({
    required this.title,
    required this.progress,
    required this.current,
    required this.total,
    required this.completed,
  });
}

class DailyMissions extends StatelessWidget {
  final List<MissionItem> missions;
  final int completedCount;
  final int totalCount;

  const DailyMissions({
    Key? key,
    required this.missions,
    required this.completedCount,
    required this.totalCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DailyMissionHeader(
          completedCount: completedCount,
          totalCount: totalCount,
        ),
        const SizedBox(height: 16),
        Column(
          children: missions.map((m) => MissionCard(mission: m)).toList(),
        ),
      ],
    );
  }
}

class _DailyMissionHeader extends StatelessWidget {
  final int completedCount;
  final int totalCount;

  const _DailyMissionHeader({
    required this.completedCount,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Misi Harian',
              style: tsTitleSmallRegular(AppColor.textPrimary),
            ),
            const SizedBox(height: 4),
            Text(
              '$completedCount/$totalCount selesai',
              style: tsBodyMediumRegular(AppColor.textSecondary),
            ),
          ],
        ),
        _XpBadge(),
      ],
    );
  }
}

class _XpBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColor.yellowSoft,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/svg/giftBox.svg',
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              AppColor.amberDark,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '+50 XP',
            style: tsBodySmallMedium(AppColor.amberDark),
          ),
        ],
      ),
    );
  }
}

class MissionCard extends StatelessWidget {
  final MissionItem mission;

  const MissionCard({required this.mission, super.key});

  @override
  Widget build(BuildContext context) {
    final isDone = mission.completed;
    final progress = mission.current / mission.total;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 2,
          color: isDone ? AppColor.green.withOpacity(0.5): AppColor.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MissionRow(mission: mission, isDone: isDone),
          if (!isDone) ...[
            const SizedBox(height: 12),
            _ProgressBar(progress: progress),
          ],
        ],
      ),
    );
  }
}

class _MissionRow extends StatelessWidget {
  final MissionItem mission;
  final bool isDone;

  const _MissionRow({required this.mission, required this.isDone});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isDone
              ? CupertinoIcons.check_mark_circled
              : CupertinoIcons.circle,
          color: isDone ? AppColor.success : AppColor.grayLight,
          size: 24,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mission.title,
                style: tsBodyMediumRegular(
                  isDone ? AppColor.textSecondary : AppColor.textPrimary,
                ).copyWith(
                  decoration: isDone ? TextDecoration.lineThrough : null,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                mission.progress,
                style: tsBodyMediumRegular(AppColor.textSecondary),
              ),
            ],
          ),
        ),
        if (isDone) _DoneBadge(),
      ],
    );
  }
}

class _DoneBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColor.successTransparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        'Selesai',
        style: tsBodySmallMedium(AppColor.greenDark),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final double progress;

  const _ProgressBar({required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      decoration: BoxDecoration(
        color: AppColor.grayLight,
        borderRadius: BorderRadius.circular(4),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress,
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.primary,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
