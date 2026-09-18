import 'package:flutter/material.dart';

import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_motion.dart';
import '../branding/sumeport_character.dart';
import '../typography/sumeport_text.dart';

class SumePortAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const SumePortAppBar({
    super.key,
    this.title,
    this.subtitle,
    this.leading,
    this.actions = const [],
    this.showCharacter = false,
    this.characterState = SumePortCharacterState.neutral,
    this.onProfileTap,
  });

  final String? title;
  final String? subtitle;
  final Widget? leading;
  final List<Widget> actions;

  final bool showCharacter;
  final SumePortCharacterState characterState;

  final VoidCallback? onProfileTap;

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: theme.scaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      leading: leading,
      titleSpacing: SumePortSpacing.lg,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (title != null)
            SumePortText(
              title!,
              style: theme.textTheme.titleLarge,
            ),
          if (subtitle != null) ...[
            const SizedBox(height: SumePortSpacing.xs),
            SumePortText(
              subtitle!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
      actions: [
        ...actions,
        if (showCharacter)
          Padding(
            padding: const EdgeInsets.only(
              right: SumePortSpacing.lg,
            ),
            child: GestureDetector(
              onTap: onProfileTap,
              child: AnimatedContainer(
                duration: SumePortMotion.fast,
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius:
                      BorderRadius.circular(SumePortRadius.pill),
                ),
                child: SumePortCharacter(
                  state: characterState,
                  width: 34,
                  height: 34,
                ),
              ),
            ),
          ),
      ],
    );
  }
}