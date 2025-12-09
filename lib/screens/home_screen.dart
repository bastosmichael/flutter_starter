import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../utils/platform_info.dart';
import '../widgets/platform_card.dart';
import '../widgets/responsive_layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Starter'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => context.push('/about'),
            tooltip: 'About',
          ),
        ],
      ),
      body: ResponsiveLayout(
        mobile: _buildMobileLayout(context),
        tablet: _buildTabletLayout(context),
        desktop: _buildDesktopLayout(context),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildWelcomeCard(context),
          const SizedBox(height: 16),
          _buildPlatformInfo(context),
          const SizedBox(height: 16),
          _buildFeatures(context),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildWelcomeCard(context),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildPlatformInfo(context)),
              const SizedBox(width: 24),
              Expanded(child: _buildFeatures(context)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildWelcomeCard(context),
            const SizedBox(height: 32),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildPlatformInfo(context)),
                  const SizedBox(width: 32),
                  Expanded(child: _buildFeatures(context)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeCard(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Icon(
              Icons.rocket_launch,
              size: 64,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'Welcome to Flutter Starter',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'A cross-platform application supporting Mobile, Desktop, and Web',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlatformInfo(BuildContext context) {
    return PlatformCard(
      title: 'Platform Information',
      icon: Icons.devices,
      children: [
        _buildInfoRow('Platform', PlatformInfo.platformName),
        _buildInfoRow('Type', PlatformInfo.platformType),
        _buildInfoRow('Web Support', PlatformInfo.isWeb ? 'Yes' : 'No'),
        _buildInfoRow('Mobile Support', PlatformInfo.isMobile ? 'Yes' : 'No'),
        _buildInfoRow('Desktop Support', PlatformInfo.isDesktop ? 'Yes' : 'No'),
      ],
    );
  }

  Widget _buildFeatures(BuildContext context) {
    return PlatformCard(
      title: 'Features',
      icon: Icons.star,
      children: [
        _buildFeatureItem('Material Design 3', Icons.palette),
        _buildFeatureItem('Responsive Layout', Icons.view_quilt),
        _buildFeatureItem('Navigation', Icons.navigation),
        _buildFeatureItem('State Management', Icons.settings_input_component),
        _buildFeatureItem('Dark Mode Support', Icons.dark_mode),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 12),
          Text(title),
        ],
      ),
    );
  }
}
