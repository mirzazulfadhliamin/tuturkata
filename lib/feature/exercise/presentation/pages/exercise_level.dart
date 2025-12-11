import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
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
  String _hintBaseText = 'Baca dengan perlahan dan jelas';
  String _typingText = '';
  Timer? _typingTimer;
  
  // TTS player
  // You may need to add audioplayers in pubspec.yaml
  late final AudioPlayer _ttsPlayer;

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

    // Init TTS player
    _ttsPlayer = AudioPlayer();

    // Panggil Data Awal
    Future.delayed(Duration.zero, () {
      context.read<ExerciseLevelBloc>().add(GetExerciseLevelEvent(levelId: widget.levelId));
    });
  }

  @override
  void dispose() {
    _waveController.dispose();
    _audioRecorder.dispose();
    _typingTimer?.cancel();
    _ttsPlayer.dispose();
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
          // Feedback: mulai animasi typing dan play TTS jika ada
          if (state is ExerciseLevelValidatedFeedback) {
            final feedback = state.feedbackMessage;
            _startTyping(feedback);
            if (state.ttsUrl != null && state.ttsUrl!.isNotEmpty) {
              _playTTS(state.ttsUrl!);
            }
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

          // SUCCESS (default)
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
                      _buildHintCard(_hintBaseText),
                      const Spacer(),
                    ],
                  ),
                ),
              ],
            );
          }
          // VALIDATED SUCCESS (complete)
          if (state is ExerciseLevelValidatedSuccess) {
            final exercises = state.exerciseLevel;

            final currentIndex = state.currentIndex;
            if (currentIndex >= exercises.length) {
              return const Center(child: CircularProgressIndicator());
            }
            final currentExercise = exercises[currentIndex];

            return Stack(
              children: [
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

                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      _buildProgressBar(exercises.length, currentIndex),
                      const Spacer(),
                      _buildInstructionText(currentExercise.instruction),
                      const SizedBox(height: 16),
                      _buildWordText(currentExercise.speechText),
                      const SizedBox(height: 140),
                      _buildMicrophoneButton(),
                      const SizedBox(height: 24),
                      _buildSuccessContainer(onNext: () {
                        context.read<ExerciseLevelBloc>().add(ProceedToNextQuizEvent());
                        // Reset hint typing
                        _typingTimer?.cancel();
                        setState(() { _typingText = ''; _hintBaseText = 'Baca dengan perlahan dan jelas'; });
                      }),
                      const SizedBox(height: 16),
                      _buildHintCard(_hintBaseText),
                      const Spacer(),
                    ],
                  ),
                ),
              ],
            );
          }

          // VALIDATED FEEDBACK (message bukan complete)
          if (state is ExerciseLevelValidatedFeedback) {
            final exercises = state.exerciseLevel;

            final currentIndex = state.currentIndex;
            if (currentIndex >= exercises.length) {
              return const Center(child: CircularProgressIndicator());
            }
            final currentExercise = exercises[currentIndex];

            final displayed = _typingText.isNotEmpty ? _typingText : state.feedbackMessage;

            return Stack(
              children: [
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

                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      _buildProgressBar(exercises.length, currentIndex),
                      const Spacer(),
                      _buildInstructionText(currentExercise.instruction),
                      const SizedBox(height: 16),
                      _buildWordText(currentExercise.speechText),
                      const SizedBox(height: 140),
                      _buildMicrophoneButton(),
                      const SizedBox(height: 24),
                      _buildHintCard(displayed),
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

  Widget _buildHintCard(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(color: AppColor.primaryLight, borderRadius: BorderRadius.circular(12)),
      child: Text(text, style: tsBodyMediumMedium(AppColor.primaryDark), textAlign: TextAlign.center),
    );
  }

  Widget _buildSuccessContainer({required VoidCallback onNext}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade400),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Icon(Icons.check_circle, color: Colors.green.shade600),
            const SizedBox(width: 8),
            Text('Bagus! Kamu berhasil.', style: tsBodyMediumMedium(Colors.green.shade800)),
          ]),
          ElevatedButton(
            onPressed: onNext,
            style: ElevatedButton.styleFrom(backgroundColor: AppColor.primary),
            child: const Text('Lanjut'),
          ),
        ],
      ),
    );
  }

  void _startTyping(String fullText) {
    _typingTimer?.cancel();
    setState(() {
      _typingText = '';
      _hintBaseText = '';
    });
    int i = 0;
    _typingTimer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      if (i <= fullText.length) {
        setState(() {
          _typingText = fullText.substring(0, i);
        });
        i++;
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> _playTTS(String url) async {
    try {
      await _ttsPlayer.stop();
      await _ttsPlayer.play(UrlSource(url));
    } catch (e) {
      // ignore playback errors
    }
  }
}