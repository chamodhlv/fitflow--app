# FitFlow

FitFlow is a Flutter mobile prototype for the IT3060 case study. It includes an adaptive AI Daily Flow, a private community view, and a low-friction nutrition logging entry point.

## Run locally

1. Install Flutter and Android SDK platform 35 or newer.
2. Run `flutter pub get`.
3. Run `flutter run` on an Android emulator or device.

## Activity 1 - signed Android release

The app version is `1.0.0+1`: Flutter maps this to Android `versionName` 1.0.0 and `versionCode` 1. Increment the number after `+` before every Play upload.

### Keystore management

Create the local upload keystore once. Keep it outside source control and store its credentials in the team's approved secret manager:

```powershell
New-Item -ItemType Directory -Force android/keystores
keytool -genkeypair -v -keystore android/keystores/fitflow-upload.jks -alias fitflow-upload -keyalg RSA -keysize 4096 -validity 10000
Copy-Item android/key.properties.example android/key.properties
```

Update `android/key.properties` with the passwords used by `keytool`. This file and the keystore are excluded from Git. Back up the keystore securely: losing it prevents updates unless Google Play App Signing recovery is available.

### Build and verify

```powershell
flutter pub get
flutter build appbundle --release
flutter build apk --release --split-per-abi
keytool -list -v -keystore android/keystores/fitflow-upload.jks -alias fitflow-upload
```

The AAB is written to `build/app/outputs/bundle/release/app-release.aab`. APKs are in `build/app/outputs/flutter-apk/`. The release configuration enables R8 minification and resource shrinking, uses Flutter's supported minimum Android SDK, and targets the SDK selected by the installed Flutter SDK. Check the final AAB/APK in Android Studio's APK Analyzer and install an APK on the lowest supported Android version before submitting.
