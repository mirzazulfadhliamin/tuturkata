import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContinueLearningCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final Color startColor;
  final Color endColor;

  const ContinueLearningCard({
    Key? key,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.startColor = const Color(0xFF40E0D0),
    this.endColor = const Color(0xFF30C0B0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.5, 0),
          end: const Alignment(0.5, 1),
          colors: [startColor, endColor],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0x19000000),
            blurRadius: 6,
            offset: const Offset(0, 4),
            spreadRadius: -4,
          ),
          BoxShadow(
            color: const Color(0x19000000),
            blurRadius: 15,
            offset: const Offset(0, 10),
            spreadRadius: -3,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.only(right: 0.02),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              CupertinoIcons.play,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
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
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xCCFFFEFE),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 83,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Center(
                child: Text(
                  'Lanjut',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}