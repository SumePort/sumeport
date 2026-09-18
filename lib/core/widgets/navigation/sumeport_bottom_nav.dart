import 'package:flutter/material.dart';

import '../../../app/theme/app_motion.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../typography/sumeport_text.dart';
import 'sumeport_navigation_item.dart';

class SumePortBottomNav extends StatelessWidget {
  const SumePortBottomNav({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onChanged,
  });

  final List<SumePortNavigationItem> items;
  final int currentIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: scheme.surface,
          border: Border(
            top: BorderSide(
              color: theme.dividerColor.withValues(alpha: 0.5),
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: SumePortSpacing.sm,
          vertical: SumePortSpacing.sm,
        ),
        child: Row(
          children: List.generate(
            items.length,
            (index) {
              final item = items[index];
              final selected = index == currentIndex;

              return Expanded(
                child: _BottomNavItem(
                  item: item,
                  selected: selected,
                  onTap: () => onChanged(index),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatefulWidget {
  const _BottomNavItem({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final SumePortNavigationItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<_BottomNavItem> createState() => _BottomNavItemState();
}

class _BottomNavItemState extends State<_BottomNavItem> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final color = widget.selected
        ? scheme.primary
        : scheme.onSurfaceVariant;

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.94 : 1,
        duration: SumePortMotion.instant,
        child: AnimatedContainer(
          duration: SumePortMotion.fast,
          curve: SumePortMotion.standard,
          margin: const EdgeInsets.symmetric(
            horizontal: SumePortSpacing.xs,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: SumePortSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: widget.selected
                ? scheme.primary.withValues(alpha: 0.10)
                : Colors.transparent,
            borderRadius:
                BorderRadius.circular(SumePortRadius.md),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.selected
                    ? widget.item.activeIcon ?? widget.item.icon
                    : widget.item.icon,
                color: color,
                size: 22,
              ),
              const SizedBox(height: SumePortSpacing.xs),
              SumePortText(
                widget.item.label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: color,
                  fontWeight: widget.selected
                      ? FontWeight.w700
                      : FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}