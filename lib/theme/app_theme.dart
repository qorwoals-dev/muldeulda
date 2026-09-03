import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// 앱 전역 디자인 토큰.
/// 앱 크롬(배경/텍스트/버튼)은 최대한 조용하게 유지하고,
/// 진단된 퍼스널 컬러 팔레트만 화면 위에서 선명하게 드러나도록 한다.
class AppColors {
  AppColors._();

  static const canvas = Color(0xFFF2EEE7);
  static const canvasDim = Color(0xFFEAE4D8);
  static const ink = Color(0xFF211D1A);
  static const inkSoft = Color(0xFF5B534B);
  static const line = Color(0xFFDDD5C8);
  static const accent = Color(0xFF6B3A4B); // plum
  static const gold = Color(0xFFB08D4F);
  static const white = Color(0xFFFCFBF9);
}

/// 헤드라인은 세리프(Fraunces)로 감정적인 순간에만 사용,
/// 본문/UI는 산세리프(Manrope)로 통일한다.
class AppText {
  AppText._();

  static TextStyle display({double size = 28, FontWeight? weight}) =>
      GoogleFonts.fraunces(
        fontSize: size,
        fontWeight: weight ?? FontWeight.w500,
        height: 1.28,
        color: AppColors.ink,
      );

  static TextStyle body({
    double size = 14,
    FontWeight weight = FontWeight.w500,
    Color? color,
  }) =>
      GoogleFonts.manrope(
        fontSize: size,
        fontWeight: weight,
        height: 1.6,
        color: color ?? AppColors.inkSoft,
      );

  static TextStyle label({double size = 12, Color? color}) => GoogleFonts.manrope(
        fontSize: size,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.1,
        color: color ?? AppColors.inkSoft,
      );
}

/// 화면 전반에 은은한 깊이감을 주는 배경 그라디언트.
/// 단색 배경보다 밋밋하지 않으면서도, 화려한 그라디언트/글로우 없이
/// 종이에 가까운 질감을 유지한다.
const appBackgroundGradient = RadialGradient(
  center: Alignment(0, -0.7),
  radius: 1.3,
  colors: [AppColors.canvas, AppColors.canvasDim],
);

ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.canvas,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.accent,
      surface: AppColors.canvas,
      primary: AppColors.accent,
    ),
    textTheme: GoogleFonts.manropeTextTheme(),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.white,
        minimumSize: const Size.fromHeight(54),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        textStyle: GoogleFonts.manrope(fontWeight: FontWeight.w700, fontSize: 14, letterSpacing: 0.3),
        elevation: 0,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.ink,
        minimumSize: const Size.fromHeight(50),
        side: const BorderSide(color: AppColors.line, width: 1.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        textStyle: GoogleFonts.manrope(fontWeight: FontWeight.w600, fontSize: 13, letterSpacing: 0.3),
      ),
    ),
    dividerTheme: const DividerThemeData(color: AppColors.line, thickness: 1),
  );
}
