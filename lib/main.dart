import 'package:flutter/material.dart';
import 'features/auth/pages/splash_page.dart';

void main() {
  runApp(const SehatSathiApp());
}

class SehatSathiApp extends StatelessWidget {
  const SehatSathiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sehat Sathi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFFEA2A33, const <int, Color>{
          50: Color(0xFFFEF2F2),
          100: Color(0xFFFEE2E2),
          200: Color(0xFFFECACA),
          300: Color(0xFFFCA5A5),
          400: Color(0xFFF87171),
          500: Color(0xFFEA2A33),
          600: Color(0xFFDC2626),
          700: Color(0xFFB91C1C),
          800: Color(0xFF991B1B),
          900: Color(0xFF7F1D1D),
        }),
        primaryColor: const Color(0xFFEA2A33),
        fontFamily: 'Plus Jakarta Sans',
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: Color(0xFF111827),
          ),
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
          ),
          bodyLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Color(0xFF6B7280),
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xFF6B7280),
          ),
        ),
        scaffoldBackgroundColor: const Color(0xFFF9FAFB),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFEA2A33),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const SplashPage(),
    );
  }
}
