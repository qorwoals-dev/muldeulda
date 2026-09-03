import 'package:flutter_test/flutter_test.dart';
import 'package:muldeulda/services/color_analyzer_web.dart';

// LAB 변환 + 4계절 분류 로직(color_analyzer_web.dart)은 io/web 양쪽에서
// 공유해서 쓰는 순수 로직이라 여기서 직접 검증한다. ML Kit 기반 실제 얼굴
// 인식 경로(color_analyzer_io.dart)는 네이티브 플랫폼 채널이 필요해 유닛
// 테스트로는 검증할 수 없고, 에뮬레이터/실기에서 수동으로 확인했다.
void main() {
  final cases = <String, List<int>>{
    'light warm peach (spring warm expected)': [240, 190, 150],
    'deep warm tan (autumn warm expected)': [150, 105, 70],
    'light cool pink (summer cool expected)': [225, 185, 180],
    'deep cool rosy-brown (winter cool expected)': [140, 100, 100],
  };

  final expected = <String, String>{
    'light warm peach (spring warm expected)': 'spring_warm',
    'deep warm tan (autumn warm expected)': 'autumn_warm',
    'light cool pink (summer cool expected)': 'summer_cool',
    'deep cool rosy-brown (winter cool expected)': 'winter_cool',
  };

  for (final entry in cases.entries) {
    test(entry.key, () {
      final result = classifyFromRgb(
        entry.value[0].toDouble(),
        entry.value[1].toDouble(),
        entry.value[2].toDouble(),
      );
      expect(result.id, expected[entry.key]);
    });
  }
}
