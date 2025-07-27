import 'package:flutter/material.dart';
import 'package:prepinbengali/theme/app_theme.dart';

class CourseTabScreen extends StatelessWidget {
  const CourseTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Page Title
          Text(
            'Courses',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          
          const SizedBox(height: 8),
          
          Text(
            'Structured learning paths for Bengali preparation',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Coming Soon Card
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(12),
                boxShadow: AppTheme.getCardShadow(context),
              ),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.1),
                      ),
                      child: Icon(
                        Icons.school_rounded,
                        size: 64,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    Text(
                      'Courses Coming Soon!',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    Text(
                      'We are creating comprehensive Bengali courses tailored for different learning levels. From beginner to advanced preparation materials!',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Course categories
                    Column(
                      children: [
                        _buildCourseCategory(
                          context,
                          Icons.auto_stories_rounded,
                          'Basic Bengali',
                          'Foundation course for beginners',
                          Colors.blue,
                        ),
                        _buildCourseCategory(
                          context,
                          Icons.menu_book_rounded,
                          'Intermediate Bengali',
                          'Build your Bengali skills',
                          Colors.orange,
                        ),
                        _buildCourseCategory(
                          context,
                          Icons.library_books_rounded,
                          'Advanced Bengali',
                          'Master Bengali language',
                          Colors.purple,
                        ),
                        _buildCourseCategory(
                          context,
                          Icons.quiz_rounded,
                          'Exam Preparation',
                          'Competitive exam focused',
                          Colors.green,
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
  
  Widget _buildCourseCategory(
    BuildContext context,
    IconData icon,
    String title,
    String description,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
            color: color,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
