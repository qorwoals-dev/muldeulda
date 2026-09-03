import 'package:flutter/material.dart';

/// 퍼스널 컬러 4계절 타입 하나를 표현하는 모델.
class SeasonPalette {
  final String id;
  final String title; // 예: "가을 웜톤"
  final String nickname; // 예: "고급스러운 앤틱 갈웜" — 진단서용 재미 요소
  final String description;
  final List<PaletteColor> bestColors;
  final List<Color> avoidColors;
  final List<PaletteColor> hairColors;
  final List<PaletteColor> lipColors;
  final List<PaletteColor> blushColors;
  final List<PaletteColor> eyeshadowColors;
  final String metalRecommendation; // 예: "골드 액세서리"

  const SeasonPalette({
    required this.id,
    required this.title,
    required this.nickname,
    required this.description,
    required this.bestColors,
    required this.avoidColors,
    required this.hairColors,
    required this.lipColors,
    required this.blushColors,
    required this.eyeshadowColors,
    required this.metalRecommendation,
  });
}

/// 이름이 붙은 컬러 스와치 (컬러 카드에 표시되는 칩 용도).
class PaletteColor {
  final String name;
  final Color color;
  const PaletteColor(this.name, this.color);
}

/// 데모용 4계절 퍼스널 컬러 데이터.
/// 실제 서비스에서는 이미지 분석 결과에 따라 이 중 하나를 선택하거나
/// 별도의 진단 모델 결과로 대체한다.
class SeasonData {
  SeasonData._();

  static const springWarm = SeasonPalette(
    id: 'spring_warm',
    title: '봄 웜톤',
    nickname: '화사한 비타민 봄웜',
    description: '화사하고 생기 있는 색이 피부를 밝고 화사하게 보이게 해요. '
        '따뜻한 코랄과 밝은 옐로 계열이 특히 잘 어울려요.',
    bestColors: [
      PaletteColor('코랄', Color(0xFFFF8B66)),
      PaletteColor('피치', Color(0xFFFFC9A8)),
      PaletteColor('라이트 옐로', Color(0xFFF3D26B)),
      PaletteColor('민트', Color(0xFF8FCBA6)),
    ],
    avoidColors: [
      Color(0xFF3B4C9E),
      Color(0xFF4A4A52),
      Color(0xFF8A6BB0),
    ],
    hairColors: [
      PaletteColor('허니 브라운', Color(0xFFB98750)),
      PaletteColor('라이트 브라운', Color(0xFFC79A6B)),
    ],
    lipColors: [
      PaletteColor('코랄 립', Color(0xFFE8785A)),
      PaletteColor('피치 립', Color(0xFFF0A67E)),
    ],
    blushColors: [
      PaletteColor('코랄 블러셔', Color(0xFFFF9A76)),
      PaletteColor('피치 블러셔', Color(0xFFFFBFA0)),
    ],
    eyeshadowColors: [
      PaletteColor('골드 브론즈', Color(0xFFD9A441)),
      PaletteColor('피치 브라운', Color(0xFFC79A6B)),
    ],
    metalRecommendation: '골드 액세서리',
  );

  static const summerCool = SeasonPalette(
    id: 'summer_cool',
    title: '여름 쿨톤',
    nickname: '우아한 파스텔 여쿨',
    description: '부드럽고 차분한 파스텔 톤이 잘 어울려요. '
        '뿌옇고 은은한 쿨 컬러가 피부를 맑아 보이게 해요.',
    bestColors: [
      PaletteColor('더스티 블루', Color(0xFF93A8C9)),
      PaletteColor('라벤더', Color(0xFFC9B8D8)),
      PaletteColor('로즈 핑크', Color(0xFFDB9CAE)),
      PaletteColor('소프트 그레이', Color(0xFFB7B4B0)),
    ],
    avoidColors: [
      Color(0xFFE0A421),
      Color(0xFFB5723A),
      Color(0xFF8C3B1B),
    ],
    hairColors: [
      PaletteColor('애쉬 브라운', Color(0xFF8D7A70)),
      PaletteColor('그레이시 브라운', Color(0xFF9C8E85)),
    ],
    lipColors: [
      PaletteColor('로즈 핑크 립', Color(0xFFC97E92)),
      PaletteColor('모브 립', Color(0xFFB98CA0)),
    ],
    blushColors: [
      PaletteColor('로즈 블러셔', Color(0xFFD8A8B5)),
      PaletteColor('라벤더 블러셔', Color(0xFFC9B8D8)),
    ],
    eyeshadowColors: [
      PaletteColor('그레이 라벤더', Color(0xFFB7A8C0)),
      PaletteColor('로즈 브라운', Color(0xFFA98A90)),
    ],
    metalRecommendation: '실버 액세서리',
  );

  static const autumnWarm = SeasonPalette(
    id: 'autumn_warm',
    title: '가을 웜톤',
    nickname: '고급스러운 앤틱 갈웜',
    description: '차분하고 깊이감 있는 색이 피부톤을 환하게 밝혀줘요. '
        '골드빛이 도는 웜한 색상이 특히 잘 어울려요.',
    bestColors: [
      PaletteColor('테라코타', Color(0xFFA6693A)),
      PaletteColor('모스그린', Color(0xFF7C7A4A)),
      PaletteColor('머스터드', Color(0xFFD9A441)),
      PaletteColor('캐멀', Color(0xFFC98B4B)),
    ],
    avoidColors: [
      Color(0xFF3B4C9E),
      Color(0xFFB8235B),
      Color(0xFF93A8C9),
    ],
    hairColors: [
      PaletteColor('다크 브라운', Color(0xFF4A362A)),
      PaletteColor('초코 브라운', Color(0xFF5C4331)),
    ],
    lipColors: [
      PaletteColor('테라코타 립', Color(0xFFB05A34)),
      PaletteColor('브릭 레드 립', Color(0xFF9C4A2E)),
    ],
    blushColors: [
      PaletteColor('브릭 블러셔', Color(0xFFB26A4A)),
      PaletteColor('테라코타 블러셔', Color(0xFFC17847)),
    ],
    eyeshadowColors: [
      PaletteColor('카키 브론즈', Color(0xFF7C7A4A)),
      PaletteColor('캐멀 브라운', Color(0xFFA6693A)),
    ],
    metalRecommendation: '골드 액세서리',
  );

  static const winterCool = SeasonPalette(
    id: 'winter_cool',
    title: '겨울 쿨톤',
    nickname: '시크한 모노톤 겨쿨',
    description: '선명하고 또렷한 색이 피부와 또렷한 대비를 이뤄요. '
        '깊은 사파이어와 비비드한 마젠타가 잘 어울려요.',
    bestColors: [
      PaletteColor('사파이어', Color(0xFF3B4C9E)),
      PaletteColor('마젠타', Color(0xFFB8235B)),
      PaletteColor('퓨어 화이트', Color(0xFFF7F5F0)),
      PaletteColor('차콜', Color(0xFF2B2A2E)),
    ],
    avoidColors: [
      Color(0xFFD9A441),
      Color(0xFFC98B4B),
      Color(0xFFFFC9A8),
    ],
    hairColors: [
      PaletteColor('블랙', Color(0xFF1E1B1D)),
      PaletteColor('애쉬 블랙', Color(0xFF302C31)),
    ],
    lipColors: [
      PaletteColor('버건디 립', Color(0xFF7A2338)),
      PaletteColor('푸시아 립', Color(0xFFC1215F)),
    ],
    blushColors: [
      PaletteColor('푸시아 블러셔', Color(0xFFC1527A)),
      PaletteColor('로즈 블러셔', Color(0xFFB8235B)),
    ],
    eyeshadowColors: [
      PaletteColor('차콜 그레이', Color(0xFF2B2A2E)),
      PaletteColor('플럼 퍼플', Color(0xFF6B3A4B)),
    ],
    metalRecommendation: '실버 액세서리',
  );

  static const all = [springWarm, summerCool, autumnWarm, winterCool];
}
