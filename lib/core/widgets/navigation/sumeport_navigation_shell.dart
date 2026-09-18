import 'package:flutter/material.dart';

import '../../responsive/responsive.dart';
import '../branding/sumeport_character.dart';
import 'sumeport_app_bar.dart';
import 'sumeport_bottom_nav.dart';
import 'sumeport_navigation_item.dart';
import 'sumeport_sidebar.dart';

class SumePortNavigationShell extends StatelessWidget {
  const SumePortNavigationShell({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onChanged,
    required this.child,
    this.title,
    this.subtitle,
  });

  final List<SumePortNavigationItem> items;
  final int currentIndex;
  final ValueChanged<int> onChanged;
  final Widget child;

  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    if (context.isMobile) {
      return _MobileLayout(
        items: items,
        currentIndex: currentIndex,
        onChanged: onChanged,
        title: title,
        subtitle: subtitle,
        child: child,
      );
    }

    if (context.isTablet) {
      return _TabletLayout(
        items: items,
        currentIndex: currentIndex,
        onChanged: onChanged,
        title: title,
        subtitle: subtitle,
        child: child,
      );
    }

    return _DesktopLayout(
      items: items,
      currentIndex: currentIndex,
      onChanged: onChanged,
      title: title,
      subtitle: subtitle,
      child: child,
    );
  }
}

class _MobileLayout extends StatelessWidget {
  const _MobileLayout({
    required this.items,
    required this.currentIndex,
    required this.onChanged,
    required this.child,
    this.title,
    this.subtitle,
  });

  final List<SumePortNavigationItem> items;
  final int currentIndex;
  final ValueChanged<int> onChanged;
  final Widget child;
  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SumePortAppBar(
        title: title,
        subtitle: subtitle,
        showCharacter: true,
        characterState: SumePortCharacterState.neutral,
      ),
      body: child,
      bottomNavigationBar: SumePortBottomNav(
        items: items,
        currentIndex: currentIndex,
        onChanged: onChanged,
      ),
    );
  }
}

class _TabletLayout extends StatelessWidget {
  const _TabletLayout({
    required this.items,
    required this.currentIndex,
    required this.onChanged,
    required this.child,
    this.title,
    this.subtitle,
  });

  final List<SumePortNavigationItem> items;
  final int currentIndex;
  final ValueChanged<int> onChanged;
  final Widget child;
  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SumePortSidebar(
            items: items,
            currentIndex: currentIndex,
            onChanged: onChanged,
            collapsed: true,
          ),
          Expanded(
            child: Column(
              children: [
                SumePortAppBar(
                  title: title,
                  subtitle: subtitle,
                  showCharacter: true,
                ),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout({
    required this.items,
    required this.currentIndex,
    required this.onChanged,
    required this.child,
    this.title,
    this.subtitle,
  });

  final List<SumePortNavigationItem> items;
  final int currentIndex;
  final ValueChanged<int> onChanged;
  final Widget child;
  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SumePortSidebar(
            items: items,
            currentIndex: currentIndex,
            onChanged: onChanged,
          ),
          Expanded(
            child: Column(
              children: [
                SumePortAppBar(
                  title: title,
                  subtitle: subtitle,
                  showCharacter: true,
                  characterState:
                      SumePortCharacterState.neutral,
                ),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}