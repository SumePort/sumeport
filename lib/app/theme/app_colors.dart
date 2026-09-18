import 'package:flutter/material.dart';

abstract final class SumePortColors {
  const SumePortColors._();

  // ─────────────────────────────────────────────
  // BRAND
  // ─────────────────────────────────────────────

  static const Color primaryBlue = Color(0xFF2563EB);

  static const Color primaryBlueLight = Color(0xFF3B82F6);

  static const Color primaryBlueDark = Color(0xFF1D4ED8);

  static const Color secondaryPurple = Color(0xFF7C3AED);

  static const Color secondaryPurpleLight = Color(0xFF8B5CF6);

  static const Color secondaryPurpleDark = Color(0xFF6D28D9);

  // ─────────────────────────────────────────────
  // GRADIENT
  // ─────────────────────────────────────────────

  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      primaryBlue,
      secondaryPurple,
    ],
  );

  // ─────────────────────────────────────────────
  // LIGHT THEME
  // ─────────────────────────────────────────────

  static const Color lightBackground = Color(0xFFF8FAFC);

  static const Color lightSurface = Color(0xFFFFFFFF);

  static const Color lightSurfaceSecondary = Color(0xFFF1F5F9);

  static const Color lightBorder = Color(0xFFE2E8F0);

  static const Color lightTextPrimary = Color(0xFF0F172A);

  static const Color lightTextSecondary = Color(0xFF475569);

  static const Color lightTextTertiary = Color(0xFF64748B);

  // ─────────────────────────────────────────────
  // DARK THEME
  // ─────────────────────────────────────────────

  static const Color darkBackground = Color(0xFF09090B);

  static const Color darkSurface = Color(0xFF111113);

  static const Color darkSurfaceSecondary = Color(0xFF18181B);

  static const Color darkBorder = Color(0xFF27272A);

  static const Color darkTextPrimary = Color(0xFFF8FAFC);

  static const Color darkTextSecondary = Color(0xFFCBD5E1);

  static const Color darkTextTertiary = Color(0xFF94A3B8);

  // ─────────────────────────────────────────────
  // SEMANTIC COLORS
  // ─────────────────────────────────────────────

  static const Color success = Color(0xFF16A34A);

  static const Color warning = Color(0xFFD97706);

  static const Color error = Color(0xFFDC2626);

  static const Color info = Color(0xFF2563EB);
}