# Platform-Specific Customizations

This guide shows how to customize the app for specific platforms.

## Detecting Platform

Use the `PlatformInfo` utility class:

```dart
import 'package:flutter_starter/utils/platform_info.dart';

// Check if running on web
if (PlatformInfo.isWeb) {
  // Web-specific code
}

// Check if running on mobile
if (PlatformInfo.isMobile) {
  // Mobile-specific code
}

// Check for specific platform
if (PlatformInfo.isAndroid) {
  // Android-specific code
}
```

## Platform-Specific UI

### Method 1: Using Platform Checks

```dart
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(PlatformInfo.isWeb ? 'Web App' : 'Mobile App'),
    ),
    body: PlatformInfo.isDesktop
        ? DesktopLayout()
        : MobileLayout(),
  );
}
```

### Method 2: Using ResponsiveLayout

```dart
Widget build(BuildContext context) {
  return ResponsiveLayout(
    mobile: MobileView(),
    tablet: TabletView(),
    desktop: DesktopView(),
  );
}
```

## Platform-Specific Features

### Mobile-Only Features

```dart
if (PlatformInfo.isMobile) {
  // Access mobile-only plugins
  // Example: camera, GPS, etc.
}
```

### Desktop-Only Features

```dart
if (PlatformInfo.isDesktop) {
  // Desktop-only features
  // Example: window management, file system access
}
```

### Web-Only Features

```dart
if (PlatformInfo.isWeb) {
  // Web-only features
  // Example: URL manipulation, web storage
}
```

## Platform-Specific Styling

```dart
final buttonPadding = PlatformInfo.isDesktop
    ? const EdgeInsets.all(16.0)
    : const EdgeInsets.all(12.0);

final fontSize = PlatformInfo.isDesktop ? 18.0 : 16.0;
```

## Conditional Imports

For platform-specific implementations, use conditional imports:

```dart
// lib/services/storage_service.dart
export 'storage_service_stub.dart'
    if (dart.library.io) 'storage_service_mobile.dart'
    if (dart.library.html) 'storage_service_web.dart';
```

## Testing Platform-Specific Code

```dart
testWidgets('Shows correct layout on mobile', (tester) async {
  // Set device size
  tester.binding.window.physicalSizeTestValue = const Size(400, 800);
  tester.binding.window.devicePixelRatioTestValue = 1.0;
  
  await tester.pumpWidget(MyApp());
  
  // Test mobile layout
  expect(find.byType(MobileLayout), findsOneWidget);
});
```

## Best Practices

1. **Graceful Degradation**: Ensure features work on all platforms or provide alternatives
2. **Consistent UX**: Keep the core experience similar across platforms
3. **Platform Guidelines**: Follow Material Design on Android, Cupertino on iOS
4. **Performance**: Optimize for each platform's capabilities
5. **Testing**: Test on all target platforms before release

## Resources

- [Flutter Platform Channels](https://flutter.dev/docs/development/platform-integration/platform-channels)
- [Conditional Imports](https://dart.dev/guides/libraries/create-library-packages#conditionally-importing-and-exporting-library-files)
- [Responsive Design in Flutter](https://flutter.dev/docs/development/ui/layout/responsive)
