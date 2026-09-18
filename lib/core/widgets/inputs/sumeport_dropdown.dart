import 'package:flutter/material.dart';

import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../typography/sumeport_text.dart';

class SumePortDropdown<T> extends StatelessWidget {
  const SumePortDropdown({
    super.key,
    required this.items,
    this.value,
    this.label,
    this.hint,
    this.onChanged,
    this.enabled = true,
    this.language = SumePortLanguage.english,
  });

  final List<SumePortDropdownItem<T>> items;
  final T? value;

  final String? label;
  final String? hint;

  final ValueChanged<T?>? onChanged;

  final bool enabled;
  final SumePortLanguage language;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          SumePortText(
            label!,
            language: language,
            style: theme.textTheme.labelLarge,
          ),
          const SizedBox(height: SumePortSpacing.sm),
        ],
        DropdownButtonFormField<T>(
          initialValue: value,
          onChanged: enabled ? onChanged : null,
          style: theme.textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: scheme.surface,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: SumePortSpacing.lg,
              vertical: SumePortSpacing.md,
            ),
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(SumePortRadius.md),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(SumePortRadius.md),
              borderSide: BorderSide(
                color: theme.dividerColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(SumePortRadius.md),
              borderSide: BorderSide(
                color: scheme.primary,
                width: 1.5,
              ),
            ),
          ),
          items: items
              .map(
                (item) => DropdownMenuItem<T>(
                  value: item.value,
                  child: SumePortText(
                    item.label,
                    language: language,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class SumePortDropdownItem<T> {
  const SumePortDropdownItem({
    required this.value,
    required this.label,
  });

  final T value;
  final String label;
}