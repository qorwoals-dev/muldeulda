import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../models/celebrity_data.dart';
import '../models/season_palette.dart';
import '../services/color_analyzer.dart';
import '../services/face_analysis_exception.dart';
import '../theme/app_theme.dart';
import '../widgets/app_background.dart';
import 'result_screen.dart';

class AnalyzingScreen extends StatefulWidget {
  final Uint8List imageBytes;
  final String? imagePath;
  const AnalyzingScreen({super.key, required this.imageBytes, this.imagePath});

  @override
  State<AnalyzingScreen> createState() => _AnalyzingScreenState();
}

class _AnalyzingScreenState extends State<AnalyzingScreen> {
  String? _error;

  @override
  void initState() {
    super.initState();
    _run();
  }

  Future<void> _run() async {
    try {
      // 최소한의 연출 시간을 위한 지연 + 실제 분석을 동시에 진행
      final results = await Future.wait([
        ColorAnalyzer.analyze(widget.imageBytes, imagePath: widget.imagePath),
        Future.delayed(const Duration(milliseconds: 1400)),
      ]);
      final palette = results[0] as SeasonPalette;
      final celebrities = CelebrityData.pickRandom(palette.id, count: 3);

      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            palette: palette,
            imageBytes: widget.imageBytes,
            celebrities: celebrities,
          ),
        ),
      );
    } on NoFaceDetectedException {
      if (!mounted) return;
      setState(() => _error = '사진에서 얼굴을 찾지 못했어요.\n정면이 잘 보이도록 다시 촬영해주세요.');
    } catch (e, st) {
      debugPrint('ColorAnalyzer failed: $e\n$st');
      if (!mounted) return;
      setState(() => _error = '분석 중 문제가 생겼어요.\n($e)');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackground(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: _error != null ? _errorView() : _loadingView(),
          ),
        ),
      ),
    );
  }

  Widget _loadingView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          width: 34,
          height: 34,
          child: CircularProgressIndicator(
            strokeWidth: 2.4,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(height: 22),
        Text(
          '피부와 어울리는 색을\n분석하고 있어요',
          textAlign: TextAlign.center,
          style: AppText.display(size: 18),
        ),
      ],
    );
  }

  Widget _errorView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.face_retouching_off_outlined, size: 32, color: AppColors.accent),
        const SizedBox(height: 18),
        Text(
          _error!,
          textAlign: TextAlign.center,
          style: AppText.display(size: 18),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('다시 촬영하기'),
        ),
      ],
    );
  }
}
