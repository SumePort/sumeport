import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_motion.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../branding/sumeport_character.dart';
import '../typography/sumeport_text.dart';
import 'sumeport_navigation_item.dart';

class SumePortSidebar extends StatefulWidget {
  const SumePortSidebar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onChanged,
    this.collapsed = false,
  });

  final List<SumePortNavigationItem> items;
  final int currentIndex;
  final ValueChanged<int> onChanged;
  final bool collapsed;

  @override
  State<SumePortSidebar> createState() => _SumePortSidebarState();
}

class _SumePortSidebarState extends State<SumePortSidebar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final width = widget.collapsed ? 76.0 : 264.0;

    return AnimatedContainer(
      duration: SumePortMotion.normal,
      curve: SumePortMotion.standard,
      width: width,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          right: BorderSide(
            color: theme.dividerColor.withValues(alpha: 0.5),
          ),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            _buildBrand(context),
            const SizedBox(height: SumePortSpacing.xl),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: SumePortSpacing.sm,
                ),
                itemCount: widget.items.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(height: SumePortSpacing.xs),
                itemBuilder: (context, index) {
                  return _SidebarItem(
                    item: widget.items[index],
                    selected: index == widget.currentIndex,
                    collapsed: widget.collapsed,
                    onTap: () => widget.onChanged(index),
                  );
                },
              ),
            ),
            _buildCharacter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBrand(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        SumePortSpacing.lg,
        SumePortSpacing.xl,
        SumePortSpacing.lg,
        0,
      ),
      child: Row(
        mainAxisAlignment: widget.collapsed
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
                BorderRadius.circular(SumePortRadius.md),
            child: Image.asset(
              'assets/branding/icon/sumeport_icon.png',
              width: 40,
              height: 40,
              fit: BoxFit.contain,
            ),
          ),
          if (!widget.collapsed) ...[
            const SizedBox(width: SumePortSpacing.md),
            SumePortText(
              'SumePort',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCharacter(BuildContext context) {
    if (widget.collapsed) {
      return const Padding(
        padding: EdgeInsets.all(SumePortSpacing.md),
        child: SumePortCharacter(
          state: SumePortCharacterState.encouraging,
          width: 48,
          height: 48,
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.all(SumePortSpacing.md),
      padding: const EdgeInsets.all(SumePortSpacing.md),
      decoration: BoxDecoration(
        color: SumePortColors.primaryBlue.withValues(alpha: 0.06),
        borderRadius:
            BorderRadius.circular(SumePortRadius.lg),
      ),
      child: Row(
        children: [
          const SumePortCharacter(
            state: SumePortCharacterState.encouraging,
            width: 52,
            height: 52,
          ),
          const SizedBox(width: SumePortSpacing.sm),
          Expanded(
            child: SumePortText(
              'You’ve got this.',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatefulWidget {
  const _SidebarItem({
    required this.item,
    required this.selected,
    required this.collapsed,
    required this.onTap,
  });

  final SumePortNavigationItem item;
  final bool selected;
  final bool collapsed;
  final VoidCallback onTap;

  @override
  State<_SidebarItem> createState() => _SidebarItemState();
}

class _SidebarItemState extends State<_SidebarItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final foreground = widget.selected
        ? scheme.primary
        : scheme.onSurfaceVariant;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: SumePortMotion.fast,
        curve: SumePortMotion.standard,
        decoration: BoxDecoration(
          color: widget.selected
              ? scheme.primary.withValues(alpha: 0.10)
              : _hovered
                  ? scheme.onSurface.withValues(alpha: 0.04)
                  : Colors.transparent,
          borderRadius:
              BorderRadius.circular(SumePortRadius.md),
        ),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius:
              BorderRadius.circular(SumePortRadius.md),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SumePortSpacing.md,
              vertical: SumePortSpacing.md,
            ),
            child: Row(
              mainAxisAlignment: widget.collapsed
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                Icon(
                  widget.selected
                      ? widget.item.activeIcon ?? widget.item.icon
                      : widget.item.icon,
                  size: 21,
                  color: foreground,
                ),
                if (!widget.collapsed) ...[
                  const SizedBox(width: SumePortSpacing.md),
                  Expanded(
                    child: SumePortText(
                      widget.item.label,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: foreground,
                        fontWeight: widget.selected
                            ? FontWeight.w600
                            : FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}