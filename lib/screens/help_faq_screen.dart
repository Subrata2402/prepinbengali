import 'package:flutter/material.dart';
import 'package:prepinbengali/theme/app_theme.dart';

class HelpFaqScreen extends StatefulWidget {
  const HelpFaqScreen({super.key});

  @override
  State<HelpFaqScreen> createState() => _HelpFaqScreenState();
}

class _HelpFaqScreenState extends State<HelpFaqScreen> {
  final List<FAQItem> faqItems = [
    FAQItem(
      question: 'How do I create an account?',
      answer: 'You can create an account by clicking on the "Sign in with Google" button on the login screen. This will use your Google account to sign in.',
    ),
    FAQItem(
      question: 'Is the app free to use?',
      answer: 'Yes, PrepInBengali is completely free to use. We provide all our educational content and features at no cost.',
    ),
    FAQItem(
      question: 'What subjects are covered?',
      answer: 'We cover a wide range of subjects including Mathematics, Science, English, Bengali, and other subjects relevant to various competitive examinations.',
    ),
    FAQItem(
      question: 'How do I track my progress?',
      answer: 'Your progress is automatically tracked as you complete lessons and practice tests. You can view your progress from the Home tab.',
    ),
    FAQItem(
      question: 'Can I use the app offline?',
      answer: 'Some features may work offline, but an internet connection is required for the full experience, including syncing your progress and accessing new content.',
    ),
    FAQItem(
      question: 'How do I change the app theme?',
      answer: 'Go to the Menu tab, then tap on "Settings" and select "Theme". You can choose between Light, Dark, or System theme.',
    ),
    FAQItem(
      question: 'How do I reset my password?',
      answer: 'Since we use Google Sign-In, password management is handled by Google. You can reset your Google account password through Google\'s password recovery process.',
    ),
    FAQItem(
      question: 'How do I contact support?',
      answer: 'You can contact us through the "Contact Us" option in the Menu tab, or email us directly at support@prepinbengali.com.',
    ),
    FAQItem(
      question: 'Are there any practice tests available?',
      answer: 'Yes, we provide various practice tests and mock exams. You can access them from the Home tab under the Practice section.',
    ),
    FAQItem(
      question: 'How often is new content added?',
      answer: 'We regularly update our content based on the latest syllabus and examination patterns. New content is typically added weekly.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & FAQ'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 4.0,
        shadowColor: Theme.of(context).colorScheme.shadow,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'Frequently Asked Questions',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Find answers to common questions about PrepInBengali',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search FAQ...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                fillColor: Theme.of(context).colorScheme.surface,
                filled: true,
              ),
              onChanged: (value) {
                // TODO: Implement search functionality
              },
            ),
            
            const SizedBox(height: 24),
            
            // FAQ List
            ...faqItems.map((item) => _buildFAQItem(context, item)),
            
            const SizedBox(height: 24),
            
            // Contact Support Card
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(12),
                boxShadow: AppTheme.getCardShadow(context),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.support_agent_rounded,
                      size: 48,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Still Need Help?',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Can\'t find what you\'re looking for? Contact our support team and we\'ll be happy to help.',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/contact');
                      },
                      child: const Text('Contact Support'),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
  
  Widget _buildFAQItem(BuildContext context, FAQItem item) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: AppTheme.getCardShadow(context),
      ),
      margin: const EdgeInsets.only(bottom: 8),
      child: ExpansionTile(
        title: Text(
          item.question,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              item.answer,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});
}
