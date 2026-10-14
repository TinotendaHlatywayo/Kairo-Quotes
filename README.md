# EM Quotes

Offline-first Flutter Android app for EM Borehole Drilling to prepare quotations, invoices and receipts.

## Development setup

The initial scaffold uses Flutter 3.47.7, Dart 3.13.5, JDK 21 and Android SDK Platform 36. In this development environment the free SDKs are installed under `/tmp/flutter-sdk` and `/tmp/android-sdk`.

```bash
export PATH="/tmp/flutter-sdk/bin:$PATH"
export ANDROID_HOME=/tmp/android-sdk
export ANDROID_SDK_ROOT=/tmp/android-sdk
flutter doctor -v
flutter pub get
flutter run
```

Connect a phone with Android 8+ and USB debugging enabled, accept its on-device debugging prompt, or start an emulator before `flutter run`.

## Release APK

```bash
flutter build apk --release
adb install build/app/outputs/flutter-apk/app-release.apk
```

The current release build uses Flutter's debug signing configuration and is for local installation only. Stage 9 will configure a private release keystore.

No cloud service or analytics SDK is used. The release Android manifest must remain free of the INTERNET permission. The debug and profile manifests retain Flutter's development-only INTERNET permission.
