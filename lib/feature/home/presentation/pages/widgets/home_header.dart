import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final String userName;
  final String greeting;

  const HomeHeader({
    Key? key,
    this.userName = 'Aisyah',
    this.greeting = 'Selamat Pagi',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: '$greeting, ',
            style: const TextStyle(
              color: Color(0xFF101727),
              fontSize: 24,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
            children: [
              TextSpan(
                text: userName,
                style: const TextStyle(
                  color: Color(0xFF101727),
                  fontSize: 24,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w700,
                  height: 1.5,
                ),
              ),
              const TextSpan(
                text: '!',
                style: TextStyle(
                  color: Color(0xFF101727),
                  fontSize: 24,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Siap untuk latihan hari ini?',
          style: TextStyle(
            color: Color(0xFF697282),
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}