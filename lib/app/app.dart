import 'package:flutter/material.dart';

import 'router.dart';
import 'theme/app_theme.dart';

class SumePortApp extends StatelessWidget {
  const SumePortApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'SumePort',
      debugShowCheckedModeBanner: false,

      // Theme
      theme: SumePortTheme.light(),
      darkTheme: SumePortTheme.dark(),
      themeMode: ThemeMode.system,

      // Routing
      routerConfig: appRouter,
    );
  }
}