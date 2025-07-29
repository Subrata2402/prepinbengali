import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/google_auth_service.dart';
import '../providers/theme_provider.dart';
import '../theme/app_theme.dart';
import '../screens/settings_screen.dart';
import '../screens/about_screen.dart';
import '../screens/contact_screen.dart';
import '../screens/privacy_policy_screen.dart';
import '../screens/terms_conditions_screen.dart';
import '../screens/help_faq_screen.dart';
import '../widgets/auth_wrapper.dart';

class MenuTabScreen extends StatelessWidget {
  const MenuTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GoogleAuthService authService = GoogleAuthService();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('PrepInBengali'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 4.0,
        shadowColor: Theme.of(context).colorScheme.shadow,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
        
        // Settings Section
        _buildSectionHeader(context, 'Settings'),
        _buildMenuCard(
          context,
          children: [
            _buildMenuItem(
              context,
              icon: Icons.settings_rounded,
              title: 'Settings',
              subtitle: 'App preferences and configuration',
              onTap: () => _navigateToScreen(context, const SettingsScreen()),
            ),
            // _buildMenuItem(
            //   context,
            //   icon: Icons.palette_rounded,
            //   title: 'Theme Configuration',
            //   subtitle: 'Customize app appearance',
            //   onTap: () => _showThemeDialog(context),
            // ),
          ],
        ),
        
        const SizedBox(height: 24),
        
        // Information Section
        _buildSectionHeader(context, 'Information'),
        _buildMenuCard(
          context,
          children: [
            _buildMenuItem(
              context,
              icon: Icons.info_rounded,
              title: 'About Us',
              subtitle: 'Learn about Prep in Bengali',
              onTap: () => _navigateToScreen(context, const AboutScreen()),
            ),
            _buildMenuItem(
              context,
              icon: Icons.contact_support_rounded,
              title: 'Contact Us',
              subtitle: 'Get in touch with our team',
              onTap: () => _navigateToScreen(context, const ContactScreen()),
            ),
          ],
        ),
        
        const SizedBox(height: 24),
        
        // Legal Section
        _buildSectionHeader(context, 'Legal'),
        _buildMenuCard(
          context,
          children: [
            _buildMenuItem(
              context,
              icon: Icons.privacy_tip_rounded,
              title: 'Privacy Policy',
              subtitle: 'How we protect your data',
              onTap: () => _navigateToScreen(context, const PrivacyPolicyScreen()),
            ),
            _buildMenuItem(
              context,
              icon: Icons.description_rounded,
              title: 'Terms & Conditions',
              subtitle: 'Terms of service',
              onTap: () => _navigateToScreen(context, const TermsConditionsScreen()),
            ),
          ],
        ),
        
        const SizedBox(height: 24),
        
        // Support Section
        _buildSectionHeader(context, 'Support'),
        _buildMenuCard(
          context,
          children: [
            _buildMenuItem(
              context,
              icon: Icons.help_rounded,
              title: 'Help & FAQ',
              subtitle: 'Get answers to common questions',
              onTap: () => _navigateToScreen(context, const HelpFaqScreen()),
            ),
          ],
        ),
        
        const SizedBox(height: 24),
        
        // App Version
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.circular(12),
            boxShadow: AppTheme.getCardShadow(context),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'App Version',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Version 1.0.0',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Sign Out Button
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.circular(12),
            boxShadow: AppTheme.getCardShadow(context),
          ),
          child: ListTile(
            leading: Icon(
              Icons.logout_rounded,
              color: Colors.red,
            ),
            title: const Text(
              'Sign Out',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: const Text('Sign out of your account'),
            onTap: () => _showSignOutDialog(context, authService),
          ),
        ),
        
        const SizedBox(height: 80),
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
  
  Widget _buildMenuCard(BuildContext context, {required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: AppTheme.getCardShadow(context),
      ),
      child: Column(
        children: children,
      ),
    );
  }
  
  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 16,
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
      ),
      onTap: onTap,
    );
  }
  
  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => screen),
    );
  }
  
  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return AlertDialog(
              title: const Text('Choose Theme'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile(
                    title: const Row(
                      children: [
                        Icon(Icons.light_mode, size: 20),
                        SizedBox(width: 8),
                        Text('Light'),
                      ],
                    ),
                    value: 0,
                    groupValue: themeProvider.themeMode.index,
                    onChanged: (value) {
                      themeProvider.setThemeMode(AppThemeMode.values[0]);
                      Navigator.of(context).pop();
                    },
                  ),
                  RadioListTile(
                    title: const Row(
                      children: [
                        Icon(Icons.dark_mode, size: 20),
                        SizedBox(width: 8),
                        Text('Dark'),
                      ],
                    ),
                    value: 1,
                    groupValue: themeProvider.themeMode.index,
                    onChanged: (value) {
                      themeProvider.setThemeMode(AppThemeMode.values[1]);
                      Navigator.of(context).pop();
                    },
                  ),
                  RadioListTile(
                    title: const Row(
                      children: [
                        Icon(Icons.settings_brightness, size: 20),
                        SizedBox(width: 8),
                        Text('System'),
                      ],
                    ),
                    value: 2,
                    groupValue: themeProvider.themeMode.index,
                    onChanged: (value) {
                      themeProvider.setThemeMode(AppThemeMode.values[2]);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
  
  void _showSignOutDialog(BuildContext context, GoogleAuthService authService) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sign Out'),
          content: const Text('Are you sure you want to sign out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close dialog
                
                try {
                  await authService.signOut();
                  
                  if (context.mounted) {
                    // Navigate back to the root and replace with AuthWrapper
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const AuthWrapper(),
                      ),
                      (route) => false,
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error signing out: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              child: const Text(
                'Sign Out',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
