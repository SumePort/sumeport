// lib/core/responsive/responsive_layout.dart

import 'package:flutter/widgets.dart';

import 'responsive_builder.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.wide,

    this.mobileShort,
    this.mobileTall,
    this.tabletShort,
    this.tabletTall,
    this.desktopShort,
    this.desktopTall,
  });

  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  final Widget? wide;

  final Widget? mobileShort;
  final Widget? mobileTall;

  final Widget? tabletShort;
  final Widget? tabletTall;

  final Widget? desktopShort;
  final Widget? desktopTall;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      wide: wide,
      mobileShort: mobileShort,
      mobileTall: mobileTall,
      tabletShort: tabletShort,
      tabletTall: tabletTall,
      desktopShort: desktopShort,
      desktopTall: desktopTall,
    );
  }
}