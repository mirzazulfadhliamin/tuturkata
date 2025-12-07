import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExercisePage extends StatelessWidget {
  final String categoryName;
  final int level;

  const ExercisePage({
    Key? key,
    required this.categoryName,
    required this.level,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              _buildHeader(context),
              // Exercise List
              _buildExerciseList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: const Icon(Icons.arrow_back, size: 24),
            ),
          ),
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  categoryName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Level $level • 4 latihan',
                  style: const TextStyle(
                    color: Color(0xFF6C7278),
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
    );
  }

  Widget _buildExerciseList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          _buildExerciseCard(
            title: 'Latihan 1: Pengenalan',
            subtitle: 'Belajar pengucapan dasar',
            progress: 100,
            isCompleted: true,
            icon: Icons.mic,
            iconColor: const Color(0xFFEFF6FF),
            iconBackground: const Color(0xFF2B7FFF),
            gradientColors: const [Color(0xFF2B7FFF), Color(0xFF155CFB)],
          ),
          const SizedBox(height: 16),
          _buildExerciseCard(
            title: 'Latihan 2: Kata Tunggal',
            subtitle: 'Latihan kata per kata',
            progress: 75,
            isCompleted: false,
            icon: Icons.text_fields,
            iconColor: const Color(0xFFF0FDF4),
            iconBackground: const Color(0xFF00C850),
            gradientColors: const [Color(0xFF00C850), Color(0xFF00A63D)],
          ),
          const SizedBox(height: 16),
          _buildExerciseCard(
            title: 'Latihan 3: Kata Gabungan',
            subtitle: 'Gabungkan beberapa kata',
            progress: 50,
            isCompleted: false,
            icon: Icons.format_quote,
            iconColor: const Color(0xFFFAF5FF),
            iconBackground: const Color(0xFFAC46FF),
            gradientColors: const [Color(0xFFAC46FF), Color(0xFF980FFA)],
          ),
          const SizedBox(height: 16),
          _buildExerciseCard(
            title: 'Latihan 4: Kalimat Lengkap',
            subtitle: 'Latihan kalimat utuh',
            progress: 0,
            isCompleted: false,
            icon: Icons.short_text,
            iconColor: const Color(0xFFFFF7ED),
            iconBackground: const Color(0xFFFF6800),
            gradientColors: const [Color(0xFFFF6800), Color(0xFFF44900)],
          ),
          const SizedBox(height: 16),
          _buildEndlessModeCard(),
        ],
      ),
    );
  }

  Widget _buildExerciseCard({
    required String title,
    required String subtitle,
    required int progress,
    required bool isCompleted,
    required IconData icon,
    required Color iconColor,
    required Color iconBackground,
    required List<Color> gradientColors,
  }) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          width: 2,
          color: isCompleted
              ? const Color(0xFFB8F7CF)
              : const Color(0xFFF2F4F6),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: iconColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: iconBackground,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                              decoration: isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            subtitle,
                            style: const TextStyle(
                              color: Color(0xFF6C7278),
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDF1F3),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: isCompleted
                            ? const Color(0xFF00A63D)
                            : const Color(0xFF6C7278),
                        size: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEDF1F3),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: progress / 100,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: gradientColors,
                              ),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 45,
                      child: Text(
                        '$progress%',
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: Color(0xFF6C7278),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEndlessModeCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment(-0.01, 0.03),
          end: Alignment(1.13, 1.47),
          colors: [Color(0xFFF6339A), Color(0xFF9810FA)],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.eighteen_mp,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Endless Mode',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Tantang dirimu latihan tanpa batas',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}