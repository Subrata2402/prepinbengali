import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';
import '../services/google_auth_service.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
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
          // User is signed in
          return const HomeScreen();
        } else {
          // User is not signed in
          return const LoginScreen();
        }
      },
    );
  }
}
