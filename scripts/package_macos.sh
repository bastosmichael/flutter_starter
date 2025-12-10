#!/usr/bin/env bash
set -euo pipefail

# Build and package a macOS release artifact that runs without manual code signing.
# This script must be run on macOS with Flutter and Xcode command-line tools installed.

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
APP_PATH="$ROOT_DIR/build/macos/Build/Products/Release/flutter_starter.app"
ARTIFACTS_DIR="$ROOT_DIR/build/artifacts"
ZIP_PATH="$ARTIFACTS_DIR/flutter_starter-macos.zip"
DMG_PATH="$ARTIFACTS_DIR/flutter_starter-macos.dmg"

log() {
  printf "\n[macOS package] %s\n" "$1"
}

log "Cleaning previous build outputs"
flutter clean

log "Building macOS release"
flutter build macos --release

log "Removing extended attributes from the app bundle"
xattr -cr "$APP_PATH"

log "Ad-hoc signing the bundle to satisfy Gatekeeper"
codesign --force --deep --sign - --options runtime --timestamp=none "$APP_PATH"

log "Preparing artifacts directory at $ARTIFACTS_DIR"
mkdir -p "$ARTIFACTS_DIR"

log "Creating zip archive at $ZIP_PATH"
ditto -c -k --sequesterRsrc --keepParent "$APP_PATH" "$ZIP_PATH"

log "Creating DMG at $DMG_PATH"
hdiutil create -fs HFS+ -volname "flutter_starter" -srcfolder "$APP_PATH" -ov -format UDZO "$DMG_PATH"

log "Done! Distribute the zip or DMG; users can open the app without extra steps."
