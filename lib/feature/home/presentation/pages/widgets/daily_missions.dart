import 'package:flutter/material.dart';

class MissionItem {
  final String title;
  final String progress;
  final int current;
  final int total;
  final bool completed;
  final Color progressColor;

  const MissionItem({
    required this.title,
    required this.progress,
    required this.current,
    required this.total,
    required this.completed,
    this.progressColor = const Color(0xFF40E0D0),
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
        _DailyMissionHeader(completedCount: completedCount, totalCount: totalCount),
        const SizedBox(height: 16),
        Column(
          children: missions.map((mission) => MissionCard(mission)).toList(),
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
            const Text(
              'Misi Harian',
              style: TextStyle(
                color: Color(0xFF101727),
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$completedCount/$totalCount selesai',
              style: const TextStyle(
                color: Color(0xFF697282),
                fontSize: 16,
                fontFamily: 'Poppins',
              ),
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
        color: const Color(0xFFFEF9C2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.star,
            color: Color(0xFFD08700),
            size: 18,
          ),
          SizedBox(width: 5),
          Text(
            '+50 XP',
            style: TextStyle(
              color: Color(0xFFD08700),
              fontSize: 16,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}

class MissionCard extends StatelessWidget {
  final MissionItem mission;

  const MissionCard(this.mission, {super.key});

  @override
  Widget build(BuildContext context) {
    final isDone = mission.completed;
    final progress = mission.current / mission.total;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 2,
          color: isDone ? const Color(0xFFB8F7CF) : const Color(0xFFF2F4F6),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MissionRow(mission: mission, isDone: isDone),
          if (!isDone) ...[
            const SizedBox(height: 12),
            _ProgressBar(progress: progress, color: mission.progressColor),
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
          isDone ? Icons.check_circle : Icons.circle_outlined,
          color: isDone ? Colors.green : const Color(0xFF697282),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mission.title,
                style: TextStyle(
                  color: const Color(0xFF101727),
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  decoration: isDone ? TextDecoration.lineThrough : null,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                mission.progress,
                style: const TextStyle(
                  color: Color(0xFF697282),
                  fontSize: 16,
                  fontFamily: 'Poppins',
                ),
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
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFDCFCE7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text(
        'Selesai',
        style: TextStyle(
          color: Color(0xFF008235),
          fontSize: 16,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final double progress;
  final Color color;

  const _ProgressBar({required this.progress, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(4),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
