import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'package:tutur_kata/core/theme/color_styles.dart';
import 'package:tutur_kata/core/theme/text_styles.dart';
import '../bloc/exercise_level/exercise_level_bloc.dart';
import '../bloc/exercise_level/exercise_level_event.dart';
import '../bloc/exercise_level/exercise_level_state.dart';
import 'exercise_complete.dart';

class ExerciseLevelPage extends StatefulWidget {
  final String levelId;

  const ExerciseLevelPage({
    super.key,
    required this.levelId,
  });

  @override
  State<ExerciseLevelPage> createState() => _ExerciseLevelPageState();
}

class _ExerciseLevelPageState extends State<ExerciseLevelPage> with SingleTickerProviderStateMixin {
  final AudioRecorder _audioRecorder = AudioRecorder();

  bool _isRecording = false;
  late AnimationController _waveController;
  late Animation<double> _waveAnimation;
  String? _filePath;

  @override
  void initState() {
    super.initState();
    // Setup Animasi Gelombang
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _waveAnimation = Tween(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(parent: _waveController, curve: Curves.linear),
    );

    // Panggil Data Awal
    Future.delayed(Duration.zero, () {
      context.read<ExerciseLevelBloc>().add(GetExerciseLevelEvent(levelId: widget.levelId));
    });
  }

  @override
  void dispose() {
    _waveController.dispose();
    _audioRecorder.dispose();
    super.dispose();
  }

  Future<void> _toggleRecording() async {
    try {
      if (_isRecording) {
        // --- STOP RECORDING ---
        final path = await _audioRecorder.stop();

        setState(() {
          _isRecording = false;
          _filePath = path;
        });

        if (path != null) {
          final file = File(path);
          // Validasi file ada
          if (await file.exists()) {
            print("File size: ${await file.length()} bytes");
            if (mounted) {
              // Kirim ke Bloc untuk diupload
              context.read<ExerciseLevelBloc>().add(PostAITranscribe(filePath: path));
            }
          }
        }
      } else {
        // --- START RECORDING ---
        if (await _audioRecorder.hasPermission()) {
          final Directory tempDir = await getTemporaryDirectory();
          final String audioPath = p.join(
              tempDir.path,
              'audio_${DateTime.now().millisecondsSinceEpoch}.m4a'
          );

          await _audioRecorder.start(
              const RecordConfig(encoder: AudioEncoder.aacLc),
              path: audioPath
          );

          setState(() {
            _isRecording = true;
            _filePath = null;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Izin mikrofon diperlukan.")),
          );
        }
      }
    } catch (e) {
      print("Error recording: $e");
      setState(() => _isRecording = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
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
        title: BlocBuilder<ExerciseLevelBloc, ExerciseLevelState>(
          builder: (context, state) {
            if (state is ExerciseLevelSuccess && state.exerciseLevel.isNotEmpty) {
              // Menampilkan Level berdasarkan order soal saat ini
              final idx = state.currentIndex;
              // Safety check index range
              if (idx < state.exerciseLevel.length) {
                return Text(
                  'Level ${state.exerciseLevel[idx].order}',
                  style: tsBodyLargeMedium(AppColor.textPrimary),
                );
              }
            }
            return Text('Latihan', style: tsBodyLargeMedium(AppColor.textPrimary));
          },
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<ExerciseLevelBloc, ExerciseLevelState>(
        listener: (context, state) {
          // JIKA SELESAI -> PINDAH HALAMAN
          if (state is ExerciseLevelFinished) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ExerciseResultPage()),
            );
          }
          if (state is ExerciseLevelFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          // LOADING
          if (state is ExerciseLevelLoading) {
            return Center(child: CircularProgressIndicator(color: AppColor.primary));
          }

          // FAILURE
          if (state is ExerciseLevelFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: AppColor.error),
                  const SizedBox(height: 16),
                  Text("Terjadi Kesalahan", style: tsBodyMediumRegular(AppColor.textSecondary)),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ExerciseLevelBloc>().add(GetExerciseLevelEvent(levelId: widget.levelId));
                    },
                    child: const Text("Coba Lagi"),
                  )
                ],
              ),
            );
          }

          // SUCCESS
          if (state is ExerciseLevelSuccess) {
            final exercises = state.exerciseLevel;

            if (exercises.isEmpty) {
              return const Center(child: Text("Data latihan kosong."));
            }

            // Ambil data berdasarkan index saat ini
            final currentIndex = state.currentIndex;

            // Hindari error range jika index berlebih (defensive coding)
            if (currentIndex >= exercises.length) {
              return const Center(child: CircularProgressIndicator());
            }

            final currentExercise = exercises[currentIndex];

            return Stack(
              children: [
                // Animasi Gelombang
                Positioned(
                  left: 0, right: 0,
                  top: MediaQuery.of(context).size.height * 0.378,
                  child: AnimatedBuilder(
                    animation: _waveAnimation,
                    builder: (context, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          final delay = index * 0.2;
                          final animValue = (_waveAnimation.value - delay).clamp(0.0, 1.0);
                          final scale = _isRecording ? 1 + (0.5 * (1 - (animValue - 0.5).abs() * 2)) : 1.0;
                          return Transform.scale(
                            scale: scale,
                            child: Container(
                              width: 6, height: 20.0,
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              decoration: BoxDecoration(color: AppColor.primary, borderRadius: BorderRadius.circular(3)),
                            ),
                          );
                        }),
                      );
                    },
                  ),
                ),

                // Konten Utama
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      _buildProgressBar(exercises.length, currentIndex),
                      const Spacer(),
                      _buildInstructionText(currentExercise.instruction),
                      const SizedBox(height: 16),
                      // Teks Soal (Pa, Ba, Ta, dst)
                      _buildWordText(currentExercise.speechText),
                      const SizedBox(height: 140),
                      _buildMicrophoneButton(),
                      const SizedBox(height: 40),
                      _buildHintCard(),
                      const Spacer(),
                    ],
                  ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildProgressBar(int totalExercises, int currentIndex) {
    final progress = (currentIndex + 1) / totalExercises;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${currentIndex + 1} / $totalExercises',
          style: tsBodyMediumMedium(AppColor.textSecondary),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: AppColor.grayLight,
            valueColor: AlwaysStoppedAnimation<Color>(AppColor.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildInstructionText(String instruction) {
    return Text(instruction, style: tsBodyMediumRegular(AppColor.textSecondary), textAlign: TextAlign.center);
  }

  Widget _buildWordText(String speechText) {
    return Text(speechText, style: tsHeadingLargeBold(AppColor.textPrimary), textAlign: TextAlign.center);
  }

  Widget _buildMicrophoneButton() {
    return GestureDetector(
      onTap: _toggleRecording,
      child: Container(
        width: 120, height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _isRecording ? AppColor.silver : AppColor.primary,
          boxShadow: [
            BoxShadow(color: AppColor.primary.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 8)),
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
      decoration: BoxDecoration(color: AppColor.primaryLight, borderRadius: BorderRadius.circular(12)),
      child: Text('Baca dengan perlahan dan jelas', style: tsBodyMediumMedium(AppColor.primaryDark), textAlign: TextAlign.center),
    );
  }
}