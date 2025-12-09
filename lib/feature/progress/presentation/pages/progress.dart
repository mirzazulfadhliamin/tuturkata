import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/color_styles.dart';
import '../../../../core/theme/text_styles.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildStatsCards(),
              const SizedBox(height: 24),
              _buildActivityChart(),
              const SizedBox(height: 24),
              _buildBadgeSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Progres Kamu',
          style: tsTitleLargeBold(AppColor.textPrimary),
        ),
        const SizedBox(height: 4),
        Text(
          'Pantau perkembangan latihan terapi Stuttering',
          style: tsBodySmallRegular(AppColor.textSecondary),
        ),
      ],
    );
  }

  Widget _buildStatsCards() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: [
        _buildStatCard(
          color: AppColor.orange,
          icon: SvgPicture.asset(
            'assets/svg/streak.svg',
            width: 40,
            height: 40,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
          value: '7',
          unit: 'Days',
          label: 'Streak',
        ),
        _buildStatCard(
          color: AppColor.purple,
          icon: SvgPicture.asset(
            'assets/svg/trophy.svg',
            width: 40,
            height: 40,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
          value: '1250',
          unit: 'XP',
          label: 'Total XP',
        ),
        _buildStatCard(
          color: AppColor.blue,
          icon: SvgPicture.asset(
            'assets/svg/circle.svg',
            width: 40,
            height: 40,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
          value: '86',
          unit: '%',
          label: 'Accuration',
        ),
        _buildStatCard(
          color: AppColor.green,
          icon: SvgPicture.asset(
            'assets/svg/message.svg',
            width: 40,
            height: 40,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
          value: '38',
          unit: 'Exercises',
          label: 'This Week',
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required Color color,
    required Widget icon,
    required String value,
    required String unit,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              icon,
              const SizedBox(width: 4),
              Text(
                value,
                style: tsHeadingMediumBold(AppColor.white),
              ),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  unit,
                  style: tsBodySmallMedium(AppColor.white),
                ),
              ),
            ],
          ),
          Text(
            label,
            style: tsBodyMediumMedium(AppColor.white),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityChart() {
    return Container(
      padding: const EdgeInsets.all(20),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Aktivitas Mingguan',
            style: tsTitleMediumBold(AppColor.textPrimary),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 8,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const days = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
                        return Text(
                          days[value.toInt()],
                          style: tsBodySmallRegular(AppColor.textSecondary),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: tsBodySmallRegular(AppColor.textSecondary),
                        );
                      },
                    ),
                  ),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: AppColor.grayLight,
                      strokeWidth: 1,
                      dashArray: [5, 5],
                    );
                  },
                ),
                borderData: FlBorderData(show: false),
                barGroups: [
                  _buildBarGroup(0, 5),
                  _buildBarGroup(1, 7),
                  _buildBarGroup(2, 6),
                  _buildBarGroup(3, 7.5),
                  _buildBarGroup(4, 5.5),
                  _buildBarGroup(5, 4),
                  _buildBarGroup(6, 3.5),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData _buildBarGroup(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: AppColor.primary,
          width: 24,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
        ),
      ],
    );
  }

  Widget _buildBadgeSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svg/badge.svg',
              width: 25,
              height: 25,
            ),
            const SizedBox(width: 8),
            Text(
              'Koleksi Badge',
              style: tsTitleMediumBold(AppColor.yellow),
            ),
          ],
        ),
        const SizedBox(height: 20),

        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            final itemWidth = (width - 12) / 2;
            final itemHeight = itemWidth * 1.5;
            final aspectRatio = itemWidth / itemHeight;

            final badgeItems = [
              _buildBadgeCard(
                color: AppColor.green,
                icon: SvgPicture.asset(
                  'assets/svg/e1.svg',
                  width: 28,
                  height: 28,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
                title: 'Endless Pemula',
                description: 'Selesaikan 10\nlatihan di\nEndless',
                daysAgo: '30 hari lalu',
                isLocked: false,
              ),
              _buildBadgeCard(
                color: AppColor.blue,
                icon: SvgPicture.asset(
                  'assets/svg/e2.svg',
                  width: 28,
                  height: 28,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
                title: 'Endless Terampil',
                description: 'Selesaikan 25\nlatihan di\nEndless',
                daysAgo: '30 hari lalu',
                isLocked: false,
              ),
              _buildBadgeCard(
                color: AppColor.purple,
                icon: SvgPicture.asset(
                  'assets/svg/e3.svg',
                  width: 28,
                  height: 28,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
                title: 'Endless Mahir',
                description: 'Selesaikan 50\nlatihan di\nEndless',
                daysAgo: '17 hari lalu',
                isLocked: false,
              ),
              _buildBadgeCard(
                color: AppColor.orange,
                icon: SvgPicture.asset(
                  'assets/svg/e4.svg',
                  width: 28,
                  height: 28,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
                title: 'Endless Master',
                description: 'Selesaikan 75\nlatihan di\nEndless',
                daysAgo: '16 hari lalu',
                isLocked: false,
              ),
              _buildBadgeCard(
                color: AppColor.red,
                icon: SvgPicture.asset(
                  'assets/svg/e5.svg',
                  width: 28,
                  height: 28,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
                title: 'Endless Legend',
                description: 'Selesaikan 100\nlatihan di\nEndless',
                daysAgo: '1 hari lalu',
                isLocked: false,
              ),
              _buildBadgeCard(
                color: AppColor.green,
                icon: SvgPicture.asset(
                  'assets/svg/m1.svg',
                  width: 28,
                  height: 28,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
                title: 'Master Kata',
                description: 'Selesaikan semua level\ntingkat kata',
                daysAgo: '30 hari lalu',
                isLocked: false,
              ),
              _buildBadgeCard(
                color: AppColor.blue,
                icon: SvgPicture.asset(
                  'assets/svg/m2.svg',
                  width: 28,
                  height: 28,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
                title: 'Master Kalimat Dasar',
                description: 'Selesaikan semua level\ntingkat kalimat dasar',
                daysAgo: '30 hari lalu',
                isLocked: false,
              ),
              _buildBadgeCard(
                color: AppColor.purple,
                icon: SvgPicture.asset(
                  'assets/svg/m3.svg',
                  width: 28,
                  height: 28,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
                title: 'Master Kalimat Menengah',
                description: 'Selesaikan semua level\ntingkat kalimat menengah',
                daysAgo: '30 hari lalu',
                isLocked: true,
              ),
              _buildBadgeCard(
                color: AppColor.red,
                icon: SvgPicture.asset(
                  'assets/svg/m4.svg',
                  width: 28,
                  height: 28,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
                title: 'Master Kalimat Lanjut',
                description: 'Selesaikan semua level\ntingkat kalimat lanjut',
                daysAgo: '30 hari lalu',
                isLocked: true,
              ),
            ];

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: aspectRatio,
              ),
              itemCount: badgeItems.length,
              itemBuilder: (_, i) => badgeItems[i],
            );
          },
        ),
      ],
    );
  }

  Widget _buildBadgeCard({
    required Color color,
    required Widget icon,
    required String title,
    required String description,
    required String daysAgo,
    required bool isLocked,
  }) {
    return Stack(
      children: [
        // ===== CARD UTAMA =====
        Container(
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
              // HEADER
              Container(
                height: 120,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColor.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: icon,
                  ),
                ),
              ),

              // BODY
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            title,
                            style: tsBodyMediumBold(AppColor.textPrimary),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            description,
                            style: tsBodySmallRegular(AppColor.textSecondary),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),

                      // DaysAgo tetap muncul kalau locked?
                      // Kamu minta dihilangkan, jadi:
                      if (!isLocked)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.access_time, size: 12, color: AppColor.gray),
                            const SizedBox(width: 4),
                            Text(
                              daysAgo,
                              style: tsBodySmallRegular(AppColor.gray),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // ===== OVERLAY FULL (JIKA LOCKED) =====
        if (isLocked)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.overlay, // misal hitam 0.4
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Icon(Icons.lock, color: AppColor.white, size: 36),
              ),
            ),
          ),
      ],
    );
  }


}