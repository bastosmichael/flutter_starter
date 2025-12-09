// Responsive layout widget that adapts to different screen sizes.
// 
// Provides different layouts for mobile, tablet, and desktop breakpoints.

import 'package:flutter/material.dart';

/// A widget that provides responsive layouts for different screen sizes.
/// 
/// Breakpoints:
/// - Mobile: < 600px width
/// - Tablet: 600px - 1199px width
/// - Desktop: >= 1200px width
/// 
/// Example:
/// ```dart
/// ResponsiveLayout(
///   mobile: MobileLayout(),
///   tablet: TabletLayout(),
///   desktop: DesktopLayout(),
/// )
/// ```
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1200;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 1200) {
      return desktop ?? tablet ?? mobile;
    } else if (width >= 600) {
      return tablet ?? mobile;
    } else {
      return mobile;
    }
  }
}
