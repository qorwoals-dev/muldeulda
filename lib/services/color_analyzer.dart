import 'dart:typed_data';

import '../models/season_palette.dart';
import 'color_analyzer_web.dart' if (dart.library.io) 'color_analyzer_io.dart' as impl;

/// 퍼스널 컬러 진단 진입점.
///
/// 얼굴 인식(ML Kit)이 지원되는 플랫폼(Android/iOS)에서는 실제로 사진에서
/// 얼굴을 찾아 뺨 색을 분석하고([color_analyzer_io.dart]), 지원하지 않는
/// web에서는 사진 중앙부 기반 대체 분석([color_analyzer_web.dart])을 쓴다.
/// 얼굴을 찾지 못하면 [NoFaceDetectedException]을 던진다(web에서는 항상
/// 대체 분석으로 결과를 내므로 발생하지 않는다).
class ColorAnalyzer {
  static Future<SeasonPalette> analyze(Uint8List imageBytes, {String? imagePath}) {
    return impl.analyzeImage(imageBytes, imagePath: imagePath);
  }
}
