# Google Console Setup Instructions

## 1. Create/Configure Firebase Project

### Step 1: Go to Firebase Console
- Visit [Firebase Console](https://console.firebase.google.com/)
- Click "Create a project" or select existing project

### Step 2: Add Android App
1. Click "Add app" → Select Android
2. Enter package name: `com.example.prepinbengali`
3. Download `google-services.json`
4. Place it in `android/app/` directory

### Step 3: Add iOS App (if needed)
1. Click "Add app" → Select iOS
2. Enter bundle ID: `com.example.prepinbengali`
3. Download `GoogleService-Info.plist`
4. Add to iOS project in Xcode

### Step 4: Enable Authentication
1. Go to Authentication → Sign-in method
2. Enable "Google" provider
3. Add your project's SHA-1 fingerprint (see below)

## 2. Get SHA-1 Fingerprint for Android

### For Debug (Development):
```bash
cd android
./gradlew signingReport
```

Look for the SHA1 fingerprint under "Variant: debug" and copy it.

### For Release (Production):
You'll need to generate a release keystore and get its SHA-1 fingerprint.

## 3. Add SHA-1 to Firebase

1. Go to Project Settings in Firebase Console
2. Select your Android app
3. Click "Add fingerprint"
4. Paste your SHA-1 fingerprint
5. Save changes

## 4. Update Firebase Configuration

### Option A: Use FlutterFire CLI (Recommended)
```bash
# Install FlutterFire CLI globally
dart pub global activate flutterfire_cli

# Run configuration
flutterfire configure
```

### Option B: Manual Update
Update `lib/firebase_options.dart` with your actual Firebase project values from the Firebase console.

## 5. Test the Integration

```bash
# Clean and rebuild
flutter clean
flutter pub get

# Run the app
flutter run
```

## Troubleshooting

### Common Issues:

1. **"Google Sign In failed"**
   - Check if SHA-1 fingerprint is correctly added
   - Verify google-services.json is in android/app/
   - Make sure package name matches in Firebase console

2. **"FirebaseOptions not configured"**
   - Update firebase_options.dart with correct values
   - Or use FlutterFire CLI to auto-configure

3. **"Network error during sign in"**
   - Check internet connection
   - Verify Firebase project is active
   - Check if Google provider is enabled in Authentication

### Debug Steps:
1. Check `flutter doctor` for any issues
2. Verify all files are in correct locations
3. Clean and rebuild: `flutter clean && flutter pub get`
4. Check Firebase console for any configuration issues

## Security Notes

- Never commit API keys to version control
- Use different Firebase projects for development and production
- Regularly rotate and monitor API key usage
- Consider using Firebase App Check for additional security
