import 'package:flutter/material.dart';

import '../../../app/theme/app_motion.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_shadows.dart';
import '../../../app/theme/app_spacing.dart';

class SumePortCard extends StatefulWidget {
  const SumePortCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.border,
    this.backgroundColor,
    this.elevation = SumePortCardElevation.none,
    this.borderRadius,
    this.clipBehavior = Clip.antiAlias,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final Border? border;
  final Color? backgroundColor;
  final SumePortCardElevation elevation;
  final BorderRadius? borderRadius;
  final Clip clipBehavior;

  @override
  State<SumePortCard> createState() => _SumePortCardState();
}

enum SumePortCardElevation {
  none,
  subtle,
  medium,
  elevated,
}

class _SumePortCardState extends State<SumePortCard> {
  bool _isHovered = false;

  List<BoxShadow>? get _shadows {
    switch (widget.elevation) {
      case SumePortCardElevation.none:
        return null;
      case SumePortCardElevation.subtle:
        return SumePortShadows.subtle;
      case SumePortCardElevation.medium:
        return SumePortShadows.medium;
      case SumePortCardElevation.elevated:
        return SumePortShadows.elevated;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final borderRadius = widget.borderRadius ??
        BorderRadius.circular(SumePortRadius.lg);

    final backgroundColor =
        widget.backgroundColor ?? theme.colorScheme.surface;

    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) {
        if (widget.onTap != null) {
          setState(() => _isHovered = true);
        }
      },
      onExit: (_) {
        if (widget.onTap != null) {
          setState(() => _isHovered = false);
        }
      },
      child: AnimatedContainer(
        duration: SumePortMotion.fast,
        curve: SumePortMotion.standard,
        margin: widget.margin,
        decoration: BoxDecoration(
          color: _isHovered && widget.onTap != null
              ? backgroundColor.withValues(alpha: 0.96)
              : backgroundColor,
          borderRadius: borderRadius,
          border: widget.border ??
              Border.all(
                color: theme.dividerColor.withValues(alpha: 0.5),
              ),
          boxShadow: _shadows,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: borderRadius,
            child: Padding(
              padding: widget.padding ??
                  const EdgeInsets.all(SumePortSpacing.xl),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}