#!/bin/bash

# Firebase Setup Helper Script for Prep in Bengali
# This script helps set up Firebase for the Flutter app

echo "🚀 Firebase Setup Helper for Prep in Bengali"
echo "=============================================="
echo ""

# Check if FlutterFire CLI is installed
echo "1. Checking FlutterFire CLI..."
if command -v flutterfire &> /dev/null; then
    echo "✅ FlutterFire CLI is installed"
else
    echo "❌ FlutterFire CLI not found. Installing..."
    dart pub global activate flutterfire_cli
    if [ $? -eq 0 ]; then
        echo "✅ FlutterFire CLI installed successfully"
    else
        echo "❌ Failed to install FlutterFire CLI"
        exit 1
    fi
fi

echo ""
echo "2. Flutter Doctor Check..."
flutter doctor

echo ""
echo "3. Getting SHA-1 Fingerprint for Android..."
echo "   This is needed for Google Sign-In setup in Firebase Console"
echo ""
cd android
./gradlew signingReport | grep SHA1
cd ..

echo ""
echo "🔧 Next Steps:"
echo "==============="
echo ""
echo "1. Go to Firebase Console: https://console.firebase.google.com/"
echo "2. Create a new project or select existing project"
echo "3. Add Android app with package name: com.example.prepinbengali"
echo "4. Copy the SHA-1 fingerprint above and add it to Firebase Console"
echo "5. Download google-services.json and place it in android/app/"
echo "6. Enable Authentication > Google Sign-In in Firebase Console"
echo "7. Run: flutterfire configure"
echo "8. Test with: flutter run"
echo ""
echo "📚 For detailed instructions, see:"
echo "   - FIREBASE_SETUP.md"
echo "   - GOOGLE_LOGIN_SETUP.md"
echo "   - IMPLEMENTATION_SUMMARY.md"
echo ""
echo "✨ Happy coding!"
