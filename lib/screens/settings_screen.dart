import 'package:flutter/material.dart';
import 'package:prepinbengali/providers/theme_provider.dart';
import 'package:prepinbengali/theme/app_theme.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 4.0,
        shadowColor: Theme.of(context).colorScheme.shadow,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Theme Section
          _buildSectionHeader(context, 'Appearance'),
          _buildThemeCard(context),
          
          const SizedBox(height: 24),
          
          // App Info Section
          _buildSectionHeader(context, 'About'),
          _buildAppInfoCard(context),
          
          const SizedBox(height: 24),
          
          // Other Settings
          _buildSectionHeader(context, 'Preferences'),
          _buildPreferencesCard(context),

           SizedBox(height: 80),
        ],
      ),
    );
  }
  
  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
        ),
      ),
    );
  }
  
  Widget _buildThemeCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: AppTheme.getCardShadow(context),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.palette_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: const Text('Theme'),
            subtitle: const Text('Choose your preferred theme'),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return Column(
                  children: AppThemeMode.values.map((mode) {
                    return RadioListTile<AppThemeMode>(
                      title: Row(
                        children: [
                          Icon(
                            mode.icon,
                            size: 20,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          const SizedBox(width: 12),
                          Text(mode.name),
                        ],
                      ),
                      value: mode,
                      groupValue: themeProvider.themeMode,
                      onChanged: (AppThemeMode? value) {
                        if (value != null) {
                          themeProvider.setThemeMode(value);
                        }
                      },
                      activeColor: Theme.of(context).colorScheme.primary,
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildAppInfoCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: AppTheme.getCardShadow(context),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.info_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: const Text('App Information'),
            subtitle: const Text('Learn more about Prep in Bengali'),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              children: [
                _buildInfoRow(context, 'Version', '1.0.0'),
                _buildInfoRow(context, 'Developer', 'Prep in Bengali Team'),
                _buildInfoRow(context, 'Language', 'Bengali & English'),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextButton.icon(
                        onPressed: () {
                          // TODO: Implement privacy policy
                          _showInfoDialog(context, 'Privacy Policy', 
                            'Your privacy is important to us. We collect minimal data necessary for app functionality.');
                        },
                        icon: const Icon(Icons.privacy_tip_rounded),
                        label: const Text('Privacy Policy'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextButton.icon(
                        onPressed: () {
                          // TODO: Implement terms of service
                          _showInfoDialog(context, 'Terms of Service', 
                            'By using this app, you agree to our terms and conditions.');
                        },
                        icon: const Icon(Icons.description_rounded),
                        label: const Text('Terms'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPreferencesCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: AppTheme.getCardShadow(context),
      ),
      child: Column(
        children: [
          SwitchListTile(
            secondary: Icon(
              Icons.notifications_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: const Text('Notifications'),
            subtitle: const Text('Receive study reminders and updates'),
            value: true, // TODO: Implement actual preference state
            onChanged: (bool value) {
              // TODO: Implement notification toggle
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Notifications ${value ? 'enabled' : 'disabled'}'),
                ),
              );
            },
            activeColor: Theme.of(context).colorScheme.primary,
          ),
          SwitchListTile(
            secondary: Icon(
              Icons.download_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: const Text('Auto-download Updates'),
            subtitle: const Text('Automatically download new content'),
            value: false, // TODO: Implement actual preference state
            onChanged: (bool value) {
              // TODO: Implement auto-download toggle
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Auto-download ${value ? 'enabled' : 'disabled'}'),
                ),
              );
            },
            activeColor: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
  
  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
  
  void _showInfoDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
