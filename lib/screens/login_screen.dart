import 'package:flutter/material.dart';
import '../services/google_auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleAuthService _authService = GoogleAuthService();
  bool _isLoading = false;

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final userCredential = await _authService.signInWithGoogle();

      if (userCredential != null && mounted) {
        // Navigate to home screen or show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Successfully signed in with Google!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to sign in: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App Logo or Title
                // Container(
                //   padding: const EdgeInsets.all(20),
                //   decoration: BoxDecoration(
                //     shape: BoxShape.circle,
                //     color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                //   ),
                //   child: Icon(
                //     Icons.school_rounded,
                //     size: 80,
                //     color: Theme.of(context).colorScheme.primary,
                //   ),
                // ),
                // const SizedBox(height: 32),
                // Text(
                //   'Prep in Bengali',
                //   style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                //     fontWeight: FontWeight.bold,
                //     color: Theme.of(context).colorScheme.primary,
                //   ),
                // ),
                // const SizedBox(height: 8),
                // Text(
                //   'Learn and prepare in Bengali',
                //   style: Theme.of(context).textTheme.titleMedium?.copyWith(
                //     color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                Image.asset(
                  'assets/images/app_logo.png',
                  // height: 24,
                  // width: 24,
                  // color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 48),

                // Google Sign In Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child:
                      _isLoading
                          ? Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.grey.shade400),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12),
                                Text(
                                  'Signing in...',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          )
                          : Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(50),
                            child: InkWell(
                              onTap: _signInWithGoogle,
                              borderRadius: BorderRadius.circular(50),
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/google_logo.png',
                                      height: 24,
                                      width: 24,
                                    ),
                                    const SizedBox(width: 12),
                                    const Text(
                                      'Continue with Google',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF3C4043),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                ),

                const SizedBox(height: 24),

                // Terms and Privacy
                Text(
                  'By signing in, you agree to our Terms of Service and Privacy Policy',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
