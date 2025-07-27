# Prep in Bengali - Google Login Setup

This Flutter app has been configured with Google Sign-In authentication using Firebase Auth. Follow the steps below to complete the setup.

## 🚀 Quick Start

The app is already configured with the basic Google Sign-In functionality. However, you need to set up Firebase project credentials to make it work.

## 📋 Setup Instructions

### 1. Create a Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project or use an existing one
3. Enable Authentication in the Firebase console
4. Enable Google as a sign-in provider in Authentication > Sign-in method

### 2. Configure Firebase for Flutter

#### Option A: Using FlutterFire CLI (Recommended)
```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase for your project
flutterfire configure
```

#### Option B: Manual Configuration
1. Download the configuration files:
   - For Android: `google-services.json` → `android/app/`
   - For iOS: `GoogleService-Info.plist` → `ios/Runner/`
   - For Web: Update `firebase_options.dart` with your web config

2. Update `lib/firebase_options.dart` with your actual Firebase project credentials

### 3. Android Configuration

For Google Sign-In to work on Android, you need to add your SHA-1 fingerprint to Firebase:

1. Get your SHA-1 fingerprint:
   ```bash
   cd android
   ./gradlew signingReport
   ```

2. Add the SHA-1 fingerprint to your Firebase project:
   - Go to Project Settings > Your Apps > Android App
   - Add the SHA-1 fingerprint

### 4. iOS Configuration (if building for iOS)

1. Add the `GoogleService-Info.plist` to your iOS project in Xcode
2. Ensure the bundle ID matches in Firebase console and Xcode

### 5. Web Configuration (if building for web)

1. Update the Firebase config in `lib/firebase_options.dart`
2. Enable the web app in Firebase console

## 🔧 Dependencies Added

- `google_sign_in: ^6.2.1` - Google Sign-In functionality
- `firebase_auth: ^5.1.4` - Firebase Authentication
- `firebase_core: ^3.3.0` - Firebase Core SDK

## 📱 Features Implemented

- ✅ Google Sign-In/Sign-Out
- ✅ User authentication state management
- ✅ User profile display (name, email, photo)
- ✅ Modern UI with Material Design 3
- ✅ Responsive design
- ✅ Error handling and loading states

## 🏗️ App Structure

```
lib/
├── main.dart                    # App entry point with Firebase initialization
├── firebase_options.dart        # Firebase configuration (update with your config)
├── services/
│   └── google_auth_service.dart # Google authentication service
├── screens/
│   ├── login_screen.dart        # Login screen with Google Sign-In button
│   └── home_screen.dart         # Home screen for authenticated users
└── widgets/
    └── auth_wrapper.dart        # Authentication state wrapper
```

## 🎨 UI/UX Features

- Clean, modern login screen
- User profile card with avatar
- Feature grid with placeholder sections
- Loading indicators and error messages
- Consistent theming with deep purple accent

## 🔒 Security Note

The current `firebase_options.dart` contains placeholder values. Make sure to replace them with your actual Firebase project configuration for the app to work properly.

## 🚀 Running the App

```bash
# Get dependencies
flutter pub get

# Run the app
flutter run
```

## 📝 Next Steps

1. Set up your Firebase project and update configuration
2. Add your authentication logic for other features
3. Implement additional screens (Study Materials, Practice Tests, etc.)
4. Add Bengali language support
5. Implement user preferences and progress tracking

## 🤝 Contributing

Feel free to contribute to this project by adding new features, improving the UI, or fixing bugs.
