import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// 모든 화면의 배경에 공통으로 쓰는 은은한 그라디언트 래퍼.
class AppBackground extends StatelessWidget {
  final Widget child;
  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(gradient: appBackgroundGradient),
      child: child,
    );
  }
}
