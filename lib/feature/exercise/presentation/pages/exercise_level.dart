import 'package:flutter/material.dart';
import '../../../../core/theme/color_styles.dart';
import '../../../../core/theme/text_styles.dart';

class ExerciseLevelPage extends StatefulWidget {
  const ExerciseLevelPage({super.key});

  @override
  State<ExerciseLevelPage> createState() => _ExerciseLevelPageState();
}

class _ExerciseLevelPageState extends State<ExerciseLevelPage>
    with SingleTickerProviderStateMixin {
  bool _isRecording = false;
  late AnimationController _waveController;
  late Animation<double> _waveAnimation;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _waveAnimation = Tween(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(parent: _waveController, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  void _toggleRecording() {
    setState(() {
      _isRecording = !_isRecording;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColor.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Membaca Kata - Level 1',
          style: tsBodyLargeMedium(AppColor.textPrimary),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: MediaQuery.of(context).size.height * 0.378,
            child: AnimatedBuilder(
              animation: _waveAnimation,
              builder: (context, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    final delay = index * 0.2;
                    final animValue = (_waveAnimation.value - delay).clamp(0.0, 1.0);

                    final scale = _isRecording
                        ? 1 + (0.5 * (1 - (animValue - 0.5).abs() * 2))
                        : 1.0;

                    return Transform.scale(
                      scale: scale,
                      child: Container(
                        width: 6,
                        height: 20.0,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ),
          // Main body content below
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                _buildProgressBar(),
                const Spacer(),
                _buildInstructionText(),
                const SizedBox(height: 16),
                _buildWordText(),
                const SizedBox(height: 140),
                _buildMicrophoneButton(),
                const SizedBox(height: 40),
                _buildHintCard(),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '1 / 5',
          style: tsBodyMediumMedium(AppColor.textSecondary),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: 0.2,
            minHeight: 8,
            backgroundColor: AppColor.grayLight,
            valueColor: AlwaysStoppedAnimation<Color>(AppColor.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildInstructionText() {
    return Text(
      'Ucapkan kata ini:',
      style: tsBodyMediumRegular(AppColor.textSecondary),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildWordText() {
    return Text(
      'Apel',
      style: tsHeadingLargeBold(AppColor.textPrimary),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildMicrophoneButton() {
    return GestureDetector(
      onTap: _toggleRecording,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColor.primary,
          boxShadow: [
            BoxShadow(
              color: AppColor.primary.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Icon(
          Icons.mic,
          size: 56,
          color: AppColor.white,
        ),
      ),
    );
  }

  Widget _buildHintCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: AppColor.primaryLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'Baca dengan perlahan dan jelas',
        style: tsBodyMediumMedium(AppColor.primaryDark),
        textAlign: TextAlign.center,
      ),
    );
  }
}
