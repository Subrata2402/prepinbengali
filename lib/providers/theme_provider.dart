import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _themeKey = 'theme_mode';
  AppThemeMode _themeMode = AppThemeMode.system;
  
  AppThemeMode get themeMode => _themeMode;
  
  ThemeProvider() {
    _loadTheme();
  }
  
  // Load theme from shared preferences
  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeModeString = prefs.getString(_themeKey);
      
      if (themeModeString != null) {
        switch (themeModeString) {
          case 'light':
            _themeMode = AppThemeMode.light;
            break;
          case 'dark':
            _themeMode = AppThemeMode.dark;
            break;
          case 'system':
          default:
            _themeMode = AppThemeMode.system;
            break;
        }
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading theme: $e');
    }
  }
  
  // Save theme to shared preferences
  Future<void> _saveTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String themeModeString;
      
      switch (_themeMode) {
        case AppThemeMode.light:
          themeModeString = 'light';
          break;
        case AppThemeMode.dark:
          themeModeString = 'dark';
          break;
        case AppThemeMode.system:
          themeModeString = 'system';
          break;
      }
      
      await prefs.setString(_themeKey, themeModeString);
    } catch (e) {
      debugPrint('Error saving theme: $e');
    }
  }
  
  // Set theme mode
  Future<void> setThemeMode(AppThemeMode mode) async {
    if (_themeMode != mode) {
      _themeMode = mode;
      await _saveTheme();
      notifyListeners();
    }
  }
  
  // Toggle between light and dark (ignoring system)
  Future<void> toggleTheme() async {
    switch (_themeMode) {
      case AppThemeMode.light:
        await setThemeMode(AppThemeMode.dark);
        break;
      case AppThemeMode.dark:
        await setThemeMode(AppThemeMode.light);
        break;
      case AppThemeMode.system:
        await setThemeMode(AppThemeMode.light);
        break;
    }
  }
  
  // Get current brightness based on system settings
  Brightness getCurrentBrightness(BuildContext context) {
    switch (_themeMode) {
      case AppThemeMode.light:
        return Brightness.light;
      case AppThemeMode.dark:
        return Brightness.dark;
      case AppThemeMode.system:
        return MediaQuery.of(context).platformBrightness;
    }
  }
  
  // Check if current theme is dark
  bool isDarkMode(BuildContext context) {
    return getCurrentBrightness(context) == Brightness.dark;
  }
}
