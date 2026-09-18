import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_spacing.dart';
import '../branding/sumeport_character.dart';
import '../buttons/sumeport_button.dart';
import '../typography/sumeport_text.dart';

class SumePortSuccess extends StatelessWidget {
  const SumePortSuccess({
    super.key,
    this.title = 'You’re all set',
    this.message,
    this.actionLabel,
    this.onAction,
    this.language = SumePortLanguage.english,
  });

  final String title;
  final String? message;
  final String? actionLabel;
  final VoidCallback? onAction;
  final SumePortLanguage language;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(SumePortSpacing.xxl),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 440,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SumePortCharacter(
                state: SumePortCharacterState.success,
                width: 160,
                height: 160,
              ),
              const SizedBox(height: SumePortSpacing.lg),
              SumePortText(
                title,
                language: language,
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: SumePortColors.success,
                ),
              ),
              if (message != null) ...[
                const SizedBox(height: SumePortSpacing.sm),
                SumePortText(
                  message!,
                  language: language,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
              if (actionLabel != null && onAction != null) ...[
                const SizedBox(height: SumePortSpacing.xl),
                SumePortButton(
                  label: actionLabel!,
                  onPressed: onAction,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}