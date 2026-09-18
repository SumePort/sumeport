import 'package:flutter/material.dart';

import '../../../app/theme/app_spacing.dart';
import '../../../core/widgets/branding/sumeport_character.dart';
import '../typography/sumeport_text.dart';

class SumePortLoading extends StatelessWidget {
  const SumePortLoading({
    super.key,
    this.message = 'SumePort is working...',
    this.characterState = SumePortCharacterState.processing,
    this.characterSize = 120,
    this.language = SumePortLanguage.english,
  });

  final String message;
  final SumePortCharacterState characterState;
  final double characterSize;
  final SumePortLanguage language;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SumePortCharacter(
            state: characterState,
            width: characterSize,
            height: characterSize,
          ),
          const SizedBox(height: SumePortSpacing.lg),
          SumePortText(
            message,
            language: language,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}