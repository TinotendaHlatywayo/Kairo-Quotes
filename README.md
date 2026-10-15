# Kairo Quotes

Offline-first Flutter Android app for EM Borehole Drilling to prepare quotations, invoices and receipts.

## Development setup

This project uses Flutter stable, Dart, JDK 21, and Android SDK Platform 36. The Flutter SDK is bundled in `.tooling/flutter`. From this folder, run:

```bash
export PATH="$PWD/.tooling/flutter/bin:$PATH"
export ANDROID_HOME="$HOME/Android/Sdk"
export PATH="$ANDROID_HOME/platform-tools:$PATH"
flutter config --android-sdk "$ANDROID_HOME"
flutter doctor --android-licenses
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

The release APK is debug-signed by default. See `docs/release_keystore.md` for private release signing, and `docs/user_guide.md` for the release user guide.

## Quotation PDF visual check

See [`docs/quotation_pdf_visual_check.md`](docs/quotation_pdf_visual_check.md) for the on-phone and side-by-side review steps. After sharing a sample PDF to this computer, render its pages with `scripts/render_quote_pdf.sh path/to/quote.pdf`. The reference image should be available as `reference/quotation_template.jpeg` for exact comparison.

The app has no cloud backend or analytics SDK. The release Android manifest must remain free of the INTERNET permission.
