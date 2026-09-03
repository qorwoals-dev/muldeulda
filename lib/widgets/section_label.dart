import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// 골드 틱 마크 + 라벨. 본문 안 소제목에 쓰는 절제된 구분 표식으로,
/// 카드/배지 같은 장식 없이 얇은 선 하나로 리듬을 만든다.
class SectionLabel extends StatelessWidget {
  final String text;
  const SectionLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 14, height: 1.4, color: AppColors.gold),
        const SizedBox(width: 8),
        Text(text, style: AppText.label()),
      ],
    );
  }
}
