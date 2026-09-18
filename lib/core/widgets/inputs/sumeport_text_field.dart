import 'package:flutter/material.dart';

import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_motion.dart';
import '../typography/sumeport_text.dart';

class SumePortTextField extends StatefulWidget {
  const SumePortTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.language = SumePortLanguage.english,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;

  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;

  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? Function(String?)? validator;

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  final bool obscureText;

  final int maxLines;
  final int? minLines;
  final int? maxLength;

  final bool enabled;
  final bool readOnly;
  final bool autofocus;

  final SumePortLanguage language;

  @override
  State<SumePortTextField> createState() => _SumePortTextFieldState();
}

class _SumePortTextFieldState extends State<SumePortTextField> {
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode?.addListener(_handleFocus);
  }

  @override
  void dispose() {
    widget.focusNode?.removeListener(_handleFocus);
    super.dispose();
  }

  void _handleFocus() {
    if (mounted) {
      setState(() {
        _focused = widget.focusNode?.hasFocus ?? false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          SumePortText(
            widget.label!,
            language: widget.language,
            style: theme.textTheme.labelLarge,
          ),
          const SizedBox(height: SumePortSpacing.sm),
        ],
        AnimatedContainer(
          duration: SumePortMotion.fast,
          curve: SumePortMotion.standard,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SumePortRadius.md),
            boxShadow: _focused
                ? [
                    BoxShadow(
                      blurRadius: 0,
                      spreadRadius: 1,
                      color: scheme.primary.withValues(alpha: 0.15),
                    ),
                  ]
                : null,
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            enabled: widget.enabled,
            readOnly: widget.readOnly,
            autofocus: widget.autofocus,
            obscureText: widget.obscureText,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            maxLength: widget.maxLength,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            onChanged: widget.onChanged,
            onFieldSubmitted: widget.onSubmitted,
            validator: widget.validator,
            style: theme.textTheme.bodyLarge,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: theme.textTheme.bodyLarge?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
              helperText: widget.helperText,
              errorText: widget.errorText,
              prefixIcon: widget.prefixIcon == null
                  ? null
                  : Icon(widget.prefixIcon),
              suffixIcon: widget.suffixIcon == null
                  ? null
                  : IconButton(
                      onPressed: widget.onSuffixTap,
                      icon: Icon(widget.suffixIcon),
                    ),
              filled: true,
              fillColor: scheme.surface,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: SumePortSpacing.lg,
                vertical: SumePortSpacing.md,
              ),
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(SumePortRadius.md),
                borderSide: BorderSide(
                  color: theme.dividerColor,
                ),
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
              errorBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(SumePortRadius.md),
                borderSide: BorderSide(
                  color: scheme.error,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(SumePortRadius.md),
                borderSide: BorderSide(
                  color: scheme.error,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}