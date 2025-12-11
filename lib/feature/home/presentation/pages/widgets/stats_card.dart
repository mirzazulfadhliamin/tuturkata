import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/color_styles.dart';
import '../../../../../core/theme/text_styles.dart';

class StatItem {
  final String title;
  final String value;
  final Color startColor;
  final Color endColor;
  final Widget icon; // <— GANTI: sekarang Widget, bukan IconData
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
      padding: const EdgeInsets.all(24),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                  'Minggu Ini',
                  style: tsBodyMediumRegular(AppColor.textPrimary)
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: stats.map(_buildStatItem).toList(),
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      border: Border.all(width: 1, color: const Color(0xFFF2F4F6)),
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
    );
  }


  Widget _buildStatItem(StatItem stat) {
    return SizedBox(
      width: 80,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIconBox(stat),
          const SizedBox(height: 5),
          _buildValue(stat),
          const SizedBox(height: 2),
          _buildLabel(stat),
        ],
      ),
    );
  }

  Widget _buildIconBox(StatItem stat) {
    return Container(
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
      child: Center(
        child: stat.icon,
      ),
    );
  }

  Widget _buildValue(StatItem stat) {
    return Text(
      stat.value,
      style: tsBodyMediumRegular(AppColor.textPrimary),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildLabel(StatItem stat) {
    return Text(
      stat.label,
      style: const TextStyle(
        fontSize: 12,
        color: Color(0xFF6C7278),
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.center,
    );
  }
}
