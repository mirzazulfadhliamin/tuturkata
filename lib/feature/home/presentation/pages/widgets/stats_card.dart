import 'package:flutter/material.dart';

class StatItem {
  final String title;
  final String value;
  final Color startColor;
  final Color endColor;
  final IconData icon;
  final String label;

  const StatItem({
    required this.title,
    required this.value,
    required this.startColor,
    required this.endColor,
    required this.icon,
    required this.label,
  });
}

class StatsCard extends StatelessWidget {
  final List<StatItem> stats;

  const StatsCard({Key? key, required this.stats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(21, 21, 21, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          width: 1,
          color: const Color(0xFFF2F4F6),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 2,
            offset: Offset(0, 1),
            spreadRadius: -1,
          ),
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 3,
            offset: Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Minggu Ini',
            style: TextStyle(
              color: Color(0xFF101727),
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),

          // Row untuk 4 items
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: stats.map((stat) => _buildStatItem(stat)).toList(),
          )
        ],
      ),
    );
  }

  Widget _buildStatItem(StatItem stat) {
    return SizedBox(
      width: 80, // mengikuti desain figma
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [stat.startColor, stat.endColor],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 6,
                  offset: Offset(1, 3),
                ),
              ],
            ),
            child: Icon(stat.icon, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 5),

          // Value
          Text(
            stat.value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),

          const SizedBox(height: 2),

          // Label
          Text(
            stat.label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF6C7278),
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
