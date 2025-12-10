# Flutter Starter

A comprehensive Flutter starter application that supports **mobile** (iOS & Android), **desktop** (Windows, macOS & Linux), and **web** platforms.

## 🚀 Features

- ✅ **Multi-Platform Support**: Runs on iOS, Android, Web, Windows, macOS, and Linux
- ✅ **Material Design 3**: Modern UI with light and dark theme support
- ✅ **Responsive Layout**: Adaptive UI that works seamlessly across all screen sizes
- ✅ **State Management**: Riverpod for scalable state management
- ✅ **Navigation**: GoRouter for declarative routing
- ✅ **Platform Detection**: Utilities to detect and adapt to the current platform
- ✅ **Clean Architecture**: Well-organized code structure

## 📱 Supported Platforms

| Platform | Status |
|----------|--------|
| Android  | ✅     |
| iOS      | ✅     |
| Web      | ✅     |
| Windows  | ✅     |
| macOS    | ✅     |
| Linux    | ✅     |

## 🛠️ Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (>=3.0.0)
- For mobile development:
  - Android Studio (for Android)
  - Xcode (for iOS, macOS)
- For desktop development:
  - Visual Studio 2022 (for Windows)
  - Xcode (for macOS)
  - GTK development libraries (for Linux)

## 📦 Installation

1. Clone the repository:
```bash
git clone https://github.com/bastosmichael/flutter_starter.git
cd flutter_starter
```

2. Install dependencies:
```bash
flutter pub get
```

3. Verify your setup:
```bash
flutter doctor
```

## 🏃 Running the App

### Mobile

#### Android
```bash
flutter run -d android
```

#### iOS
```bash
flutter run -d ios
```

### Web
```bash
flutter run -d chrome
# or for other browsers:
flutter run -d edge
flutter run -d firefox
```

### Desktop

#### Windows
```bash
flutter run -d windows
```

#### macOS
```bash
flutter run -d macos
```

#### Linux
```bash
flutter run -d linux
```

## 🔨 Building for Production

### Mobile

#### Android (APK)
```bash
flutter build apk --release
```

#### Android (App Bundle)
```bash
flutter build appbundle --release
```

#### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

The output will be in the `build/web` directory.

### Desktop

#### Windows
```bash
flutter build windows --release
```

#### macOS
```bash
flutter build macos --release
```

#### Linux
```bash
flutter build linux --release
```

## 🧪 Testing

Run all tests:
```bash
flutter test
```

Run tests with coverage:
```bash
flutter test --coverage
```

## 📁 Project Structure

```
flutter_starter/
├── lib/
│   ├── main.dart                 # App entry point
│   ├── screens/                  # UI screens
│   │   ├── home_screen.dart      # Home screen
│   │   └── about_screen.dart     # About screen
│   ├── widgets/                  # Reusable widgets
│   │   ├── platform_card.dart    # Card widget
│   │   └── responsive_layout.dart # Responsive layout widget
│   └── utils/                    # Utilities
│       └── platform_info.dart    # Platform detection
├── test/                         # Test files
├── web/                          # Web-specific files
├── android/                      # Android-specific files
├── ios/                          # iOS-specific files
├── windows/                      # Windows-specific files
├── macos/                        # macOS-specific files
├── linux/                        # Linux-specific files
└── pubspec.yaml                  # Dependencies
```

## 🎨 Customization

### Changing the App Name

1. Update `pubspec.yaml`:
```yaml
name: your_app_name
description: Your app description
```

2. Update platform-specific configurations:
   - **Android**: `android/app/src/main/AndroidManifest.xml`
   - **iOS**: `ios/Runner/Info.plist`
   - **Web**: `web/manifest.json` and `web/index.html`
   - **Windows**: `windows/runner/main.cpp`
   - **macOS**: `macos/Runner/Info.plist`
   - **Linux**: `linux/my_application.cc`

### Adding Dependencies

Add dependencies to `pubspec.yaml`:
```yaml
dependencies:
  your_package: ^1.0.0
```

Then run:
```bash
flutter pub get
```

## 📚 Dependencies

- **flutter_riverpod**: State management
- **go_router**: Routing and navigation
- **universal_io**: Cross-platform IO operations

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 📞 Support

If you have any questions or run into issues, please open an issue on GitHub.

## 🔧 Troubleshooting
 
 ### macOS Build Issues
 
 #### CodeSign Failed: "resource fork, Finder information, or similar detritus not allowed"
 
 If you encounter a `CodeSign failed with a nonzero exit code` error during `flutter run -d macos` or `flutter build macos`, it is likely due to extended attributes (like `com.apple.provenance`) on files in the build directory or standard library packages.
 
 **Fix:**
 
 1.  Clean the project:
     ```bash
     flutter clean
     ```
 
 2.  Attempt to run normally:
     ```bash
     flutter run -d macos
     ```
 
 3.  **If the error persists**, run the following commands. This often happens when moving files between file systems (e.g., iCloud Drive, external drives), leaving "dot underscore" (._*) files that confuse the code signer.
 
     ```bash
     # Navigate to your project root
     cd path/to/flutter_starter
     
     # Merge standard file system forks (removes ._* files)
     dot_clean build/macos/Build/Products/Debug/flutter_starter.app
     
     # Strip extended attributes and quarantine info
     xattr -cr build/macos/Build/Products/Debug/flutter_starter.app
     
     # Force re-sign the app
     codesign --force --deep --sign - build/macos/Build/Products/Debug/flutter_starter.app
     
     # Open the app manually
     open build/macos/Build/Products/Debug/flutter_starter.app
     ```
 
 ## 🎯 Next Steps
 
 This starter provides a solid foundation. Here are some suggested enhancements:
 
 - Add authentication (Firebase Auth, OAuth)
 - Implement local storage (Hive, SharedPreferences)
 - Add network requests (Dio, HTTP)
 - Implement offline support
 - Add internationalization (i18n)
 - Include animations and transitions
 - Add error handling and logging
 - Implement CI/CD pipelines
 
 ---
 
 Made with ❤️ using Flutter