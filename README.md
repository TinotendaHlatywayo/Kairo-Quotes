# Kairo Quotes

Offline-first Flutter Android app for EM Borehole Drilling to prepare quotations, invoices and receipts.

## Development setup

This project uses Flutter stable, Dart, JDK 21, and Android SDK Platform 36. From this folder, run:

```bash
flutter doctor -v
flutter pub get
flutter run
```

Connect an Android 8+ phone with USB debugging enabled or start an Android emulator first.

## Release APK

```bash
flutter build apk --release
adb install -r build/app/outputs/flutter-apk/app-release.apk
```

The current release APK is debug-signed and intended for local installation. A private release keystore is planned for Stage 9.

The app has no cloud backend or analytics SDK. The release Android manifest must remain free of the INTERNET permission.
