# Quick Start Guide

Get up and running with Flutter Starter in 5 minutes!

## Prerequisites

Make sure you have Flutter installed:
```bash
flutter --version
```

If not installed, follow the [official Flutter installation guide](https://flutter.dev/docs/get-started/install).

## Step 1: Clone & Setup

```bash
# Clone the repository
git clone https://github.com/bastosmichael/flutter_starter.git
cd flutter_starter

# Get dependencies
flutter pub get
```

## Step 2: Verify Setup

```bash
# Check Flutter installation and connected devices
flutter doctor

# See available devices
flutter devices
```

## Step 3: Run the App

Choose your target platform:

### Mobile
```bash
# Android (requires Android device/emulator)
flutter run -d android

# iOS (requires macOS with Xcode and iOS simulator/device)
flutter run -d ios
```

### Web
```bash
# Chrome (default)
flutter run -d chrome

# Other browsers
flutter run -d edge
flutter run -d firefox
```

### Desktop
```bash
# Windows (requires Windows)
flutter run -d windows

# macOS (requires macOS)
flutter run -d macos

# Linux (requires Linux with GTK)
flutter run -d linux
```

## Step 4: Explore the App

Once running, you'll see:
- 🏠 **Home Screen**: Shows platform information and features
- ℹ️ **About Screen**: Tap the info icon to learn more

## Step 5: Make It Yours

### Change App Name
1. Update `pubspec.yaml`:
   ```yaml
   name: my_awesome_app
   description: My awesome description
   ```

2. Update platform-specific names:
   - Android: `android/app/src/main/AndroidManifest.xml`
   - iOS: `ios/Runner/Info.plist`
   - Web: `web/index.html` and `web/manifest.json`

### Add a New Screen
See `docs/examples/adding_new_screen.md` for detailed guide.

Quick example:
```dart
// 1. Create lib/screens/my_screen.dart
class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Screen')),
      body: Center(child: Text('Hello!')),
    );
  }
}

// 2. Add route in lib/main.dart
GoRoute(
  path: '/my-screen',
  builder: (context, state) => MyScreen(),
)

// 3. Navigate from anywhere
context.push('/my-screen');
```

## Common Commands

```bash
# Run tests
flutter test

# Analyze code
flutter analyze

# Format code
flutter format .

# Clean build
flutter clean

# Build for release
flutter build apk           # Android
flutter build ios           # iOS
flutter build web           # Web
flutter build windows       # Windows
flutter build macos         # macOS
flutter build linux         # Linux
```

## Troubleshooting

### "No devices found"
- For mobile: Start an emulator or connect a device
- For web: Make sure Chrome is installed
- For desktop: Make sure you're on the correct OS

### "Pub get failed"
```bash
flutter clean
flutter pub get
```

### "Build errors"
```bash
flutter clean
flutter pub get
flutter run
```

### Platform-specific issues
- Android: Check Android Studio and SDK installation
- iOS: Requires macOS with Xcode
- Web: Update Chrome to latest version
- Desktop: Check platform-specific requirements in README

## Next Steps

1. ✅ Read the full [README.md](README.md)
2. ✅ Explore [example documentation](docs/examples/)
3. ✅ Check [CONTRIBUTING.md](CONTRIBUTING.md) to contribute
4. ✅ Review [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md) for architecture details

## Need Help?

- 📚 [Flutter Documentation](https://flutter.dev/docs)
- 💬 [Flutter Community](https://flutter.dev/community)
- 🐛 [Report Issues](https://github.com/bastosmichael/flutter_starter/issues)

Happy coding! 🎉
