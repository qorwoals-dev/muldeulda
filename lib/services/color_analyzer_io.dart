import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import '../models/season_palette.dart';
import 'color_analyzer_web.dart' show looksLikeSkin, classifyFromRgb, isBlownHighlight;
import 'face_analysis_exception.dart';

/// 얼굴 인식(ML Kit)이 가능한 플랫폼(Android/iOS)에서 쓰는 실제 분석 구현.
///
/// ML Kit Face Detector로 사진에서 얼굴을 찾고, 왼쪽/오른쪽 뺨 랜드마크
/// 좌표 주변의 픽셀만 샘플링해 배경·머리카락·옷 색에 흔들리지 않는 순수한
/// 피부색 평균을 얻는다. 그 평균색을 CIE LAB으로 변환해 4계절을 판정한다
/// (변환·판정 로직은 [color_analyzer_web.dart]와 공유).
Future<SeasonPalette> analyzeImage(Uint8List imageBytes, {String? imagePath}) async {
  if (imagePath == null) {
    throw const NoFaceDetectedException();
  }

  final faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableLandmarks: true,
      performanceMode: FaceDetectorMode.accurate,
    ),
  );

  final List<Face> faces;
  try {
    faces = await faceDetector.processImage(InputImage.fromFilePath(imagePath));
  } finally {
    await faceDetector.close();
  }

  if (faces.isEmpty) {
    throw const NoFaceDetectedException();
  }

  final face = faces.first;

  final codec = await ui.instantiateImageCodec(imageBytes);
  final frame = await codec.getNextFrame();
  final image = frame.image;
  final byteData = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
  if (byteData == null) {
    throw const NoFaceDetectedException();
  }
  final bytes = byteData.buffer.asUint8List();
  final width = image.width;
  final height = image.height;

  final samplePoints = <(int x, int y)>[];
  final leftCheek = face.landmarks[FaceLandmarkType.leftCheek];
  final rightCheek = face.landmarks[FaceLandmarkType.rightCheek];
  if (leftCheek != null) samplePoints.add((leftCheek.position.x, leftCheek.position.y));
  if (rightCheek != null) samplePoints.add((rightCheek.position.x, rightCheek.position.y));
  if (samplePoints.isEmpty) {
    // 뺨 랜드마크가 안 잡히면 얼굴 박스 중앙을 대신 쓴다.
    final center = face.boundingBox.center;
    samplePoints.add((center.dx.round(), center.dy.round()));
  }

  int skinRSum = 0, skinGSum = 0, skinBSum = 0, skinCount = 0;
  int fallbackRSum = 0, fallbackGSum = 0, fallbackBSum = 0, fallbackCount = 0;
  const patch = 16; // 각 샘플 지점 주변 patch x patch 픽셀 영역

  for (final point in samplePoints) {
    for (int dy = -patch ~/ 2; dy < patch ~/ 2; dy++) {
      for (int dx = -patch ~/ 2; dx < patch ~/ 2; dx++) {
        final x = point.$1 + dx;
        final y = point.$2 + dy;
        if (x < 0 || x >= width || y < 0 || y >= height) continue;
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
  }

  final double avgR, avgG, avgB;
  if (skinCount >= 20) {
    avgR = skinRSum / skinCount;
    avgG = skinGSum / skinCount;
    avgB = skinBSum / skinCount;
  } else if (fallbackCount > 0) {
    avgR = fallbackRSum / fallbackCount;
    avgG = fallbackGSum / fallbackCount;
    avgB = fallbackBSum / fallbackCount;
  } else {
    throw const NoFaceDetectedException();
  }

  return classifyFromRgb(avgR, avgG, avgB);
}
