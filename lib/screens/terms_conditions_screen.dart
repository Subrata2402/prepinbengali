import 'package:flutter/material.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
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
              'Terms and Conditions',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
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
              title: '1. Acceptance of Terms',
              content: 'By accessing and using PrepInBengali, you accept and agree to be bound by the terms and provision of this agreement. If you do not agree to abide by the above, please do not use this service.',
            ),
            
            _buildSection(
              context,
              title: '2. Description of Service',
              content: 'PrepInBengali is an educational platform that provides learning materials, practice exercises, and study tools for students preparing for various examinations. The service is provided "as is" and we reserve the right to modify or discontinue the service at any time.',
            ),
            
            _buildSection(
              context,
              title: '3. User Account and Registration',
              content: 'To access certain features of the service, you must register for an account. You agree to:\n\n• Provide accurate and complete registration information\n• Maintain the security of your password and account\n• Notify us immediately of any unauthorized use of your account\n• Accept responsibility for all activities under your account',
            ),
            
            _buildSection(
              context,
              title: '4. User Conduct',
              content: 'You agree not to use the service to:\n\n• Upload, post, or transmit any content that is unlawful, harmful, or offensive\n• Violate any applicable laws or regulations\n• Infringe upon the rights of others\n• Interfere with or disrupt the service or servers\n• Attempt to gain unauthorized access to any portion of the service',
            ),
            
            _buildSection(
              context,
              title: '5. Intellectual Property Rights',
              content: 'The service and its original content, features, and functionality are owned by PrepInBengali and are protected by international copyright, trademark, patent, trade secret, and other intellectual property laws.',
            ),
            
            _buildSection(
              context,
              title: '6. Content and Materials',
              content: 'All educational content, including but not limited to text, graphics, logos, images, audio clips, video clips, data compilations, and software, is the property of PrepInBengali or its content suppliers and is protected by copyright laws.',
            ),
            
            _buildSection(
              context,
              title: '7. Privacy Policy',
              content: 'Your privacy is important to us. Please refer to our Privacy Policy, which also governs your use of the service, to understand our practices.',
            ),
            
            _buildSection(
              context,
              title: '8. Disclaimer of Warranties',
              content: 'The information on this app is provided on an "as is" basis. To the fullest extent permitted by law, we disclaim all warranties, whether express or implied, including the warranty of merchantability, fitness for particular purpose, and non-infringement.',
            ),
            
            _buildSection(
              context,
              title: '9. Limitation of Liability',
              content: 'PrepInBengali shall not be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of profits or revenues, whether incurred directly or indirectly.',
            ),
            
            _buildSection(
              context,
              title: '10. Termination',
              content: 'We may terminate or suspend your account and bar access to the service immediately, without prior notice or liability, under our sole discretion, for any reason whatsoever, including without limitation if you breach the Terms.',
            ),
            
            _buildSection(
              context,
              title: '11. Changes to Terms',
              content: 'We reserve the right, at our sole discretion, to modify or replace these Terms at any time. If a revision is material, we will provide at least 30 days notice prior to any new terms taking effect.',
            ),
            
            _buildSection(
              context,
              title: '12. Contact Information',
              content: 'If you have any questions about these Terms and Conditions, please contact us at:\n\nEmail: legal@prepinbengali.com\nAddress: Dhaka, Bangladesh',
            ),
            
            const SizedBox(height: 32),
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
              color: Theme.of(context).colorScheme.primary,
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
