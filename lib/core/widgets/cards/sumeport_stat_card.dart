import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../typography/sumeport_text.dart';

class SumePortStatCard extends StatelessWidget {
  const SumePortStatCard({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.iconColor,
    this.trend,
    this.trendPositive,
    this.language = SumePortLanguage.english,
  });

  final String label;
  final String value;
  final IconData? icon;
  final Color? iconColor;
  final String? trend;
  final bool? trendPositive;
  final SumePortLanguage language;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final accentColor =
        iconColor ?? SumePortColors.primaryBlue;

    return Container(
      padding: const EdgeInsets.all(SumePortSpacing.xl),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(SumePortRadius.lg),
        border: Border.all(
          color: theme.dividerColor.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 20,
                  color: accentColor,
                ),
                const SizedBox(width: SumePortSpacing.sm),
              ],
              Expanded(
                child: SumePortText(
                  label,
                  language: language,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            ],
          ),

          const SizedBox(height: SumePortSpacing.md),

          SumePortText(
            value,
            language: language,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),

          if (trend != null) ...[
            const SizedBox(height: SumePortSpacing.sm),
            Row(
              children: [
                Icon(
                  trendPositive == true
                      ? Icons.trending_up_rounded
                      : Icons.trending_down_rounded,
                  size: 16,
                  color: trendPositive == true
                      ? SumePortColors.success
                      : SumePortColors.error,
                ),
                const SizedBox(width: SumePortSpacing.xs),
                Flexible(
                  child: SumePortText(
                    trend!,
                    language: language,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: trendPositive == true
                          ? SumePortColors.success
                          : SumePortColors.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}