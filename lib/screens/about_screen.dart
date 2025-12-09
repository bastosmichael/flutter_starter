import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/platform_card.dart';
import '../widgets/responsive_layout.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
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
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PlatformCard(
            title: 'Flutter Starter',
            icon: Icons.info,
            children: [
              const Text(
                'Version 1.0.0',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              Text(
                'A comprehensive Flutter starter application that demonstrates '
                'cross-platform development capabilities.',
                style: theme.textTheme.bodyLarge,
              ),
            ],
          ),
          const SizedBox(height: 24),
          PlatformCard(
            title: 'Supported Platforms',
            icon: Icons.devices,
            children: [
              _buildPlatformItem('Android', Icons.android, Colors.green),
              _buildPlatformItem('iOS', Icons.apple, Colors.blue),
              _buildPlatformItem('Web', Icons.web, Colors.orange),
              _buildPlatformItem('Windows', Icons.desktop_windows, Colors.blue),
              _buildPlatformItem('macOS', Icons.laptop_mac, Colors.grey),
              _buildPlatformItem('Linux', Icons.computer, Colors.purple),
            ],
          ),
          const SizedBox(height: 24),
          PlatformCard(
            title: 'Technologies',
            icon: Icons.code,
            children: [
              _buildTechItem('Flutter SDK'),
              _buildTechItem('Material Design 3'),
              _buildTechItem('Riverpod State Management'),
              _buildTechItem('GoRouter Navigation'),
              _buildTechItem('Adaptive Scaffold'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformItem(String name, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 16),
          Text(
            name,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildTechItem(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 20),
          const SizedBox(width: 12),
          Text(name),
        ],
      ),
    );
  }
}
