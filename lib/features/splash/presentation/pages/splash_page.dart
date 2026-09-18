import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_spacing.dart';
import '../../../../core/responsive/responsive.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);

    _navigationTimer = Timer(
      const Duration(milliseconds: 3000),
      () {
        if (!mounted) return;

        context.go('/showcase');
      },
    );
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final splashImage = _getSplashImage(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          _AnimatedSplashArtwork(
            imagePath: splashImage,
            animation: _animationController,
          ),

          _SplashLoader(
            animation: _animationController,
          ),
        ],
      ),
    );
  }

  String _getSplashImage(BuildContext context) {
    final width = context.screenWidth;
    final height = context.screenHeight;

    final isPortrait = height >= width;

    // Portrait
    if (isPortrait) {
      // Phone
      if (width < 600) {
        return 'assets/branding/splash/sumeport_splash_mobile.png';
      }

      // Tablet
      return 'assets/branding/splash/sumeport_splash_tablet.png';
    }

    // Landscape
    if (width < 1200) {
      // Tablet / small laptop
      return 'assets/branding/splash/sumeport_splash_tablet.png';
    }

    // Desktop
    return 'assets/branding/splash/sumeport_splash_desktop.png';
  }
}

class _AnimatedSplashArtwork extends StatelessWidget {
  const _AnimatedSplashArtwork({
    required this.imagePath,
    required this.animation,
  });

  final String imagePath;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final scale = 1.0 + (animation.value * 0.018);

        return Transform.scale(
          scale: scale,
          child: child,
        );
      },
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
        alignment: Alignment.center,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}

class _SplashLoader extends StatelessWidget {
  const _SplashLoader({
    required this.animation,
  });

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = context.isMobile
        ? SumePortSpacing.huge
        : SumePortSpacing.massive;

    return Positioned(
      left: 0,
      right: 0,
      bottom: bottomPadding,
      child: Center(
        child: _OrbitalLoader(
          animation: animation,
        ),
      ),
    );
  }
}

class _OrbitalLoader extends StatelessWidget {
  const _OrbitalLoader({
    required this.animation,
  });

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final size = context.isMobile
        ? 52.0
        : context.isTablet
            ? 58.0
            : 64.0;

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final pulse = 0.92 + (animation.value * 0.08);

        return Transform.scale(
          scale: pulse,
          child: child,
        );
      },
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _LoaderGlow(
              size: size,
            ),
            _LoaderOrbit(
              size: size,
              rotation: animation.value * 6.28,
            ),
            _LoaderCore(
              size: size,
              animation: animation,
            ),
          ],
        ),
      ),
    );
  }
}

class _LoaderGlow extends StatelessWidget {
  const _LoaderGlow({
    required this.size,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size * 0.72,
      height: size * 0.72,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF45E9FF).withValues(alpha: 0.35),
            blurRadius: size * 0.42,
            spreadRadius: size * 0.04,
          ),
          BoxShadow(
            color: const Color(0xFF8B5CF6).withValues(alpha: 0.25),
            blurRadius: size * 0.55,
            spreadRadius: size * 0.02,
          ),
        ],
      ),
    );
  }
}

class _LoaderOrbit extends StatelessWidget {
  const _LoaderOrbit({
    required this.size,
    required this.rotation,
  });

  final double size;
  final double rotation;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: CustomPaint(
        size: Size.square(size),
        painter: _OrbitLoaderPainter(),
      ),
    );
  }
}

class _OrbitLoaderPainter extends CustomPainter {
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final center = Offset(
      size.width / 2,
      size.height / 2,
    );

    final radius = size.width * 0.34;

    final orbitPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.045
      ..strokeCap = StrokeCap.round
      ..shader = const SweepGradient(
        colors: [
          Color(0x005CEFFF),
          Color(0xFF5CEFFF),
          Color(0xFF8B5CF6),
          Color(0x005CEFFF),
        ],
      ).createShader(
        Rect.fromCircle(
          center: center,
          radius: radius,
        ),
      );

    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: radius,
      ),
      -1.2,
      4.8,
      false,
      orbitPaint,
    );

    final dotPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xFF8B5CF6);

    final dotPosition = Offset(
      center.dx + radius * 0.78,
      center.dy - radius * 0.62,
    );

    canvas.drawCircle(
      dotPosition,
      size.width * 0.055,
      dotPaint,
    );
  }

  @override
  bool shouldRepaint(
    covariant _OrbitLoaderPainter oldDelegate,
  ) {
    return false;
  }
}

class _LoaderCore extends StatelessWidget {
  const _LoaderCore({
    required this.size,
    required this.animation,
  });

  final double size;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final opacity = 0.72 + (animation.value * 0.28);

        return Opacity(
          opacity: opacity,
          child: child,
        );
      },
      child: Container(
        width: size * 0.20,
        height: size * 0.20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF7CF7FF),
              Color(0xFF3B82F6),
              Color(0xFF8B5CF6),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF5CEFFF).withValues(alpha: 0.8),
              blurRadius: size * 0.18,
              spreadRadius: size * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}