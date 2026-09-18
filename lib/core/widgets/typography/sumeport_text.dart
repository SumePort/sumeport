import 'package:flutter/material.dart';

import '../../../app/theme/app_typography.dart';

enum SumePortLanguage {
  english,
  hinglish,
  hindi,
}

class SumePortText extends StatelessWidget {
  const SumePortText(
    this.text, {
    super.key,
    this.language = SumePortLanguage.english,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.textScaler,
  });

  final String text;
  final SumePortLanguage language;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;
  final TextScaler? textScaler;

  @override
  Widget build(BuildContext context) {
    final baseStyle = _getBaseStyle();

    return Text(
      text,
      style: baseStyle.merge(style),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textScaler: textScaler,
    );
  }

  TextStyle _getBaseStyle() {
    switch (language) {
      case SumePortLanguage.english:
      case SumePortLanguage.hinglish:
        return SumePortTypography.inter();

      case SumePortLanguage.hindi:
        return SumePortTypography.notoSansDevanagari();
    }
  }
}