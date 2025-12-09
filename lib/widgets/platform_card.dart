// A reusable card widget with an icon and title.
// 
// Used throughout the app to display grouped information in a consistent style.

import 'package:flutter/material.dart';

/// A Material Design card widget with icon header and custom content.
/// 
/// Example:
/// ```dart
/// PlatformCard(
///   title: 'Features',
///   icon: Icons.star,
///   children: [
///     Text('Feature 1'),
///     Text('Feature 2'),
///   ],
/// )
/// ```
class PlatformCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const PlatformCard({
    super.key,
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: theme.colorScheme.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }
}
