# 물들다 — 퍼스널 컬러 진단 앱

디자인 목업(`design.html`)을 그대로 옮긴 Flutter 프로젝트입니다.

## 화면 구성
1. `onboarding_screen.dart` — 온보딩
2. `capture_screen.dart` — 촬영 가이드 (카메라 / 갤러리)
3. `analyzing_screen.dart` — 분석 중 로딩
4. `result_screen.dart` — 결과 리빌 (스와치가 중앙에서 퍼지는 애니메이션)
5. `detail_screen.dart` — 컬러 카드 상세 (베스트/피해야 할 컬러)

## 진단 로직 (`lib/services/color_analyzer.dart`)
지금은 사진 전체의 평균 색상(웜/쿨 × 밝음/어두움)으로 4계절 중 하나를 정하는
**데모용 로직**입니다. 실제 서비스로 만들려면:
- 얼굴 랜드마크 검출(예: `google_mlkit_face_detection`)로 피부/눈동자 영역만 추출
- 조명 보정 후 웜/쿨, 명도, 채도, 대비를 종합 판단하는 모델로 교체

하는 과정이 필요해요. `ColorAnalyzer.analyze()` 하나만 교체하면 나머지 화면은
그대로 재사용할 수 있도록 구조를 분리해뒀습니다.

## 실행 방법
```bash
flutter pub get
flutter run
```

`image_picker`를 쓰므로 iOS는 `Info.plist`에, Android는
`AndroidManifest.xml`에 카메라/사진 라이브러리 권한 설명이 필요합니다
(최근 `image_picker` 버전은 대부분 자동으로 처리해줍니다).
