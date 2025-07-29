import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
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
              'Privacy Policy',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Last updated: ${DateTime.now().year}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            
            const SizedBox(height: 24),
            
            _buildSection(
              context,
              title: '1. Information We Collect',
              content: 'We collect information you provide directly to us, such as when you create an account, update your profile, use our services, or contact us. This may include:\n\n• Name and email address\n• Profile information\n• Study progress and preferences\n• Device information and usage data',
            ),
            
            _buildSection(
              context,
              title: '2. How We Use Your Information',
              content: 'We use the information we collect to:\n\n• Provide, maintain, and improve our services\n• Process transactions and send related information\n• Send technical notices and support messages\n• Respond to your comments and questions\n• Personalize your learning experience\n• Analyze usage patterns to improve our app',
            ),
            
            _buildSection(
              context,
              title: '3. Information Sharing',
              content: 'We do not sell, trade, or otherwise transfer your personal information to third parties without your consent, except:\n\n• To trusted third parties who assist us in operating our app\n• When required by law or to protect our rights\n• In connection with a business transfer or acquisition',
            ),
            
            _buildSection(
              context,
              title: '4. Data Security',
              content: 'We implement appropriate security measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction. However, no method of transmission over the internet is 100% secure.',
            ),
            
            _buildSection(
              context,
              title: '5. Third-Party Services',
              content: 'Our app may use third-party services such as:\n\n• Google Services for authentication\n• Firebase for data storage and analytics\n• Other educational content providers\n\nThese services have their own privacy policies that govern their use of your information.',
            ),
            
            _buildSection(
              context,
              title: '6. Children\'s Privacy',
              content: 'Our service is intended for users of all ages. We take special care to protect the privacy of users under 13 and comply with applicable children\'s privacy laws.',
            ),
            
            _buildSection(
              context,
              title: '7. Your Rights',
              content: 'You have the right to:\n\n• Access your personal information\n• Correct inaccurate information\n• Delete your account and personal data\n• Opt out of certain communications\n• Request data portability',
            ),
            
            _buildSection(
              context,
              title: '8. Changes to This Policy',
              content: 'We may update this privacy policy from time to time. We will notify you of any changes by posting the new policy on this page and updating the "last updated" date.',
            ),
            
            _buildSection(
              context,
              title: '9. Contact Us',
              content: 'If you have any questions about this privacy policy, please contact us at:\n\nEmail: support@prepinbengali.in\nAddress: Midnapore, West Bengal, India',
            ),
            
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSection(BuildContext context, {required String title, required String content}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
