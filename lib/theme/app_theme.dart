import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppColors {
  // Primary Colors
  static const Color primaryLight = Color(0xFF6B46C1); // Deep Purple
  static const Color primaryDark = Color(0xFF8B5CF6); // Lighter Purple for dark mode
  
  // Secondary Colors
  static const Color secondaryLight = Color(0xFF059669); // Emerald
  static const Color secondaryDark = Color(0xFF10B981); // Lighter Emerald
  
  // Surface Colors
  static const Color surfaceLight = Color(0xFFFAFAFA);
  static const Color surfaceDark = Color(0xFF1F1F1F);
  
  // Background Colors
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF121212);
  
  // Text Colors
  static const Color onPrimaryLight = Color(0xFFFFFFFF);
  static const Color onPrimaryDark = Color(0xFF000000);
  
  static const Color onSurfaceLight = Color(0xFF1F2937);
  static const Color onSurfaceDark = Color(0xFFF9FAFB);
  
  // Accent Colors
  static const Color accent = Color(0xFFEF4444); // Red for errors/important actions
  static const Color success = Color(0xFF10B981); // Green for success
  static const Color warning = Color(0xFFF59E0B); // Amber for warnings
  static const Color info = Color(0xFF3B82F6); // Blue for info
  
  // Bengali Theme Colors (Cultural colors)
  static const Color bengaliRed = Color(0xFFDC2626); // Traditional Bengali red
  static const Color bengaliGold = Color(0xFFF59E0B); // Traditional gold
  static const Color bengaliGreen = Color(0xFF059669); // Traditional green
}

class AppShadows {
  // Light theme shadows
  static const List<BoxShadow> lightCardShadow = [
    BoxShadow(
      color: Color(0x1A000000), // 10% black
      offset: Offset(0, 2),
      blurRadius: 8,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x0D000000), // 5% black
      offset: Offset(0, 1),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];
  
  static const List<BoxShadow> lightElevatedShadow = [
    BoxShadow(
      color: Color(0x26000000), // 15% black
      offset: Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x1A000000), // 10% black
      offset: Offset(0, 2),
      blurRadius: 6,
      spreadRadius: 0,
    ),
  ];
  
  // Dark theme shadows
  static const List<BoxShadow> darkCardShadow = [
    BoxShadow(
      color: Color(0x33000000), // 20% black
      offset: Offset(0, 2),
      blurRadius: 8,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x1A000000), // 10% black
      offset: Offset(0, 1),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];
  
  static const List<BoxShadow> darkElevatedShadow = [
    BoxShadow(
      color: Color(0x4D000000), // 30% black
      offset: Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x33000000), // 20% black
      offset: Offset(0, 2),
      blurRadius: 6,
      spreadRadius: 0,
    ),
  ];
}

class AppTheme {
  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryLight,
      secondary: AppColors.secondaryLight,
      surface: AppColors.surfaceLight,
      onPrimary: AppColors.onPrimaryLight,
      onSurface: AppColors.onSurfaceLight,
      error: AppColors.accent,
    ),
    
    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.primaryLight,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryLight,
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    
    // Card Theme
    cardTheme: const CardTheme(
      color: AppColors.backgroundLight,
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    
    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: AppColors.onPrimaryLight,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    
    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryLight,
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    
    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryLight, width: 2),
      ),
      labelStyle: const TextStyle(color: AppColors.onSurfaceLight),
    ),
    
    // Floating Action Button Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryLight,
      foregroundColor: AppColors.onPrimaryLight,
    ),
  );
  
  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryDark,
      secondary: AppColors.secondaryDark,
      surface: AppColors.surfaceDark,
      onPrimary: AppColors.onPrimaryDark,
      onSurface: AppColors.onSurfaceDark,
      error: AppColors.accent,
    ),
    
    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.primaryDark,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryDark,
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    
    // Card Theme
    cardTheme: const CardTheme(
      color: AppColors.surfaceDark,
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    
    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryDark,
        foregroundColor: AppColors.onPrimaryDark,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    
    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryDark,
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    
    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.backgroundDark,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryDark, width: 2),
      ),
      labelStyle: const TextStyle(color: AppColors.onSurfaceDark),
    ),
    
    // Floating Action Button Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryDark,
      foregroundColor: AppColors.onPrimaryDark,
    ),
  );
  
  // Helper methods to get shadows based on theme
  static List<BoxShadow> getCardShadow(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.light 
        ? AppShadows.lightCardShadow 
        : AppShadows.darkCardShadow;
  }
  
  static List<BoxShadow> getElevatedShadow(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.light 
        ? AppShadows.lightElevatedShadow 
        : AppShadows.darkElevatedShadow;
  }
}

// Theme Mode Enum
enum AppThemeMode {
  light,
  dark,
  system,
}

extension AppThemeModeExtension on AppThemeMode {
  String get name {
    switch (this) {
      case AppThemeMode.light:
        return 'Light';
      case AppThemeMode.dark:
        return 'Dark';
      case AppThemeMode.system:
        return 'System';
    }
  }
  
  ThemeMode get themeMode {
    switch (this) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }
  
  IconData get icon {
    switch (this) {
      case AppThemeMode.light:
        return Icons.light_mode;
      case AppThemeMode.dark:
        return Icons.dark_mode;
      case AppThemeMode.system:
        return Icons.settings_brightness;
    }
  }
}
