/// Platform detection utilities for cross-platform Flutter applications.
/// 
/// Provides static getters to detect the current platform and platform type.
/// Works across all Flutter platforms: mobile, desktop, and web.

import 'package:flutter/foundation.dart';
import 'package:universal_io/io.dart';

/// Utility class for detecting the current platform.
/// 
/// Example usage:
/// ```dart
/// if (PlatformInfo.isWeb) {
///   print('Running on web');
/// } else if (PlatformInfo.isMobile) {
///   print('Running on mobile: ${PlatformInfo.platformName}');
/// }
/// ```
class PlatformInfo {
  // Platform checks
  static bool get isWeb => kIsWeb;
  static bool get isMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);
  static bool get isDesktop =>
      !kIsWeb && (Platform.isWindows || Platform.isMacOS || Platform.isLinux);

  // Specific platform checks
  static bool get isAndroid => !kIsWeb && Platform.isAndroid;
  static bool get isIOS => !kIsWeb && Platform.isIOS;
  static bool get isWindows => !kIsWeb && Platform.isWindows;
  static bool get isMacOS => !kIsWeb && Platform.isMacOS;
  static bool get isLinux => !kIsWeb && Platform.isLinux;

  // Get platform name
  static String get platformName {
    if (kIsWeb) return 'Web';
    if (Platform.isAndroid) return 'Android';
    if (Platform.isIOS) return 'iOS';
    if (Platform.isWindows) return 'Windows';
    if (Platform.isMacOS) return 'macOS';
    if (Platform.isLinux) return 'Linux';
    return 'Unknown';
  }

  // Get platform type
  static String get platformType {
    if (isWeb) return 'Web';
    if (isMobile) return 'Mobile';
    if (isDesktop) return 'Desktop';
    return 'Unknown';
  }
}
