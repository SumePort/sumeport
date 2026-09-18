import 'package:flutter/material.dart';

import '../../../app/theme/app_motion.dart';

enum SumePortCharacterState {
  neutral,
  greeting,
  happy,
  excited,
  thinking,
  curious,
  explaining,
  encouraging,
  confident,
  listening,
  concerned,
  sad,
  celebrating,
  success,
  resume,
  jobSearch,
  interview,
  learning,
  analyzing,
  idea,
  problemSolving,
  processing,
  error,
  ready,
}

class SumePortCharacter extends StatelessWidget {
  const SumePortCharacter({
    super.key,
    this.state = SumePortCharacterState.neutral,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.animate = true,
    this.semanticLabel = 'SumePort AI career companion',
  });

  final SumePortCharacterState state;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Alignment alignment;
  final bool animate;
  final String semanticLabel;

  String get _assetPath {
    switch (state) {
      case SumePortCharacterState.neutral:
        return 'assets/character/sumeport_neutral.png';

      case SumePortCharacterState.greeting:
        return 'assets/character/sumeport_greeting.png';

      case SumePortCharacterState.happy:
        return 'assets/character/sumeport_happy.png';

      case SumePortCharacterState.excited:
        return 'assets/character/sumeport_excited.png';

      case SumePortCharacterState.thinking:
        return 'assets/character/sumeport_thinking.png';

      case SumePortCharacterState.curious:
        return 'assets/character/sumeport_curious.png';

      case SumePortCharacterState.explaining:
        return 'assets/character/sumeport_explaining.png';

      case SumePortCharacterState.encouraging:
        return 'assets/character/sumeport_encouraging.png';

      case SumePortCharacterState.confident:
        return 'assets/character/sumeport_confident.png';

      case SumePortCharacterState.listening:
        return 'assets/character/sumeport_listening.png';

      case SumePortCharacterState.concerned:
        return 'assets/character/sumeport_concerned.png';

      case SumePortCharacterState.sad:
        return 'assets/character/sumeport_sad.png';

      case SumePortCharacterState.celebrating:
        return 'assets/character/sumeport_celebrating.png';

      case SumePortCharacterState.success:
        return 'assets/character/sumeport_success.png';

      case SumePortCharacterState.resume:
        return 'assets/character/sumeport_resume.png';

      case SumePortCharacterState.jobSearch:
        return 'assets/character/sumeport_job_search.png';

      case SumePortCharacterState.interview:
        return 'assets/character/sumeport_interview.png';

      case SumePortCharacterState.learning:
        return 'assets/character/sumeport_learning.png';

      case SumePortCharacterState.analyzing:
        return 'assets/character/sumeport_analyzing.png';

      case SumePortCharacterState.idea:
        return 'assets/character/sumeport_idea.png';

      case SumePortCharacterState.problemSolving:
        return 'assets/character/sumeport_problem_solving.png';

      case SumePortCharacterState.processing:
        return 'assets/character/sumeport_processing.png';

      case SumePortCharacterState.error:
        return 'assets/character/sumeport_error.png';

      case SumePortCharacterState.ready:
        return 'assets/character/sumeport_ready.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    final image = Semantics(
      label: semanticLabel,
      image: true,
      child: Image.asset(
        _assetPath,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
      ),
    );

    if (!animate) {
      return image;
    }

    return AnimatedSwitcher(
      duration: SumePortMotion.medium,
      switchInCurve: SumePortMotion.entrance,
      switchOutCurve: SumePortMotion.standard,
      child: KeyedSubtree(
        key: ValueKey(_assetPath),
        child: image,
      ),
    );
  }
}