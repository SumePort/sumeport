// lib/core/responsive/breakpoints.dart

abstract final class SumePortBreakpoints {
  const SumePortBreakpoints._();

  // ─────────────────────────────────────────────
  // HORIZONTAL BREAKPOINTS
  // ─────────────────────────────────────────────

  /// Mobile devices.
  static const double mobile = 600;

  /// Tablets and small landscape devices.
  static const double tablet = 900;

  /// Desktop screens.
  static const double desktop = 1200;

  /// Wide desktop screens.
  static const double wide = 1440;

  // ─────────────────────────────────────────────
  // VERTICAL BREAKPOINTS
  // ─────────────────────────────────────────────

  /// Very short screens.
  ///
  /// Useful for compact laptops, browser windows,
  /// landscape phones and small tablets.
  static const double short = 600;

  /// Normal screen height.
  static const double normal = 800;

  /// Tall screens.
  static const double tall = 1000;

  /// Very tall screens.
  static const double extraTall = 1200;
}