import 'dart:math' as math;
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../models/celebrity_data.dart';
import '../models/season_palette.dart';
import '../theme/app_theme.dart';
import '../widgets/app_background.dart';
import '../widgets/celebrity_match_card.dart';
import '../widgets/section_label.dart';
import 'detail_screen.dart';

class ResultScreen extends StatefulWidget {
  final SeasonPalette palette;
  final Uint8List? imageBytes;
  final List<Celebrity> celebrities;

  const ResultScreen({
    super.key,
    required this.palette,
    this.imageBytes,
    this.celebrities = const [],
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = widget.palette;
    final ringColors = palette.bestColors.take(4).toList();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('RESULT', style: AppText.label(color: AppColors.gold)),
              const SizedBox(height: 8),
              Text(palette.title, style: AppText.display(size: 30)),
              const SizedBox(height: 8),
              Text(palette.description, style: AppText.body(size: 13.5)),
              const SizedBox(height: 26),
              SizedBox(
                height: 210,
                child: Center(
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 172,
                          height: 172,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.gold.withValues(alpha: 0.28), width: 1),
                          ),
                        ),
                        for (int i = 0; i < ringColors.length; i++)
                          _ringSwatch(i, ringColors.length, ringColors[i].color),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const SectionLabel('베스트 컬러'),
              const SizedBox(height: 10),
              Row(
                children: [
                  for (final c in palette.bestColors)
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        height: 38,
                        decoration: BoxDecoration(
                          color: c.color,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                ],
              ),
              if (widget.celebrities.isNotEmpty) ...[
                const SizedBox(height: 28),
                CelebrityMatchCard(
                  celebrity: widget.celebrities.first,
                  others: widget.celebrities.skip(1).toList(),
                ),
              ],
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => DetailScreen(palette: palette, celebrities: widget.celebrities),
                    ),
                  );
                },
                child: const Text('내 컬러 카드 보기'),
              ),
            ],
          ),
          ),
        ),
      ),
    );
  }

  /// 중앙에서 퍼져나가듯 등장하는, 이 화면에서만 쓰는 단 하나의 연출 모먼트.
  Widget _ringSwatch(int index, int total, Color color) {
    final angle = (index / total) * 2 * math.pi;
    const radius = 68.0;
    final dx = radius * math.cos(angle);
    final dy = radius * math.sin(angle);

    final delay = index * 0.12;
    final curved = CurvedAnimation(
      parent: _controller,
      curve: Interval(delay.clamp(0.0, 1.0), 1.0, curve: Curves.easeOutBack),
    );

    return AnimatedBuilder(
      animation: curved,
      builder: (context, child) {
        final t = curved.value.clamp(0.0, 1.0);
        return Transform.translate(
          offset: Offset(dx * t, dy * t),
          child: Opacity(
            opacity: t,
            child: Transform.scale(scale: 0.6 + 0.4 * t, child: child),
          ),
        );
      },
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.canvas, width: 3),
        ),
      ),
    );
  }
}
