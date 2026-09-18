import 'package:flutter/material.dart';

import '../../../app/theme/app_motion.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';

enum SumePortButtonVariant {
  primary,
  secondary,
  outline,
  ghost,
}

enum SumePortButtonSize {
  small,
  medium,
  large,
}

class SumePortButton extends StatefulWidget {
  const SumePortButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = SumePortButtonVariant.primary,
    this.size = SumePortButtonSize.medium,
    this.icon,
    this.iconPosition = IconPosition.leading,
    this.isLoading = false,
    this.isFullWidth = false,
    this.enabled = true,
  });

  final String label;
  final VoidCallback? onPressed;

  final SumePortButtonVariant variant;
  final SumePortButtonSize size;

  final IconData? icon;
  final IconPosition iconPosition;

  final bool isLoading;
  final bool isFullWidth;
  final bool enabled;

  @override
  State<SumePortButton> createState() => _SumePortButtonState();
}

enum IconPosition {
  leading,
  trailing,
}

class _SumePortButtonState extends State<SumePortButton> {
  bool _isHovered = false;

  bool get _isEnabled =>
      widget.enabled && !widget.isLoading && widget.onPressed != null;

  EdgeInsets get _padding {
    switch (widget.size) {
      case SumePortButtonSize.small:
        return const EdgeInsets.symmetric(
          horizontal: SumePortSpacing.md,
          vertical: SumePortSpacing.sm,
        );

      case SumePortButtonSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: SumePortSpacing.lg,
          vertical: SumePortSpacing.md,
        );

      case SumePortButtonSize.large:
        return const EdgeInsets.symmetric(
          horizontal: SumePortSpacing.xl,
          vertical: SumePortSpacing.lg,
        );
    }
  }

  double get _fontSize {
    switch (widget.size) {
      case SumePortButtonSize.small:
        return 12;

      case SumePortButtonSize.medium:
        return 14;

      case SumePortButtonSize.large:
        return 16;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final backgroundColor = _backgroundColor(colors);
    final foregroundColor = _foregroundColor(colors);
    final borderColor = _borderColor(colors);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: _isEnabled
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: AnimatedContainer(
        duration: SumePortMotion.fast,
        curve: SumePortMotion.standard,
        width: widget.isFullWidth ? double.infinity : null,
        decoration: BoxDecoration(
          color: _isHovered && _isEnabled
              ? backgroundColor.withValues(alpha: 0.9)
              : backgroundColor,
          borderRadius: BorderRadius.circular(SumePortRadius.md),
          border: borderColor == null
              ? null
              : Border.all(color: borderColor),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(SumePortRadius.md),
            onTap: _isEnabled ? widget.onPressed : null,
            child: Padding(
              padding: _padding,
              child: _buildContent(foregroundColor),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(Color foregroundColor) {
    if (widget.isLoading) {
      return SizedBox(
        height: _fontSize + 4,
        width: _fontSize + 4,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: foregroundColor,
        ),
      );
    }

    final text = Text(
      widget.label,
      style: TextStyle(
        fontSize: _fontSize,
        fontWeight: FontWeight.w600,
        color: foregroundColor,
      ),
    );

    if (widget.icon == null) {
      return text;
    }

    final icon = Icon(
      widget.icon,
      size: _fontSize + 4,
      color: foregroundColor,
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: widget.iconPosition == IconPosition.leading
          ? [
              icon,
              const SizedBox(width: SumePortSpacing.sm),
              text,
            ]
          : [
              text,
              const SizedBox(width: SumePortSpacing.sm),
              icon,
            ],
    );
  }

  Color _backgroundColor(ColorScheme colors) {
    switch (widget.variant) {
      case SumePortButtonVariant.primary:
        return colors.primary;

      case SumePortButtonVariant.secondary:
        return colors.secondary;

      case SumePortButtonVariant.outline:
      case SumePortButtonVariant.ghost:
        return Colors.transparent;
    }
  }

  Color _foregroundColor(ColorScheme colors) {
    switch (widget.variant) {
      case SumePortButtonVariant.primary:
      case SumePortButtonVariant.secondary:
        return colors.onPrimary;

      case SumePortButtonVariant.outline:
        return colors.primary;

      case SumePortButtonVariant.ghost:
        return colors.onSurface;
    }
  }

  Color? _borderColor(ColorScheme colors) {
    switch (widget.variant) {
      case SumePortButtonVariant.outline:
        return colors.primary;

      case SumePortButtonVariant.primary:
      case SumePortButtonVariant.secondary:
      case SumePortButtonVariant.ghost:
        return null;
    }
  }
}