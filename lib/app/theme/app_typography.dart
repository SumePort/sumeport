import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class SumePortTypography {
  const SumePortTypography._();

  // ─────────────────────────────────────────────
  // ENGLISH / HINGLISH
  // ─────────────────────────────────────────────

  static TextStyle inter({
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
  double? height,
  double? letterSpacing,
}) {
  return GoogleFonts.inter(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
    height: height,
    letterSpacing: letterSpacing,
  );
}

  static TextTheme englishTextTheme({
    required Color primary,
    required Color secondary,
    required Color tertiary,
  }) {
    return GoogleFonts.interTextTheme().copyWith(
      displayLarge: GoogleFonts.inter(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        color: primary,
        height: 1.15,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: primary,
        height: 1.15,
      ),
      headlineLarge: GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: primary,
        height: 1.2,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: primary,
        height: 1.2,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: primary,
        height: 1.25,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: primary,
        height: 1.3,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: primary,
        height: 1.35,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: primary,
        height: 1.35,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: primary,
        height: 1.5,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: secondary,
        height: 1.5,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: tertiary,
        height: 1.45,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: primary,
        height: 1.3,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: secondary,
        height: 1.3,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: tertiary,
        height: 1.3,
      ),
    );
  }

  // ─────────────────────────────────────────────
  // HINDI
  // ─────────────────────────────────────────────

static TextStyle notoSansDevanagari({
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
  double? height,
  double? letterSpacing,
}) {
  return GoogleFonts.notoSansDevanagari(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
    height: height,
    letterSpacing: letterSpacing,
  );
}

  static TextTheme hindiTextTheme({
    required Color primary,
    required Color secondary,
    required Color tertiary,
  }) {
    return GoogleFonts.notoSansDevanagariTextTheme().copyWith(
      displayLarge: GoogleFonts.notoSansDevanagari(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        color: primary,
        height: 1.25,
      ),
      displayMedium: GoogleFonts.notoSansDevanagari(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: primary,
        height: 1.25,
      ),
      headlineLarge: GoogleFonts.notoSansDevanagari(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: primary,
        height: 1.3,
      ),
      headlineMedium: GoogleFonts.notoSansDevanagari(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: primary,
        height: 1.3,
      ),
      headlineSmall: GoogleFonts.notoSansDevanagari(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: primary,
        height: 1.35,
      ),
      titleLarge: GoogleFonts.notoSansDevanagari(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: primary,
        height: 1.4,
      ),
      titleMedium: GoogleFonts.notoSansDevanagari(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: primary,
        height: 1.4,
      ),
      titleSmall: GoogleFonts.notoSansDevanagari(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: primary,
        height: 1.4,
      ),
      bodyLarge: GoogleFonts.notoSansDevanagari(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: primary,
        height: 1.65,
      ),
      bodyMedium: GoogleFonts.notoSansDevanagari(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: secondary,
        height: 1.6,
      ),
      bodySmall: GoogleFonts.notoSansDevanagari(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: tertiary,
        height: 1.55,
      ),
      labelLarge: GoogleFonts.notoSansDevanagari(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: primary,
        height: 1.4,
      ),
      labelMedium: GoogleFonts.notoSansDevanagari(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: secondary,
        height: 1.4,
      ),
      labelSmall: GoogleFonts.notoSansDevanagari(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: tertiary,
        height: 1.4,
      ),
    );
  }
}

