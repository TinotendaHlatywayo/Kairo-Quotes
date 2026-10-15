# Release signing

The default release APK is debug-signed. To sign a private release APK:

1. Generate a keystore:
   `keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload`
2. Add signing config in `android/app/build.gradle.kts` and point `storeFile`/`storePassword` through `key.properties`.
3. Keep keystore and `key.properties` out of version control.
4. Build with `flutter build apk --release` and verify the manifest still omits `android.permission.INTERNET`.
