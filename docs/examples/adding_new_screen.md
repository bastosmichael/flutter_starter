# Adding a New Screen

This guide shows you how to add a new screen to the Flutter Starter app.

## Step 1: Create the Screen File

Create a new file in `lib/screens/` directory:

```dart
// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/platform_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: ResponsiveLayout(
        mobile: _buildContent(context, 16.0),
        tablet: _buildContent(context, 24.0),
        desktop: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: _buildContent(context, 32.0),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, double padding) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(padding),
      child: Column(
        children: [
          PlatformCard(
            title: 'General',
            icon: Icons.settings,
            children: [
              _buildSettingItem('Notifications', true, (value) {}),
              _buildSettingItem('Dark Mode', false, (value) {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }
}
```

## Step 2: Add Route to main.dart

Update the router configuration in `lib/main.dart`:

```dart
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
    // Add your new route
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
```

## Step 3: Navigate to the New Screen

From any screen, use GoRouter to navigate:

```dart
// Using context.push
ElevatedButton(
  onPressed: () => context.push('/settings'),
  child: const Text('Go to Settings'),
)

// Or using context.go for replacement
IconButton(
  icon: const Icon(Icons.settings),
  onPressed: () => context.go('/settings'),
)
```

## Tips

1. **Use ResponsiveLayout**: Wrap your screen content with `ResponsiveLayout` for better UX across devices
2. **Reuse Widgets**: Use existing widgets like `PlatformCard` for consistency
3. **Follow Naming**: Use `*_screen.dart` for screens, `*_widget.dart` for reusable widgets
4. **Add Tests**: Create corresponding test files in `test/screens/`

## Example Screen Structure

```
lib/screens/
├── home_screen.dart
├── about_screen.dart
└── settings_screen.dart  # Your new screen
```

That's it! Your new screen is now part of the app.
