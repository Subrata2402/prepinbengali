import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/welcome_screen.dart';
import '../screens/login_screen.dart';
import '../screens/main_screen.dart';
import '../screens/onboarding_questions_screen.dart';
import '../services/google_auth_service.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  static const String _hasSeenWelcomeKey = 'has_seen_welcome';
  static const String _onboardingCompletedKey = 'onboarding_completed';
  bool _hasSeenWelcome = false;
  bool _isCheckingWelcome = true;

  @override
  void initState() {
    super.initState();
    _checkWelcomeStatus();
  }

  Future<void> _checkWelcomeStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final hasSeenWelcome = prefs.getBool(_hasSeenWelcomeKey) ?? false;
      
      if (mounted) {
        setState(() {
          _hasSeenWelcome = hasSeenWelcome;
          _isCheckingWelcome = false;
        });
      }
    } catch (e) {
      debugPrint('Error checking welcome status: $e');
      if (mounted) {
        setState(() {
          _isCheckingWelcome = false;
        });
      }
    }
  }

  Future<bool> _checkOnboardingStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_onboardingCompletedKey) ?? false;
    } catch (e) {
      debugPrint('Error checking onboarding status: $e');
      return false;
    }
  }

  Future<void> _markWelcomeAsSeen() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_hasSeenWelcomeKey, true);
      
      if (mounted) {
        setState(() {
          _hasSeenWelcome = true;
        });
      }
    } catch (e) {
      debugPrint('Error marking welcome as seen: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show loading while checking welcome status
    if (_isCheckingWelcome) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Show welcome screen if user hasn't seen it
    if (!_hasSeenWelcome) {
      return WelcomeScreen(
        onGetStarted: _markWelcomeAsSeen,
      );
    }

    // Show auth-based screens
    final GoogleAuthService authService = GoogleAuthService();
    
    return StreamBuilder<User?>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        // Show loading indicator while waiting for auth state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        
        // Show appropriate screen based on auth state
        if (snapshot.hasData && snapshot.data != null) {
          // User is signed in - check if onboarding is completed
          return FutureBuilder<bool>(
            future: _checkOnboardingStatus(),
            builder: (context, onboardingSnapshot) {
              if (onboardingSnapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              
              final onboardingCompleted = onboardingSnapshot.data ?? false;
              if (onboardingCompleted) {
                return const MainScreen();
              } else {
                return const OnboardingQuestionsScreen();
              }
            },
          );
        } else {
          // User is not signed in
          return const LoginScreen();
        }
      },
    );
  }
}
