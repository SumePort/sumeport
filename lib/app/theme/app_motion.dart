import 'package:flutter/material.dart';

abstract final class SumePortMotion {
  const SumePortMotion._();

  static const Duration instant = Duration(milliseconds: 100);

  static const Duration fast = Duration(milliseconds: 180);

  static const Duration normal = Duration(milliseconds: 250);

  static const Duration medium = Duration(milliseconds: 350);

  static const Duration slow = Duration(milliseconds: 500);

  static const Curve standard = Curves.easeOutCubic;

  static const Curve emphasized = Curves.easeInOutCubic;

  static const Curve entrance = Curves.easeOutQuart;
}