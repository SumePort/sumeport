import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../dev/showcase/design_system_showcase_page.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/signup_page.dart';
import '../features/splash/presentation/pages/splash_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',

  routes: [
    // --------------------------------------------------------
    // Splash
    // --------------------------------------------------------

    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) {
        return const SplashPage();
      },
    ),

    // --------------------------------------------------------
    // Authentication
    // --------------------------------------------------------

    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) {
        return const LoginPage();
      },
    ),

    GoRoute(
      path: '/signup',
      name: 'signup',
      builder: (context, state) {
        return const SignupPage();
      },
    ),

    // --------------------------------------------------------
    // Development
    // --------------------------------------------------------

    GoRoute(
      path: '/showcase',
      name: 'showcase',
      builder: (context, state) {
        return const DesignSystemShowcasePage();
      },
    ),
  ],

  errorBuilder: (context, state) {
    return Scaffold(
      body: Center(
        child: Text(
          'Page not found\n${state.uri}',
          textAlign: TextAlign.center,
        ),
      ),
    );
  },
);