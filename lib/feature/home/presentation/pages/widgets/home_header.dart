import 'package:flutter/material.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/theme/color_styles.dart';

class HomeHeader extends StatelessWidget {
  final String userName;
  final String greeting;

  const HomeHeader({
    Key? key,
    this.userName = 'Andi',
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
            style: tsTitleMediumRegular(AppColor.textPrimary),
            children: [
              TextSpan(
                text: userName,
                style: tsTitleMediumSemiBold(AppColor.textPrimary),
              ),
              TextSpan(
                text: '!',
                style:  tsTitleMediumSemiBold(AppColor.textPrimary),
              ),
            ],
          ),
        ),

        const SizedBox(height: 4),

        Text(
          'Siap untuk latihan hari ini?',
          style:tsBodyMediumRegular(AppColor.textSecondary)
        ),
      ],
    );
  }
}
