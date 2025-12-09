// Flutter Starter - A cross-platform application supporting mobile, desktop, and web.
// 
// This app demonstrates:
// - Multi-platform support (iOS, Android, Web, Windows, macOS, Linux)
// - Material Design 3
// - Responsive layouts
// - Navigation with GoRouter
// - State management with Riverpod

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'screens/home_screen.dart';
import 'screens/about_screen.dart';


/// Entry point of the application.
void main() {
  runApp(const ProviderScope(child: MyApp()));
}

/// The root widget of the application.
/// 
/// Configures Material Design 3 theme with light/dark mode support
/// and sets up routing with GoRouter.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Starter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      routerConfig: _router,
    );
  }
}

/// Application routes configuration.
/// 
/// Defines navigation paths:
/// - / : Home screen with platform information
/// - /about : About screen with app details
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/about',
      builder: (context, state) => const AboutScreen(),
    ),
  ],
);
