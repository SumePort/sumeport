import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

abstract final class SumePortTheme {
  const SumePortTheme._();

  static ThemeData light() {
    final textTheme = SumePortTypography.englishTextTheme(
      primary: SumePortColors.lightTextPrimary,
      secondary: SumePortColors.lightTextSecondary,
      tertiary: SumePortColors.lightTextTertiary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: SumePortColors.lightBackground,
      colorScheme: const ColorScheme.light(
        primary: SumePortColors.primaryBlue,
        secondary: SumePortColors.secondaryPurple,
        surface: SumePortColors.lightSurface,
        error: SumePortColors.error,
      ),
      textTheme: textTheme,
    );
  }

  static ThemeData dark() {
    final textTheme = SumePortTypography.englishTextTheme(
      primary: SumePortColors.darkTextPrimary,
      secondary: SumePortColors.darkTextSecondary,
      tertiary: SumePortColors.darkTextTertiary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: SumePortColors.darkBackground,
      colorScheme: const ColorScheme.dark(
        primary: SumePortColors.primaryBlueLight,
        secondary: SumePortColors.secondaryPurpleLight,
        surface: SumePortColors.darkSurface,
        error: SumePortColors.error,
      ),
      textTheme: textTheme,
    );
  }
}