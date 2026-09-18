import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_radius.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_typography.dart';
import '../../core/responsive/responsive.dart';
import '../../core/widgets/branding/sumeport_character.dart';
import '../../core/widgets/buttons/sumeport_button.dart';
import '../../core/widgets/cards/sumeport_card.dart';
import '../../core/widgets/cards/sumeport_feature_card.dart';
import '../../core/widgets/cards/sumeport_stat_card.dart';
import '../../core/widgets/feedback/sumeport_empty_state.dart';
import '../../core/widgets/feedback/sumeport_error.dart';
import '../../core/widgets/feedback/sumeport_loading.dart';
import '../../core/widgets/feedback/sumeport_success.dart';
import '../../core/widgets/inputs/sumeport_dropdown.dart';
import '../../core/widgets/inputs/sumeport_search_field.dart';
import '../../core/widgets/inputs/sumeport_text_field.dart';
import '../../core/widgets/navigation/sumeport_app_bar.dart';
import '../../core/widgets/navigation/sumeport_bottom_nav.dart';
import '../../core/widgets/navigation/sumeport_navigation_item.dart';
import '../../core/widgets/navigation/sumeport_navigation_shell.dart';
import '../../core/widgets/navigation/sumeport_sidebar.dart';
import '../../core/widgets/typography/sumeport_text.dart';
import 'showcase_section.dart';

class DesignSystemShowcasePage extends StatelessWidget {
  const DesignSystemShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: _ShowcaseHeader(),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: context.isMobile
                    ? SumePortSpacing.lg
                    : context.isTablet
                        ? SumePortSpacing.xxl
                        : SumePortSpacing.xxxl,
                vertical: SumePortSpacing.xxl,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const _BrandSection(),
                    const SizedBox(height: SumePortSpacing.xxl),
                    const _ColorsSection(),
                    const SizedBox(height: SumePortSpacing.xxl),
                    const _TypographySection(),
                    const SizedBox(height: SumePortSpacing.xxl),
                    const _SpacingSection(),
                    const SizedBox(height: SumePortSpacing.xxl),
                    const _RadiusSection(),
                    const SizedBox(height: SumePortSpacing.xxl),
                    const _CharacterSection(),
                    const SizedBox(height: SumePortSpacing.xxl),
                    const _ButtonsSection(),
                    const SizedBox(height: SumePortSpacing.xxl),
                    const _CardsSection(),
                    const SizedBox(height: SumePortSpacing.xxl),
                    const _InputsSection(),
                    const SizedBox(height: SumePortSpacing.xxl),
                    const _FeedbackSection(),
                    const SizedBox(height: SumePortSpacing.xxl),
                    const _NavigationSection(),
                    const SizedBox(height: SumePortSpacing.giant),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// HEADER
// -----------------------------------------------------------------------------

class _ShowcaseHeader extends StatelessWidget {
  const _ShowcaseHeader();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        context.isMobile
            ? SumePortSpacing.lg
            : SumePortSpacing.xxxl,
        SumePortSpacing.xxxl,
        context.isMobile
            ? SumePortSpacing.lg
            : SumePortSpacing.xxxl,
        SumePortSpacing.xxxl,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: theme.dividerColor,
          ),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1400,
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/branding/icon/sumeport_icon.png',
                width: context.isMobile ? 44 : 52,
                height: context.isMobile ? 44 : 52,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: SumePortSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SumePortText(
                      'SumePort Design System',
                      style: SumePortTypography.inter(
                        fontSize: context.isMobile ? 24 : 32,
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: SumePortSpacing.xs),
                    SumePortText(
                      'Design tokens, components, states and responsive behavior.',
                      style: SumePortTypography.inter(
                        fontSize: 14,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// BRAND
// -----------------------------------------------------------------------------

class _BrandSection extends StatelessWidget {
  const _BrandSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ShowcaseSection(
      title: 'Brand',
      description: 'Core SumePort visual identity.',
      child: Wrap(
        spacing: SumePortSpacing.xxxl,
        runSpacing: SumePortSpacing.xxl,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Column(
            children: [
              Image.asset(
                'assets/branding/icon/sumeport_icon.png',
                width: 96,
                height: 96,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: SumePortSpacing.md),
              SumePortText(
                'App Icon',
                style: SumePortTypography.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Image.asset(
                'assets/branding/logo/sumeport_logo.png',
                width: 96,
                height: 96,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: SumePortSpacing.md),
              SumePortText(
                'App Logo',
                style: SumePortTypography.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// COLORS
// -----------------------------------------------------------------------------

class _ColorsSection extends StatelessWidget {
  const _ColorsSection();

  @override
  Widget build(BuildContext context) {
    final colors = [
      const _ColorToken(
        'Primary Blue',
        SumePortColors.primaryBlue,
        '#2563EB',
      ),
      const _ColorToken(
        'Primary Blue Light',
        SumePortColors.primaryBlueLight,
        '#3B82F6',
      ),
      const _ColorToken(
        'Primary Blue Dark',
        SumePortColors.primaryBlueDark,
        '#1D4ED8',
      ),
      const _ColorToken(
        'Secondary Purple',
        SumePortColors.secondaryPurple,
        '#7C3AED',
      ),
      const _ColorToken(
        'Purple Light',
        SumePortColors.secondaryPurpleLight,
        '#8B5CF6',
      ),
      const _ColorToken(
        'Purple Dark',
        SumePortColors.secondaryPurpleDark,
        '#6D28D9',
      ),
      const _ColorToken(
        'Success',
        SumePortColors.success,
        '#16A34A',
      ),
      const _ColorToken(
        'Warning',
        SumePortColors.warning,
        '#D97706',
      ),
      const _ColorToken(
        'Error',
        SumePortColors.error,
        '#DC2626',
      ),
      const _ColorToken(
        'Info',
        SumePortColors.info,
        '#2563EB',
      ),
      const _ColorToken(
        'Light Background',
        SumePortColors.lightBackground,
        '#F8FAFC',
      ),
      const _ColorToken(
        'Light Surface',
        SumePortColors.lightSurface,
        '#FFFFFF',
      ),
      const _ColorToken(
        'Light Secondary Surface',
        SumePortColors.lightSurfaceSecondary,
        '#F1F5F9',
      ),
      const _ColorToken(
        'Light Border',
        SumePortColors.lightBorder,
        '#E2E8F0',
      ),
      const _ColorToken(
        'Dark Background',
        SumePortColors.darkBackground,
        '#09090B',
      ),
      const _ColorToken(
        'Dark Surface',
        SumePortColors.darkSurface,
        '#111113',
      ),
      const _ColorToken(
        'Dark Secondary Surface',
        SumePortColors.darkSurfaceSecondary,
        '#18181B',
      ),
      const _ColorToken(
        'Dark Border',
        SumePortColors.darkBorder,
        '#27272A',
      ),
    ];

    return ShowcaseSection(
      title: 'Colors',
      description: 'SumePort color tokens and semantic colors.',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final columns = context.isMobile
              ? 2
              : context.isTablet
                  ? 3
                  : 5;

          const spacing = SumePortSpacing.lg;

          final itemWidth =
              (constraints.maxWidth - ((columns - 1) * spacing)) /
                  columns;

          return Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: colors.map((token) {
              return SizedBox(
                width: itemWidth,
                child: _ColorTile(token: token),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class _ColorToken {
  const _ColorToken(
    this.name,
    this.color,
    this.hex,
  );

  final String name;
  final Color color;
  final String hex;
}

class _ColorTile extends StatelessWidget {
  const _ColorTile({
    required this.token,
  });

  final _ColorToken token;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border.all(
          color: theme.dividerColor,
        ),
        borderRadius: BorderRadius.circular(
          SumePortRadius.md,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 72,
            color: token.color,
          ),
          Padding(
            padding: const EdgeInsets.all(
              SumePortSpacing.md,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SumePortText(
                  token.name,
                  style: SumePortTypography.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: SumePortSpacing.xs),
                SumePortText(
                  token.hex,
                  style: SumePortTypography.inter(
                    fontSize: 12,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// TYPOGRAPHY
// -----------------------------------------------------------------------------

class _TypographySection extends StatelessWidget {
  const _TypographySection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final styles = [
      ('Display Large', theme.textTheme.displayLarge),
      ('Display Medium', theme.textTheme.displayMedium),
      ('Headline Large', theme.textTheme.headlineLarge),
      ('Headline Medium', theme.textTheme.headlineMedium),
      ('Headline Small', theme.textTheme.headlineSmall),
      ('Title Large', theme.textTheme.titleLarge),
      ('Title Medium', theme.textTheme.titleMedium),
      ('Title Small', theme.textTheme.titleSmall),
      ('Body Large', theme.textTheme.bodyLarge),
      ('Body Medium', theme.textTheme.bodyMedium),
      ('Body Small', theme.textTheme.bodySmall),
      ('Label Large', theme.textTheme.labelLarge),
      ('Label Medium', theme.textTheme.labelMedium),
      ('Label Small', theme.textTheme.labelSmall),
    ];

    return ShowcaseSection(
      title: 'Typography',
      description: 'Inter-based typography hierarchy.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: styles.map((item) {
          return Padding(
            padding: const EdgeInsets.only(
              bottom: SumePortSpacing.lg,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SumePortText(
                  item.$1,
                  style: SumePortTypography.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: SumePortSpacing.xs),
                Text(
                  'SumePort — Your AI-powered career companion.',
                  style: item.$2,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// SPACING
// -----------------------------------------------------------------------------

class _SpacingSection extends StatelessWidget {
  const _SpacingSection();

  @override
  Widget build(BuildContext context) {
    final spacing = [
      ('xs', SumePortSpacing.xs),
      ('sm', SumePortSpacing.sm),
      ('md', SumePortSpacing.md),
      ('lg', SumePortSpacing.lg),
      ('xl', SumePortSpacing.xl),
      ('xxl', SumePortSpacing.xxl),
      ('xxxl', SumePortSpacing.xxxl),
      ('huge', SumePortSpacing.huge),
      ('massive', SumePortSpacing.massive),
      ('giant', SumePortSpacing.giant),
    ];

    return ShowcaseSection(
      title: 'Spacing',
      description: 'The spacing scale used throughout SumePort.',
      child: Column(
        children: spacing.map((item) {
          return Padding(
            padding: const EdgeInsets.only(
              bottom: SumePortSpacing.md,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 72,
                  child: SumePortText(
                    item.$1,
                    style: SumePortTypography.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  width: item.$2,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: SumePortSpacing.md),
                SumePortText(
                  '${item.$2.toInt()} px',
                  style: SumePortTypography.inter(
                    fontSize: 12,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurfaceVariant,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// RADIUS
// -----------------------------------------------------------------------------

class _RadiusSection extends StatelessWidget {
  const _RadiusSection();

  @override
  Widget build(BuildContext context) {
    final radius = [
      ('xs', SumePortRadius.xs),
      ('sm', SumePortRadius.sm),
      ('md', SumePortRadius.md),
      ('lg', SumePortRadius.lg),
      ('xl', SumePortRadius.xl),
      ('xxl', SumePortRadius.xxl),
      ('pill', SumePortRadius.pill),
    ];

    return ShowcaseSection(
      title: 'Radius',
      description: 'Corner radius tokens.',
      child: Wrap(
        spacing: SumePortSpacing.lg,
        runSpacing: SumePortSpacing.lg,
        children: radius.map((item) {
          return Container(
            width: 110,
            height: 90,
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .surfaceContainerHighest,
              border: Border.all(
                color: Theme.of(context).dividerColor,
              ),
              borderRadius: BorderRadius.circular(
                item.$2,
              ),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SumePortText(
                  item.$1,
                  style: SumePortTypography.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: SumePortSpacing.xs),
                SumePortText(
                  '${item.$2.toInt()} px',
                  style: SumePortTypography.inter(
                    fontSize: 11,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurfaceVariant,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// CHARACTER
// -----------------------------------------------------------------------------

class _CharacterSection extends StatelessWidget {
  const _CharacterSection();

  @override
  Widget build(BuildContext context) {
    final states = [
      (
        SumePortCharacterState.neutral,
        'Neutral',
      ),
      (
        SumePortCharacterState.greeting,
        'Greeting',
      ),
      (
        SumePortCharacterState.thinking,
        'Thinking',
      ),
      (
        SumePortCharacterState.encouraging,
        'Encouraging',
      ),
      (
        SumePortCharacterState.confident,
        'Confident',
      ),
      (
        SumePortCharacterState.success,
        'Success',
      ),
      (
        SumePortCharacterState.processing,
        'Processing',
      ),
      (
        SumePortCharacterState.error,
        'Error',
      ),
    ];

    return ShowcaseSection(
      title: 'Character',
      description: 'SumePort AI companion states.',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final columns = context.isMobile
              ? 2
              : context.isTablet
                  ? 4
                  : 6;

          const spacing = SumePortSpacing.lg;

          final itemWidth =
              (constraints.maxWidth - ((columns - 1) * spacing)) /
                  columns;

          return Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: states.map((item) {
              return SizedBox(
                width: itemWidth,
                child: Container(
                  padding: const EdgeInsets.all(
                    SumePortSpacing.md,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(
                      SumePortRadius.lg,
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 150,
                        child: SumePortCharacter(
                          state: item.$1,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(
                        height: SumePortSpacing.sm,
                      ),
                      SumePortText(
                        item.$2,
                        style: SumePortTypography.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// BUTTONS
// -----------------------------------------------------------------------------

class _ButtonsSection extends StatelessWidget {
  const _ButtonsSection();

  @override
  Widget build(BuildContext context) {
    return ShowcaseSection(
      title: 'Buttons',
      description:
          'Primary actions, secondary actions, outline, ghost, sizes and states.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _ShowcaseLabel(label: 'Variants'),
          const SizedBox(height: SumePortSpacing.md),
          Wrap(
            spacing: SumePortSpacing.md,
            runSpacing: SumePortSpacing.md,
            children: [
              SumePortButton(
                label: 'Primary',
                onPressed: () {},
              ),
              SumePortButton(
                label: 'Secondary',
                variant: SumePortButtonVariant.secondary,
                onPressed: () {},
              ),
              SumePortButton(
                label: 'Outline',
                variant: SumePortButtonVariant.outline,
                onPressed: () {},
              ),
              SumePortButton(
                label: 'Ghost',
                variant: SumePortButtonVariant.ghost,
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: SumePortSpacing.xxl),
          const _ShowcaseLabel(label: 'Sizes'),
          const SizedBox(height: SumePortSpacing.md),
          Wrap(
            spacing: SumePortSpacing.md,
            runSpacing: SumePortSpacing.md,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              SumePortButton(
                label: 'Small',
                size: SumePortButtonSize.small,
                onPressed: () {},
              ),
              SumePortButton(
                label: 'Medium',
                size: SumePortButtonSize.medium,
                onPressed: () {},
              ),
              SumePortButton(
                label: 'Large',
                size: SumePortButtonSize.large,
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: SumePortSpacing.xxl),
          const _ShowcaseLabel(label: 'Icons'),
          const SizedBox(height: SumePortSpacing.md),
          Wrap(
            spacing: SumePortSpacing.md,
            runSpacing: SumePortSpacing.md,
            children: [
              SumePortButton(
                label: 'Create Resume',
                icon: Icons.description_outlined,
                onPressed: () {},
              ),
              SumePortButton(
                label: 'Continue',
                icon: Icons.arrow_forward_rounded,
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: SumePortSpacing.xxl),
          const _ShowcaseLabel(label: 'States'),
          const SizedBox(height: SumePortSpacing.md),
          Wrap(
            spacing: SumePortSpacing.md,
            runSpacing: SumePortSpacing.md,
            children: [
              SumePortButton(
                label: 'Loading',
                isLoading: true,
                onPressed: () {},
              ),
              SumePortButton(
                label: 'Disabled',
                onPressed: null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// CARDS
// -----------------------------------------------------------------------------

class _CardsSection extends StatelessWidget {
  const _CardsSection();

  @override
  Widget build(BuildContext context) {
    return ShowcaseSection(
      title: 'Cards',
      description:
          'Reusable containers for content, features and career metrics.',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final columns = context.isMobile
              ? 1
              : context.isTablet
                  ? 2
                  : 3;

          const gap = SumePortSpacing.lg;

          final width =
              (constraints.maxWidth - ((columns - 1) * gap)) /
                  columns;

          return Wrap(
            spacing: gap,
            runSpacing: gap,
            children: [
              SizedBox(
                width: width,
                child: SumePortCard(
                  child: Padding(
                    padding: const EdgeInsets.all(
                      SumePortSpacing.lg,
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const SumePortText(
                          'Basic Card',
                        ),
                        const SizedBox(
                          height: SumePortSpacing.sm,
                        ),
                        SumePortText(
                          'A reusable surface for SumePort content.',
                          style: SumePortTypography.inter(
                            fontSize: 14,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: width,
                child: SumePortFeatureCard(
                  title: 'Resume Builder',
                  description:
                      'Create a professional resume tailored to your career goals.',
                  icon: Icons.description_outlined,
                  onTap: () {},
                ),
              ),
              SizedBox(
                width: width,
                child: SumePortStatCard(
                  label: 'ATS Score',
                  value: '82',
                  icon: Icons.analytics_outlined,
                  trend: '+8%',
                  trendPositive: true,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// INPUTS
// -----------------------------------------------------------------------------

class _InputsSection extends StatefulWidget {
  const _InputsSection();

  @override
  State<_InputsSection> createState() => _InputsSectionState();
}

class _InputsSectionState extends State<_InputsSection> {
  final _nameController = TextEditingController();
  final _searchController = TextEditingController();

  String? _selectedRole;

  @override
  void dispose() {
    _nameController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShowcaseSection(
      title: 'Inputs',
      description:
          'Text fields, search and selection controls.',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = context.isMobile
              ? constraints.maxWidth
              : (constraints.maxWidth - SumePortSpacing.lg) / 2;

          return Wrap(
            spacing: SumePortSpacing.lg,
            runSpacing: SumePortSpacing.xxl,
            children: [
              SizedBox(
                width: width,
                child: SumePortTextField(
                  controller: _nameController,
                  label: 'Full Name',
                  hint: 'Enter your name',
                  prefixIcon: Icons.person_outline_rounded,
                ),
              ),
              SizedBox(
                width: width,
                child: SumePortTextField(
                  label: 'Email',
                  hint: 'you@example.com',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              SizedBox(
                width: width,
                child: SumePortTextField(
                  label: 'Password',
                  hint: 'Enter password',
                  obscureText: true,
                  prefixIcon: Icons.lock_outline_rounded,
                ),
              ),
              SizedBox(
                width: width,
                child: SumePortSearchField(
                  controller: _searchController,
                  hint: 'Search jobs...',
                ),
              ),
              SizedBox(
                width: width,
                child: SumePortDropdown<String>(
                  label: 'Target Role',
                  hint: 'Select a role',
                  value: _selectedRole,
                  items: const [
                    SumePortDropdownItem(
                      label: 'Software Engineer',
                      value: 'Software Engineer',
                    ),
                    SumePortDropdownItem(
                      label: 'Product Manager',
                      value: 'Product Manager',
                    ),
                    SumePortDropdownItem(
                      label: 'Data Analyst',
                      value: 'Data Analyst',
                    ),
                    SumePortDropdownItem(
                      label: 'UI/UX Designer',
                      value: 'UI/UX Designer',
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedRole = value;
                    });
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// FEEDBACK
// -----------------------------------------------------------------------------

class _FeedbackSection extends StatelessWidget {
  const _FeedbackSection();

  @override
  Widget build(BuildContext context) {
    return ShowcaseSection(
      title: 'Feedback',
      description:
          'Human-friendly loading, empty, error and success states.',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final columns = context.isMobile ? 1 : 2;

          const gap = SumePortSpacing.lg;

          final width =
              (constraints.maxWidth - ((columns - 1) * gap)) /
                  columns;

          return Wrap(
            spacing: gap,
            runSpacing: gap,
            children: [
              SizedBox(
                width: width,
                child: SumePortLoading(
                  message: 'Analyzing your career profile...',
                ),
              ),
              SizedBox(
                width: width,
                child: SumePortError(
                  title: 'Something went wrong',
                  message:
                      'We could not complete the request. Please try again.',
                  onRetry: () {},
                ),
              ),
              SizedBox(
                width: width,
                child: SumePortEmptyState(
                  title: 'No applications yet',
                  message:
                      'Your job applications will appear here.',
                  actionLabel: 'Find Jobs',
                  onAction: () {},
                ),
              ),
              SizedBox(
                width: width,
                child: SumePortSuccess(
                  title: 'Resume created',
                  message:
                      'Your resume is ready to review.',
                  actionLabel: 'View Resume',
                  onAction: () {},
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// NAVIGATION
// -----------------------------------------------------------------------------

class _NavigationSection extends StatefulWidget {
  const _NavigationSection();

  @override
  State<_NavigationSection> createState() =>
      _NavigationSectionState();
}

class _NavigationSectionState
    extends State<_NavigationSection> {
  int _currentIndex = 0;
  bool _sidebarCollapsed = false;

  static const _items = [
    SumePortNavigationItem(
      label: 'Home',
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
      route: '/dashboard',
    ),
    SumePortNavigationItem(
      label: 'Jobs',
      icon: Icons.work_outline_rounded,
      activeIcon: Icons.work_rounded,
      route: '/jobs',
    ),
    SumePortNavigationItem(
      label: 'Tools',
      icon: Icons.auto_awesome_outlined,
      activeIcon: Icons.auto_awesome,
      route: '/tools',
    ),
    SumePortNavigationItem(
      label: 'Tracker',
      icon: Icons.track_changes_outlined,
      activeIcon: Icons.track_changes,
      route: '/tracker',
    ),
    SumePortNavigationItem(
      label: 'Profile',
      icon: Icons.person_outline_rounded,
      activeIcon: Icons.person_rounded,
      route: '/profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ShowcaseSection(
      title: 'Navigation',
      description:
          'Responsive navigation components used throughout SumePort.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _ShowcaseLabel(label: 'App Bar'),
          const SizedBox(height: SumePortSpacing.md),
          const _AppBarPreview(),
          const SizedBox(height: SumePortSpacing.xxxl),
          const _ShowcaseLabel(label: 'Sidebar'),
          const SizedBox(height: SumePortSpacing.md),
          _SidebarPreview(
            items: _items,
            currentIndex: _currentIndex,
            collapsed: _sidebarCollapsed,
            onChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          const SizedBox(height: SumePortSpacing.lg),
          SumePortButton(
            label: _sidebarCollapsed
                ? 'Expand Sidebar'
                : 'Collapse Sidebar',
            variant: SumePortButtonVariant.outline,
            icon: _sidebarCollapsed
                ? Icons.keyboard_double_arrow_right_rounded
                : Icons.keyboard_double_arrow_left_rounded,
            onPressed: () {
              setState(() {
                _sidebarCollapsed = !_sidebarCollapsed;
              });
            },
          ),
          const SizedBox(height: SumePortSpacing.xxxl),
          const _ShowcaseLabel(label: 'Bottom Navigation'),
          const SizedBox(height: SumePortSpacing.md),
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).dividerColor,
              ),
              borderRadius: BorderRadius.circular(
                SumePortRadius.lg,
              ),
            ),
            child: SizedBox(
              height: 88,
              child: SumePortBottomNav(
                items: _items,
                currentIndex: _currentIndex,
                onChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: SumePortSpacing.xxxl),
          const _ShowcaseLabel(label: 'Responsive Shell'),
          const SizedBox(height: SumePortSpacing.md),
          _NavigationShellPreview(
            items: _items,
            currentIndex: _currentIndex,
            onChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ],
      ),
    );
  }
}

class _AppBarPreview extends StatelessWidget {
  const _AppBarPreview();

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
        borderRadius: BorderRadius.circular(
          SumePortRadius.lg,
        ),
      ),
      child: SumePortAppBar(
        title: 'Career Dashboard',
        subtitle: 'Your next opportunity starts here.',
        characterState: SumePortCharacterState.greeting,
        onProfileTap: () {},
        actions: [
          IconButton(
            tooltip: 'Notifications',
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_rounded,
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarPreview extends StatelessWidget {
  const _SidebarPreview({
    required this.items,
    required this.currentIndex,
    required this.collapsed,
    required this.onChanged,
  });

  final List<SumePortNavigationItem> items;
  final int currentIndex;
  final bool collapsed;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
        borderRadius: BorderRadius.circular(
          SumePortRadius.lg,
        ),
      ),
      child: Row(
        children: [
          SumePortSidebar(
            items: items,
            currentIndex: currentIndex,
            collapsed: collapsed,
            onChanged: onChanged,
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.dashboard_outlined,
                    size: 48,
                    color: Theme.of(context)
                        .colorScheme
                        .primary,
                  ),
                  const SizedBox(
                    height: SumePortSpacing.lg,
                  ),
                  const SumePortText(
                    'Content Area',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavigationShellPreview extends StatelessWidget {
  const _NavigationShellPreview({
    required this.items,
    required this.currentIndex,
    required this.onChanged,
  });

  final List<SumePortNavigationItem> items;
  final int currentIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
        borderRadius: BorderRadius.circular(
          SumePortRadius.lg,
        ),
      ),
      child: SumePortNavigationShell(
        items: items,
        currentIndex: currentIndex,
        onChanged: onChanged,
        title: 'Career Dashboard',
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.dashboard_rounded,
                size: 48,
                color: Theme.of(context)
                    .colorScheme
                    .primary,
              ),
              const SizedBox(
                height: SumePortSpacing.lg,
              ),
              const SumePortText(
                'Responsive Content Area',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// SHOWCASE LABEL
// -----------------------------------------------------------------------------

class _ShowcaseLabel extends StatelessWidget {
  const _ShowcaseLabel({
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return SumePortText(
      label.toUpperCase(),
      style: SumePortTypography.inter(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.8,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}