import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_starter/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our app starts and displays the welcome text
    expect(find.text('Welcome to Flutter Starter'), findsOneWidget);
    
    // Verify platform information is displayed
    expect(find.text('Platform Information'), findsOneWidget);
    
    // Verify features section is displayed
    expect(find.text('Features'), findsOneWidget);
  });

  testWidgets('Navigation to About screen works', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Find and tap the about icon button
    final aboutButton = find.byIcon(Icons.info_outline);
    expect(aboutButton, findsOneWidget);
    
    await tester.tap(aboutButton);
    await tester.pumpAndSettle();

    // Verify we're on the About screen
    expect(find.text('About'), findsOneWidget);
    expect(find.text('Supported Platforms'), findsOneWidget);
  });
}
