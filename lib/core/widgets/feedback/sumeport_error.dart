import 'package:flutter/material.dart';

import '../../../app/theme/app_spacing.dart';
import '../branding/sumeport_character.dart';
import '../buttons/sumeport_button.dart';
import '../typography/sumeport_text.dart';

class SumePortError extends StatelessWidget {
  const SumePortError({
    super.key,
    this.title = 'Something went wrong',
    this.message = 'We couldn’t complete that action. Please try again.',
    this.onRetry,
    this.characterState = SumePortCharacterState.error,
    this.language = SumePortLanguage.english,
  });

  final String title;
  final String message;
  final VoidCallback? onRetry;
  final SumePortCharacterState characterState;
  final SumePortLanguage language;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(SumePortSpacing.xxl),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 420,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SumePortCharacter(
                state: characterState,
                width: 140,
                height: 140,
              ),
              const SizedBox(height: SumePortSpacing.lg),
              SumePortText(
                title,
                language: language,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: SumePortSpacing.sm),
              SumePortText(
                message,
                language: language,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              if (onRetry != null) ...[
                const SizedBox(height: SumePortSpacing.xl),
                SumePortButton(
                  label: 'Try Again',
                  icon: Icons.refresh_rounded,
                  onPressed: onRetry,
                  variant: SumePortButtonVariant.primary,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}