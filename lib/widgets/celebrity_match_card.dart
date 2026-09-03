import 'package:flutter/material.dart';

import '../models/celebrity_data.dart';
import '../theme/app_theme.dart';

/// 결과/진단서 화면에서 쓰는 "컬러 트윈" 연예인 공개 카드.
/// 재미 요소이므로 얼굴이 닮았다는 게 아니라 "같은 컬러 타입"이라는 걸
/// 분명히 하는 문구를 쓴다.
class CelebrityMatchCard extends StatelessWidget {
  final Celebrity celebrity;
  final List<Celebrity> others;

  const CelebrityMatchCard({super.key, required this.celebrity, this.others = const []});

  @override
  Widget build(BuildContext context) {
    final score = celebrity.matchScore();
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.canvasDim,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.gold),
              ),
              const SizedBox(width: 8),
              Text('COLOR TWIN', style: AppText.label(color: AppColors.gold)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(child: Text(celebrity.name, style: AppText.display(size: 23))),
              Text(
                '$score%',
                style: AppText.display(size: 23, weight: FontWeight.w600).copyWith(color: AppColors.accent),
              ),
            ],
          ),
          if (celebrity.subtype != null) ...[
            const SizedBox(height: 4),
            Text('세부 톤 · ${celebrity.subtype}', style: AppText.body(size: 12)),
          ],
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: score / 100,
              minHeight: 6,
              backgroundColor: AppColors.line,
              valueColor: const AlwaysStoppedAnimation(AppColors.accent),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '${celebrity.name} 님과 같은 컬러 타입이에요. 얼굴이 닮았다는 뜻이 아니라 '
            '어울리는 색의 결이 같다는 재미로 보는 지수예요.',
            style: AppText.body(size: 11.5),
          ),
          if (others.isNotEmpty) ...[
            const SizedBox(height: 14),
            Text('이 컬러 타입의 다른 스타', style: AppText.label(size: 11)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [for (final o in others) _chip(o.name)],
            ),
          ],
        ],
      ),
    );
  }

  Widget _chip(String name) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.line),
      ),
      child: Text(name, style: AppText.body(size: 11.5, weight: FontWeight.w600, color: AppColors.ink)),
    );
  }
}
