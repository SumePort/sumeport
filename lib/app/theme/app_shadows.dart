import 'package:flutter/material.dart';

abstract final class SumePortShadows {
  const SumePortShadows._();

  static const List<BoxShadow> subtle = [
    BoxShadow(
      blurRadius: 12,
      offset: Offset(0, 4),
      spreadRadius: -4,
    ),
  ];

  static const List<BoxShadow> medium = [
    BoxShadow(
      blurRadius: 20,
      offset: Offset(0, 8),
      spreadRadius: -6,
    ),
  ];

  static const List<BoxShadow> elevated = [
    BoxShadow(
      blurRadius: 32,
      offset: Offset(0, 12),
      spreadRadius: -8,
    ),
  ];
}