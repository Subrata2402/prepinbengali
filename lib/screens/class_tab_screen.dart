import 'package:flutter/material.dart';
import 'package:prepinbengali/theme/app_theme.dart';

class ClassTabScreen extends StatelessWidget {
  const ClassTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Page Title
          Text(
            'Classes',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Join live classes and interactive sessions',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),

          // const SizedBox(height: 32),

          // Coming Soon Card
          Expanded(
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: AppTheme.getCardShadow(context),
                ),
                  padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.1),
                      ),
                      child: Icon(
                        Icons.video_library_rounded,
                        size: 64,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                
                    const SizedBox(height: 24),
                
                    Text(
                      'Classes Coming Soon!',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                
                    const SizedBox(height: 16),
                
                    Text(
                      'We are preparing interactive Bengali classes for you. Stay tuned for live sessions, recorded lectures, and much more!',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                
                    const SizedBox(height: 24),
                
                    // Feature highlights
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFeatureItem(
                          context,
                          Icons.live_tv_rounded,
                          'Live Interactive Classes',
                        ),
                        _buildFeatureItem(
                          context,
                          Icons.play_circle_rounded,
                          'Recorded Lectures',
                        ),
                        _buildFeatureItem(
                          context,
                          Icons.group_rounded,
                          'Group Discussions',
                        ),
                        _buildFeatureItem(
                          context,
                          Icons.assignment_rounded,
                          'Class Assignments',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(BuildContext context, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Text(text, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
