import 'package:flutter/material.dart';

import '../models/celebrity_data.dart';
import '../models/season_palette.dart';
import '../theme/app_theme.dart';
import '../widgets/app_background.dart';
import '../widgets/celebrity_match_card.dart';
import '../widgets/section_label.dart';
import 'certificate_screen.dart';

class DetailScreen extends StatelessWidget {
  final SeasonPalette palette;
  final List<Celebrity> celebrities;
  const DetailScreen({super.key, required this.palette, this.celebrities = const []});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      extendBodyBehindAppBar: true,
      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 4, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('MY PALETTE', style: AppText.label()),
                const SizedBox(height: 6),
                Text('${palette.title} 컬러 카드', style: AppText.display(size: 22)),
                const SizedBox(height: 18),
                const SectionLabel('베스트 컬러'),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final c in palette.bestColors)
                      _chip(c.name, c.color),
                  ],
                ),
                const Divider(height: 40),
                const SectionLabel('추천 헤어컬러'),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final c in palette.hairColors)
                      _chip(c.name, c.color),
                  ],
                ),
                const SizedBox(height: 20),
                const SectionLabel('추천 립컬러'),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final c in palette.lipColors)
                      _chip(c.name, c.color),
                  ],
                ),
                const SizedBox(height: 20),
                const SectionLabel('추천 블러셔'),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final c in palette.blushColors)
                      _chip(c.name, c.color),
                  ],
                ),
                const SizedBox(height: 20),
                const SectionLabel('추천 아이섀도우'),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final c in palette.eyeshadowColors)
                      _chip(c.name, c.color),
                  ],
                ),
                const SizedBox(height: 20),
                const SectionLabel('추천 액세서리'),
                const SizedBox(height: 10),
                Text(
                  palette.metalRecommendation,
                  style: AppText.body(size: 13, weight: FontWeight.w700, color: AppColors.ink),
                ),
                const Divider(height: 40),
                const SectionLabel('피해야 할 컬러'),
                const SizedBox(height: 10),
                Row(
                  children: [
                    for (final c in palette.avoidColors)
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          height: 30,
                          decoration: BoxDecoration(
                            color: c.withValues(alpha: 0.45),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                  ],
                ),
                if (celebrities.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  CelebrityMatchCard(
                    celebrity: celebrities.first,
                    others: celebrities.skip(1).toList(),
                  ),
                ],
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => CertificateScreen(palette: palette, celebrities: celebrities),
                      ),
                    );
                  },
                  child: const Text('진단서 QR 발급받기'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _chip(String name, Color color) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 12, 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(name, style: AppText.body(size: 11.5, weight: FontWeight.w600, color: AppColors.ink)),
        ],
      ),
    );
  }
}
