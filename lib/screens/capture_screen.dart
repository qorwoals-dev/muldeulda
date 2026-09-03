import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../theme/app_theme.dart';
import '../widgets/app_background.dart';
import 'analyzing_screen.dart';

class CaptureScreen extends StatelessWidget {
  const CaptureScreen({super.key});

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    final XFile? file = await picker.pickImage(
      source: source,
      maxWidth: 1024,
      imageQuality: 85,
    );
    if (file == null || !context.mounted) return;

    final Uint8List bytes = await file.readAsBytes();
    if (!context.mounted) return;

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => AnalyzingScreen(imageBytes: bytes, imagePath: file.path)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      extendBodyBehindAppBar: true,
      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 4, 24, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('STEP 1 / 촬영', style: AppText.label(color: AppColors.inkSoft)),
                const SizedBox(height: 8),
                Text('정면 사진을 촬영해주세요', style: AppText.display(size: 22)),
                const SizedBox(height: 24),
                const SizedBox(height: 260, child: _Viewfinder()),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.canvasDim,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _GuideTip(icon: Icons.wb_sunny_outlined, text: '자연광이 드는 창가에서 촬영해주세요'),
                      SizedBox(height: 10),
                      _GuideTip(icon: Icons.face_retouching_off_outlined, text: '화장기 없는 맨 얼굴이 가장 정확해요'),
                      SizedBox(height: 10),
                      _GuideTip(icon: Icons.center_focus_strong_outlined, text: '정면을 응시하고 촬영해주세요'),
                      SizedBox(height: 10),
                      _GuideTip(icon: Icons.crop_square_outlined, text: '무지 배경일수록 진단이 정확해져요'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _pickImage(context, ImageSource.camera),
                  child: const Text('촬영하기'),
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () => _pickImage(context, ImageSource.gallery),
                  child: const Text('갤러리에서 선택'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 사진 대신 카메라 뷰파인더처럼 코너 브래킷으로 얼굴 위치를 안내한다.
class _Viewfinder extends StatelessWidget {
  const _Viewfinder();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFC9BEA9), width: 1),
            borderRadius: BorderRadius.circular(140),
          ),
        ),
        Container(
          width: 148,
          height: 188,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.accent.withValues(alpha: 0.32), width: 1.4),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        const Positioned(top: 28, left: 28, child: _CornerBracket(_Corner.tl)),
        const Positioned(top: 28, right: 28, child: _CornerBracket(_Corner.tr)),
        const Positioned(bottom: 28, left: 28, child: _CornerBracket(_Corner.bl)),
        const Positioned(bottom: 28, right: 28, child: _CornerBracket(_Corner.br)),
      ],
    );
  }
}

enum _Corner { tl, tr, bl, br }

class _CornerBracket extends StatelessWidget {
  final _Corner corner;
  const _CornerBracket(this.corner);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: const Size(18, 18), painter: _BracketPainter(corner));
  }
}

class _BracketPainter extends CustomPainter {
  final _Corner corner;
  _BracketPainter(this.corner);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.gold
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final path = Path();
    switch (corner) {
      case _Corner.tl:
        path.moveTo(0, size.height);
        path.lineTo(0, 0);
        path.lineTo(size.width, 0);
        break;
      case _Corner.tr:
        path.moveTo(0, 0);
        path.lineTo(size.width, 0);
        path.lineTo(size.width, size.height);
        break;
      case _Corner.bl:
        path.moveTo(0, 0);
        path.lineTo(0, size.height);
        path.lineTo(size.width, size.height);
        break;
      case _Corner.br:
        path.moveTo(size.width, 0);
        path.lineTo(size.width, size.height);
        path.lineTo(0, size.height);
        break;
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _BracketPainter oldDelegate) => oldDelegate.corner != corner;
}

class _GuideTip extends StatelessWidget {
  final IconData icon;
  final String text;
  const _GuideTip({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: AppColors.accent),
        const SizedBox(width: 10),
        Expanded(child: Text(text, style: AppText.body(size: 12.5))),
      ],
    );
  }
}
