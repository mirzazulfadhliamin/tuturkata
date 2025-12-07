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
        Row(
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
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$completedCount/$totalCount selesai',
                  style: const TextStyle(
                    color: Color(0xFF697282),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF9C2),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Color(0xFFD08700),
                    size: 18,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '+50 XP',
                    style: TextStyle(
                      color: const Color(0xFFD08700),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Column(
          children: missions.map((mission) => _buildMissionItem(mission)).toList(),
        ),
      ],
    );
  }

  Widget _buildMissionItem(MissionItem mission) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 2,
          color: mission.completed
              ? const Color(0xFFB8F7CF)
              : const Color(0xFFF2F4F6),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                mission.completed ? Icons.check_circle : Icons.circle_outlined,
                color: mission.completed ? Colors.green : const Color(0xFF697282),
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
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                        decoration: mission.completed
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      mission.progress,
                      style: const TextStyle(
                        color: Color(0xFF697282),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              if (mission.completed)
                Container(
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
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                ),
            ],
          ),
          if (!mission.completed) ...[
            const SizedBox(height: 12),
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(4),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: mission.current / mission.total,
                child: Container(
                  decoration: BoxDecoration(
                    color: mission.progressColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}