import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFAC46FF), Color(0xFF980FFA)],
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 53,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  CupertinoIcons.rosette,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tantangan Minggu Ini',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Selesaikan $total latihan dalam seminggu',
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
            ],
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$progress/$total latihan',
                    style: const TextStyle(
                      color: Color(0xE5FFFEFE),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    '$daysLeft hari lagi',
                    style: const TextStyle(
                      color: Color(0xE5FFFEFE),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: percentage,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x19000000),
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  CupertinoIcons.star_fill,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 5),
                Text(
                  '+$xpReward XP',
                  style: const TextStyle(
                    color: Colors.white,
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
}
