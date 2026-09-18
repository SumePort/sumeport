// lib/core/responsive/responsive.dart

import 'package:flutter/widgets.dart';

import 'breakpoints.dart';

extension SumePortResponsive on BuildContext {
  // ─────────────────────────────────────────────
  // SCREEN DIMENSIONS
  // ─────────────────────────────────────────────

  double get screenWidth => MediaQuery.sizeOf(this).width;

  double get screenHeight => MediaQuery.sizeOf(this).height;

  // ─────────────────────────────────────────────
  // HORIZONTAL RESPONSIVENESS
  // ─────────────────────────────────────────────

  bool get isMobile =>
      screenWidth < SumePortBreakpoints.mobile;

  bool get isTablet =>
      screenWidth >= SumePortBreakpoints.mobile &&
      screenWidth < SumePortBreakpoints.tablet;

  bool get isDesktop =>
      screenWidth >= SumePortBreakpoints.tablet;

  bool get isLargeDesktop =>
      screenWidth >= SumePortBreakpoints.desktop;

  bool get isWide =>
      screenWidth >= SumePortBreakpoints.wide;

  // ─────────────────────────────────────────────
  // VERTICAL RESPONSIVENESS
  // ─────────────────────────────────────────────

  bool get isShortHeight =>
      screenHeight < SumePortBreakpoints.short;

  bool get isNormalHeight =>
      screenHeight >= SumePortBreakpoints.short &&
      screenHeight < SumePortBreakpoints.normal;

  bool get isTallHeight =>
      screenHeight >= SumePortBreakpoints.normal &&
      screenHeight < SumePortBreakpoints.tall;

  bool get isExtraTallHeight =>
      screenHeight >= SumePortBreakpoints.extraTall;

  // ─────────────────────────────────────────────
  // COMBINED DIMENSION STATES
  // ─────────────────────────────────────────────

  bool get isCompactScreen =>
      isMobile && isShortHeight;

  bool get isCompactTablet =>
      isTablet && isShortHeight;

  bool get isCompactDesktop =>
      isDesktop && isShortHeight;

  bool get isTallMobile =>
      isMobile && isTallHeight;

  bool get isTallTablet =>
      isTablet && isTallHeight;

  bool get isTallDesktop =>
      isDesktop && isTallHeight;

  // ─────────────────────────────────────────────
  // ORIENTATION
  // ─────────────────────────────────────────────

  bool get isPortrait =>
      screenHeight >= screenWidth;

  bool get isLandscape =>
      screenWidth > screenHeight;

  // ─────────────────────────────────────────────
  // RESPONSIVE VALUE — WIDTH
  // ─────────────────────────────────────────────

  T responsiveValue<T>({
    required T mobile,
    T? tablet,
    T? desktop,
    T? wide,
  }) {
    if (isWide && wide != null) {
      return wide;
    }

    if (isDesktop && desktop != null) {
      return desktop;
    }

    if (isTablet && tablet != null) {
      return tablet;
    }

    return mobile;
  }

  // ─────────────────────────────────────────────
  // RESPONSIVE VALUE — HEIGHT
  // ─────────────────────────────────────────────

  T responsiveHeightValue<T>({
    required T short,
    T? normal,
    T? tall,
    T? extraTall,
  }) {
    if (isExtraTallHeight && extraTall != null) {
      return extraTall;
    }

    if (isTallHeight && tall != null) {
      return tall;
    }

    if (isNormalHeight && normal != null) {
      return normal;
    }

    return short;
  }

  // ─────────────────────────────────────────────
  // RESPONSIVE VALUE — WIDTH + HEIGHT
  // ─────────────────────────────────────────────

  T responsiveDimensions<T>({
    required T mobileShort,
    T? mobileNormal,
    T? mobileTall,
    T? tabletShort,
    T? tabletNormal,
    T? tabletTall,
    T? desktopShort,
    T? desktopNormal,
    T? desktopTall,
    T? wide,
  }) {
    // Wide desktop gets highest priority.
    if (isWide && wide != null) {
      return wide;
    }

    // Desktop
    if (isDesktop) {
      if (isShortHeight && desktopShort != null) {
        return desktopShort;
      }

      if (isTallHeight && desktopTall != null) {
        return desktopTall;
      }

      if (desktopNormal != null) {
        return desktopNormal;
      }

      return mobileShort;
    }

    // Tablet
    if (isTablet) {
      if (isShortHeight && tabletShort != null) {
        return tabletShort;
      }

      if (isTallHeight && tabletTall != null) {
        return tabletTall;
      }

      if (tabletNormal != null) {
        return tabletNormal;
      }

      return mobileShort;
    }

    // Mobile
    if (isShortHeight) {
      return mobileShort;
    }

    if (isTallHeight && mobileTall != null) {
      return mobileTall;
    }

    if (mobileNormal != null) {
      return mobileNormal;
    }

    return mobileShort;
  }
}