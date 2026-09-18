import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_motion.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../typography/sumeport_text.dart';
import 'sumeport_card.dart';

class SumePortFeatureCard extends StatefulWidget {
  const SumePortFeatureCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    this.onTap,
    this.iconColor,
    this.language = SumePortLanguage.english,
  });

  final String title;
  final String description;
  final IconData icon;
  final VoidCallback? onTap;
  final Color? iconColor;
  final SumePortLanguage language;

  @override
  State<SumePortFeatureCard> createState() => _SumePortFeatureCardState();
}

class _SumePortFeatureCardState extends State<SumePortFeatureCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final accentColor =
        widget.iconColor ?? SumePortColors.primaryBlue;

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
        transform: Matrix4.identity()
          // ignore: deprecated_member_use
          ..translate(0.0, _isHovered ? -2.0 : 0.0),
        child: SumePortCard(
          onTap: widget.onTap,
          padding: const EdgeInsets.all(SumePortSpacing.xl),
          elevation: _isHovered
              ? SumePortCardElevation.subtle
              : SumePortCardElevation.none,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.1),
                  borderRadius:
                      BorderRadius.circular(SumePortRadius.md),
                ),
                child: Icon(
                  widget.icon,
                  color: accentColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: SumePortSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SumePortText(
                      widget.title,
                      language: widget.language,
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: SumePortSpacing.sm),
                    SumePortText(
                      widget.description,
                      language: widget.language,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              if (widget.onTap != null)
                Padding(
                  padding: const EdgeInsets.only(
                    left: SumePortSpacing.sm,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}