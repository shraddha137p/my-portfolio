import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFF7F6F2);
  static const Color ink = Color(0xFF0E0E0E);
  static const Color inkLight = Color(0xFF3A3A3A);
  static const Color muted = Color(0xFF8D98A8);
  static const Color border = Color(0x1AFFFFFF);
  static const Color accent = Color(0xFFE11D48);
  static const Color accentDark = Color(0xFFBE123C);
  static const Color indigo = Color(0xFFE11D48);
  static const Color background = Color(0xFF050506);
  static const Color surface = Color(0xFF100B0D);
  static const Color surfaceAlt = Color(0xFF191013);
  static const Color primary = Color(0xFFE11D48);
  static const Color secondary = Color(0xFFFF667D);
  static const Color text = Color(0xFFF7FAFC);
  static const Color card = Color(0xFF101924);

  static ThemeData get theme => darkTheme;

  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: background,
        primaryColor: primary,
        colorScheme: const ColorScheme.dark(
          primary: primary,
          secondary: secondary,
          surface: surface,
          onPrimary: background,
          onSecondary: text,
          onSurface: text,
        ),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).copyWith(
          displayLarge: GoogleFonts.inter(
            fontSize: 70,
            fontWeight: FontWeight.w900,
            color: text,
            height: 0.92,
            letterSpacing: -2.2,
          ),
          displayMedium: GoogleFonts.inter(
            fontSize: 52,
            fontWeight: FontWeight.w800,
            color: text,
            height: 1.05,
            letterSpacing: -1.5,
          ),
          displaySmall: GoogleFonts.inter(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            color: text,
            height: 1.1,
            letterSpacing: -1.0,
          ),
          headlineMedium: GoogleFonts.inter(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: text,
            height: 1.2,
          ),
          titleLarge: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: text,
          ),
          bodyLarge: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: text.withValues(alpha: 0.8),
            height: 1.7,
          ),
          bodyMedium: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: text.withValues(alpha: 0.72),
            height: 1.7,
          ),
          labelLarge: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: primary,
            letterSpacing: 1.7,
          ),
        ),
        dividerColor: border,
        cardColor: card,
      );

  static BoxDecoration get backgroundDecoration => const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(-0.8, -0.7),
          radius: 1.5,
          colors: [Color(0xFF23080F), background],
        ),
      );
}
