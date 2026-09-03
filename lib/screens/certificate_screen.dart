import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../models/celebrity_data.dart';
import '../models/season_palette.dart';
import '../services/certificate_service.dart';
import '../theme/app_theme.dart';
import '../widgets/app_background.dart';
import '../widgets/section_label.dart';

class CertificateScreen extends StatelessWidget {
  final SeasonPalette palette;
  final List<Celebrity> celebrities;
  const CertificateScreen({super.key, required this.palette, this.celebrities = const []});

  void _copyLink(BuildContext context, String url) {
    Clipboard.setData(ClipboardData(text: url));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('링크를 복사했어요')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final issuedOn =
        '${now.year}.${now.month.toString().padLeft(2, '0')}.${now.day.toString().padLeft(2, '0')}';
    final celebrity = celebrities.isNotEmpty ? celebrities.first : null;
    final certificateUrl = CertificateService.buildCertificateUrl(palette, now, celebrity: celebrity);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      extendBodyBehindAppBar: true,
      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 4, 24, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('진단서', style: AppText.label()),
                const SizedBox(height: 6),
                Text('나의 퍼스널 컬러 진단서', style: AppText.display(size: 22)),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.line),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.ink.withValues(alpha: 0.05),
                        blurRadius: 24,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('ChakTone', style: AppText.display(size: 16)),
                          Text(issuedOn, style: AppText.label(size: 11)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Container(height: 1, color: AppColors.line),
                      const SizedBox(height: 18),
                      Text('PERSONAL COLOR', style: AppText.label(color: AppColors.gold)),
                      const SizedBox(height: 4),
                      Text(palette.title, style: AppText.display(size: 26)),
                      const SizedBox(height: 10),
                      Text(palette.description, style: AppText.body(size: 12.5)),
                      const SizedBox(height: 20),
                      const SectionLabel('베스트 컬러'),
                      _chipWrap(palette.bestColors),
                      const SizedBox(height: 16),
                      const SectionLabel('추천 헤어컬러'),
                      _chipWrap(palette.hairColors),
                      const SizedBox(height: 16),
                      const SectionLabel('추천 립컬러'),
                      _chipWrap(palette.lipColors),
                      const SizedBox(height: 16),
                      const SectionLabel('추천 블러셔'),
                      _chipWrap(palette.blushColors),
                      const SizedBox(height: 16),
                      const SectionLabel('추천 아이섀도우'),
                      _chipWrap(palette.eyeshadowColors),
                      const SizedBox(height: 16),
                      const SectionLabel('추천 액세서리'),
                      const SizedBox(height: 8),
                      Text(palette.metalRecommendation, style: AppText.body(size: 12.5, weight: FontWeight.w700, color: AppColors.ink)),
                      if (celebrity != null) ...[
                        const SizedBox(height: 16),
                        const SectionLabel('컬러 트윈'),
                        const SizedBox(height: 8),
                        Text(
                          '${celebrity.name} · ${celebrity.matchScore()}% 매칭',
                          style: AppText.body(size: 12.5, weight: FontWeight.w700, color: AppColors.ink),
                        ),
                      ],
                      const SizedBox(height: 16),
                      const SectionLabel('피해야 할 컬러'),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          for (final c in palette.avoidColors)
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(right: 8),
                                height: 26,
                                decoration: BoxDecoration(
                                  color: c.withValues(alpha: 0.45),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.line),
                    ),
                    child: QrImageView(
                      data: certificateUrl,
                      size: 200,
                      eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.square, color: AppColors.ink),
                      dataModuleStyle: const QrDataModuleStyle(dataModuleShape: QrDataModuleShape.square, color: AppColors.ink),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  '다른 사람이 이 QR을 스캔하면 진단서를 확인하고 이미지를 다운로드할 수 있어요',
                  textAlign: TextAlign.center,
                  style: AppText.body(size: 12),
                ),
                const SizedBox(height: 14),
                OutlinedButton(
                  onPressed: () => _copyLink(context, certificateUrl),
                  child: const Text('링크 복사하기'),
                ),
                const SizedBox(height: 18),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                    style: TextButton.styleFrom(foregroundColor: AppColors.inkSoft),
                    child: Text(
                      '처음부터 다시 진단하기',
                      style: AppText.body(size: 12.5, weight: FontWeight.w700, color: AppColors.inkSoft)
                          .copyWith(decoration: TextDecoration.underline, decorationColor: AppColors.inkSoft),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _chipWrap(List<PaletteColor> swatches) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [for (final c in swatches) _chip(c.name, c.color)],
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
