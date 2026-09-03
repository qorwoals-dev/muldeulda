import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../models/celebrity_data.dart';
import '../models/season_palette.dart';
import '../widgets/app_background.dart';
import 'capture_screen.dart';
import 'result_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('PERSONAL COLOR DIAGNOSIS', style: AppText.label(color: AppColors.gold)),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text('ChakTone', style: AppText.display(size: 40)),
                            const SizedBox(width: 10),
                            Text('착톤', style: AppText.body(size: 13, weight: FontWeight.w700)),
                          ],
                        ),
                        const SizedBox(height: 28),
                        SizedBox(
                          height: 132,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              _seasonBar('봄', SeasonData.springWarm.bestColors.first.color, 60),
                              const SizedBox(width: 10),
                              _seasonBar('여름', SeasonData.summerCool.bestColors.first.color, 92),
                              const SizedBox(width: 10),
                              _seasonBar('가을', SeasonData.autumnWarm.bestColors.first.color, 44),
                              const SizedBox(width: 10),
                              _seasonBar('겨울', SeasonData.winterCool.bestColors.first.color, 76),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        Text('나에게 스며드는\n색을 찾아드려요', style: AppText.display(size: 30)),
                        const SizedBox(height: 14),
                        Text(
                          '얼굴 사진 한 장으로 피부, 눈동자, 머리색에 맞는 퍼스널 컬러를 '
                          '진단하고, 어울리는 색과 피해야 할 색을 알려드립니다.',
                          style: AppText.body(size: 14),
                        ),
                        const Spacer(),
                        const SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => const CaptureScreen()),
                            );
                          },
                          child: const Text('진단 시작하기'),
                        ),
                        const SizedBox(height: 10),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ResultScreen(
                                  palette: SeasonData.autumnWarm,
                                  celebrities: CelebrityData.pickRandom(SeasonData.autumnWarm.id, count: 3),
                                ),
                              ),
                            );
                          },
                          child: const Text('예시 결과 보기'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _seasonBar(String label, Color color, double barHeight) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: barHeight,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
            ),
          ),
          const SizedBox(height: 8),
          Text(label, style: AppText.label(size: 10)),
        ],
      ),
    );
  }
}
