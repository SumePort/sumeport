// lib/core/responsive/responsive_builder.dart

import 'package:flutter/widgets.dart';

import 'breakpoints.dart';

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.wide,

    // Optional height-aware layouts.
    this.mobileShort,
    this.mobileTall,
    this.tabletShort,
    this.tabletTall,
    this.desktopShort,
    this.desktopTall,
  });

  // Width-based layouts.
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  final Widget? wide;

  // Height-aware layouts.
  final Widget? mobileShort;
  final Widget? mobileTall;

  final Widget? tabletShort;
  final Widget? tabletTall;

  final Widget? desktopShort;
  final Widget? desktopTall;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final width = size.width;
    final height = size.height;

    // ───────────────────────────────────────────
    // WIDE DESKTOP
    // ───────────────────────────────────────────

    if (width >= SumePortBreakpoints.wide && wide != null) {
      return wide!;
    }

    // ───────────────────────────────────────────
    // DESKTOP
    // ───────────────────────────────────────────

    if (width >= SumePortBreakpoints.tablet) {
      if (height < SumePortBreakpoints.short &&
          desktopShort != null) {
        return desktopShort!;
      }

      if (height >= SumePortBreakpoints.normal &&
          desktopTall != null) {
        return desktopTall!;
      }

      if (desktop != null) {
        return desktop!;
      }
    }

    // ───────────────────────────────────────────
    // TABLET
    // ───────────────────────────────────────────

    if (width >= SumePortBreakpoints.mobile) {
      if (height < SumePortBreakpoints.short &&
          tabletShort != null) {
        return tabletShort!;
      }

      if (height >= SumePortBreakpoints.normal &&
          tabletTall != null) {
        return tabletTall!;
      }

      if (tablet != null) {
        return tablet!;
      }
    }

    // ───────────────────────────────────────────
    // MOBILE
    // ───────────────────────────────────────────

    if (height < SumePortBreakpoints.short &&
        mobileShort != null) {
      return mobileShort!;
    }

    if (height >= SumePortBreakpoints.normal &&
        mobileTall != null) {
      return mobileTall!;
    }

    return mobile;
  }
}