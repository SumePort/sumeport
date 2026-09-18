import 'package:flutter/material.dart';

class SumePortNavigationItem {
  const SumePortNavigationItem({
    required this.label,
    required this.icon,
    this.activeIcon,
    required this.route,
  });

  final String label;
  final IconData icon;
  final IconData? activeIcon;
  final String route;
}