import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/google_auth_service.dart';
import '../providers/theme_provider.dart';
import '../theme/app_theme.dart';
import '../screens/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GoogleAuthService _authService = GoogleAuthService();

  Future<void> _signOut() async {
    await _authService.signOut();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Successfully signed out!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = _authService.currentUser;
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prep in Bengali'),
        actions: [
          // Theme toggle button
          IconButton(
            icon: Icon(themeProvider.themeMode.icon),
            onPressed: () => themeProvider.toggleTheme(),
            tooltip: 'Toggle Theme',
          ),
          // Settings button
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
            tooltip: 'Settings',
          ),
          // Sign out button
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _signOut,
            tooltip: 'Sign Out',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Message
            Text(
              'Welcome back, ${user?.displayName?.toString().split(" ").first ?? 'Guest'}!',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            
            const SizedBox(height: 8),
            
            Text(
              'Continue your Bengali learning journey',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Feature Cards
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildFeatureCard(
                    context: context,
                    icon: Icons.book_rounded,
                    title: 'Study Materials',
                    description: 'Access Bengali study resources',
                    gradient: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.primary.withValues(alpha: 0.7),
                    ],
                    onTap: () {
                      _showComingSoonDialog(context, 'Study Materials');
                    },
                  ),
                  _buildFeatureCard(
                    context: context,
                    icon: Icons.quiz_rounded,
                    title: 'Practice Tests',
                    description: 'Take practice exams',
                    gradient: [
                      Theme.of(context).colorScheme.secondary,
                      Theme.of(context).colorScheme.secondary.withValues(alpha: 0.7),
                    ],
                    onTap: () {
                      _showComingSoonDialog(context, 'Practice Tests');
                    },
                  ),
                  _buildFeatureCard(
                    context: context,
                    icon: Icons.trending_up_rounded,
                    title: 'Progress',
                    description: 'Track your learning progress',
                    gradient: [
                      Colors.orange,
                      Colors.orange.withValues(alpha: 0.7),
                    ],
                    onTap: () {
                      _showComingSoonDialog(context, 'Progress Tracking');
                    },
                  ),
                  _buildFeatureCard(
                    context: context,
                    icon: Icons.person_rounded,
                    title: 'Profile',
                    description: 'Manage your profile',
                    gradient: [
                      Colors.teal,
                      Colors.teal.withValues(alpha: 0.7),
                    ],
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SettingsScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                gradient[0].withValues(alpha: 0.1),
                gradient[1].withValues(alpha: 0.05),
              ],
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradient,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showComingSoonDialog(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.construction_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              const Text('Coming Soon'),
            ],
          ),
          content: Text(
            '$feature feature is under development. Stay tuned for updates!',
          ),
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
