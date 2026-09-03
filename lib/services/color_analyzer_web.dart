import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';

import '../models/season_palette.dart';

/// 얼굴 인식 SDK(ML Kit)가 없는 플랫폼(web)에서 쓰는 대체 구현.
///
/// 촬영 가이드가 얼굴을 화면 중앙에 오도록 안내하므로, 사진 중앙 60% x 70%
/// 영역만 잘라내 배경을 최대한 배제한 뒤, 그 안에서 피부색에 가까운 픽셀만
/// 골라(Kovac et al.의 RGB 규칙) 평균 색을 CIE LAB으로 변환해 L*(명도)과
/// b*(황-청 축)로 4계절을 가른다. [color_analyzer_io.dart]의 얼굴 인식 기반
/// 분석보다는 근사치이지만, 사진 전체 평균을 쓰는 것보다는 훨씬 정확하다.
Future<SeasonPalette> analyzeImage(Uint8List imageBytes, {String? imagePath}) async {
  final codec = await ui.instantiateImageCodec(imageBytes, targetWidth: 200);
  final frame = await codec.getNextFrame();
  final image = frame.image;
  final byteData = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
  if (byteData == null) return SeasonData.autumnWarm;

  final bytes = byteData.buffer.asUint8List();
  final width = image.width;
  final height = image.height;

  final cropLeft = (width * 0.2).round();
  final cropRight = (width * 0.8).round();
  final cropTop = (height * 0.15).round();
  final cropBottom = (height * 0.85).round();

  int skinRSum = 0, skinGSum = 0, skinBSum = 0, skinCount = 0;
  int fallbackRSum = 0, fallbackGSum = 0, fallbackBSum = 0, fallbackCount = 0;

  for (int y = cropTop; y < cropBottom; y++) {
    for (int x = cropLeft; x < cropRight; x++) {
      final i = (y * width + x) * 4;
      if (i + 2 >= bytes.length) continue;
      final r = bytes[i];
      final g = bytes[i + 1];
      final b = bytes[i + 2];
      if (isBlownHighlight(r, g, b)) continue;

      fallbackRSum += r;
      fallbackGSum += g;
      fallbackBSum += b;
      fallbackCount++;

      if (looksLikeSkin(r, g, b)) {
        skinRSum += r;
        skinGSum += g;
        skinBSum += b;
        skinCount++;
      }
    }
  }

  final double avgR, avgG, avgB;
  if (skinCount >= 40) {
    avgR = skinRSum / skinCount;
    avgG = skinGSum / skinCount;
    avgB = skinBSum / skinCount;
  } else if (fallbackCount > 0) {
    avgR = fallbackRSum / fallbackCount;
    avgG = fallbackGSum / fallbackCount;
    avgB = fallbackBSum / fallbackCount;
  } else {
    return SeasonData.autumnWarm;
  }

  return classifyFromRgb(avgR, avgG, avgB);
}

/// Kovac et al.의 RGB 규칙 기반 피부색 픽셀 판별 (OpenCV 예제 등에서 널리
/// 쓰이는 단순 휴리스틱). [color_analyzer_io.dart]에서도 재사용한다.
/// 하이라이트가 날아간(과다노출) 픽셀. 색 정보가 흰색으로 뭉개져 피부색
/// 판정에 쓸 수 없으므로 평균 계산에서 아예 제외한다.
bool isBlownHighlight(int r, int g, int b) => r > 240 && g > 240 && b > 240;

bool looksLikeSkin(int r, int g, int b) {
  final maxC = math.max(r, math.max(g, b));
  final minC = math.min(r, math.min(g, b));
  return r > 95 &&
      g > 40 &&
      b > 20 &&
      (maxC - minC) > 15 &&
      (r - g).abs() > 15 &&
      r > g &&
      r > b;
}

/// 평균 피부색(RGB)을 CIE LAB으로 변환해 4계절을 판정한다.
/// [color_analyzer_io.dart]에서도 재사용한다.
SeasonPalette classifyFromRgb(double r, double g, double b) {
  final lab = rgbToLab(r, g, b);
  final isWarm = lab.b >= 10; // b*(황-청): 높을수록 노란빛(웜), 낮을수록 푸른빛(쿨)
  final isLight = lab.l >= 62; // L*(명도): 높을수록 밝은 피부
  debugPrint(
    'ColorAnalyzer: rgb=(${r.toStringAsFixed(1)},${g.toStringAsFixed(1)},${b.toStringAsFixed(1)}) '
    'lab=(L=${lab.l.toStringAsFixed(1)},a=${lab.a.toStringAsFixed(1)},b=${lab.b.toStringAsFixed(1)}) '
    'isWarm=$isWarm isLight=$isLight',
  );

  if (isWarm && isLight) return SeasonData.springWarm;
  if (isWarm && !isLight) return SeasonData.autumnWarm;
  if (!isWarm && isLight) return SeasonData.summerCool;
  return SeasonData.winterCool;
}

Lab rgbToLab(double r, double g, double b) {
  double toLinear(double c) {
    c /= 255;
    return c <= 0.04045 ? c / 12.92 : math.pow((c + 0.055) / 1.055, 2.4).toDouble();
  }

  final rl = toLinear(r);
  final gl = toLinear(g);
  final bl = toLinear(b);

  // 선형 RGB -> XYZ (sRGB, D65 기준)
  final x = rl * 0.4124 + gl * 0.3576 + bl * 0.1805;
  final y = rl * 0.2126 + gl * 0.7152 + bl * 0.0722;
  final z = rl * 0.0193 + gl * 0.1192 + bl * 0.9505;

  double f(double t) => t > 0.008856 ? math.pow(t, 1 / 3).toDouble() : (7.787 * t) + (16 / 116);
  final fx = f(x / 0.95047);
  final fy = f(y / 1.0);
  final fz = f(z / 1.08883);

  final l = (116 * fy) - 16;
  final a = 500 * (fx - fy);
  final bb = 200 * (fy - fz);
  return Lab(l, a, bb);
}

class Lab {
  final double l;
  final double a;
  final double b;
  Lab(this.l, this.a, this.b);
}
