import 'package:flutter/material.dart';

import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_motion.dart';

class SumePortSearchField extends StatefulWidget {
  const SumePortSearchField({
    super.key,
    this.controller,
    this.hint = 'Search',
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.autofocus = false,
    this.enabled = true,
  });

  final TextEditingController? controller;
  final String hint;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;

  final bool autofocus;
  final bool enabled;

  @override
  State<SumePortSearchField> createState() =>
      _SumePortSearchFieldState();
}

class _SumePortSearchFieldState extends State<SumePortSearchField> {
  late final TextEditingController _controller;
  bool _ownsController = false;

  @override
  void initState() {
    super.initState();

    if (widget.controller != null) {
      _controller = widget.controller!;
    } else {
      _controller = TextEditingController();
      _ownsController = true;
    }

    _controller.addListener(_handleTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChanged);

    if (_ownsController) {
      _controller.dispose();
    }

    super.dispose();
  }

  void _handleTextChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  void _clear() {
    _controller.clear();
    widget.onClear?.call();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return AnimatedContainer(
      duration: SumePortMotion.fast,
      curve: SumePortMotion.standard,
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(SumePortRadius.pill),
        border: Border.all(
          color: theme.dividerColor,
        ),
      ),
      child: TextField(
        controller: _controller,
        autofocus: widget.autofocus,
        enabled: widget.enabled,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        style: theme.textTheme.bodyMedium,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: theme.textTheme.bodyMedium?.copyWith(
            color: scheme.onSurfaceVariant,
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
          ),
          suffixIcon: _controller.text.isEmpty
              ? null
              : IconButton(
                  tooltip: 'Clear',
                  onPressed: _clear,
                  icon: const Icon(
                    Icons.close_rounded,
                  ),
                ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: SumePortSpacing.lg,
            vertical: SumePortSpacing.md,
          ),
        ),
      ),
    );
  }
}