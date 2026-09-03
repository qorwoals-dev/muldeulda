import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'screens/onboarding_screen.dart';

void main() {
  runApp(const MuldeuldaApp());
}

class MuldeuldaApp extends StatelessWidget {
  const MuldeuldaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChakTone',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const OnboardingScreen(),
    );
  }
}
