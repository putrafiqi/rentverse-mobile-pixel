# Pixel Rentverse

Flutter application for Pixel Rentverse.

This documentation explains how to run the app for **development** and how to create **production/release** builds.

Other languages:

- Indonesian: see `README_ID.md`

## Prerequisites

- Flutter SDK installed.
  - Note: this project uses Dart SDK `^3.10.0-290.4.beta` (see `pubspec.yaml`), so you will likely need Flutter **beta** channel (or another channel that includes Dart 3.10).
- Android Studio + Android SDK (for Android).
- Xcode (macOS only, for iOS).

Verify versions:

```bash
flutter --version
dart --version
```

If you need to switch to beta:

```bash
flutter channel beta
flutter upgrade
```

## Project Structure (High Level)

- `lib/main.dart`: app entrypoint (reads `BASE_URL`).
- `lib/app/`: app setup, routes, blocs, views.
- `lib/data/`: repositories and services (API via Dio).
- `lib/core/`: themes, interceptors, types, validations.
- `assets/`: images and icons.

## Development Setup

1) Install dependencies:

```bash
flutter pub get
```

2) Run code generation (if using `json_serializable` models):

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

3) Run the app:

```bash
flutter run
```

### Environment Configuration (`BASE_URL`)

The app reads the API base URL from the compile-time env var `BASE_URL`.

- Default (when not set):
  - `http://localhost:3000/api/v1/m/`
- Override when running:

```bash
flutter run --dart-define=BASE_URL=https://api.example.com/api/v1/m/
```

Notes:

- Keep the trailing `/` if your backend expects a base path like the example.

### Run Modes

- Debug (default): `flutter run`
- Profile: `flutter run --profile`
- Release (physical device recommended):

```bash
flutter run --release --dart-define=BASE_URL=https://api.example.com/api/v1/m/
```

## Quality Checks

Analyze & lint:

```bash
flutter analyze
```

Tests:

```bash
flutter test
```

## Assets, App Name, and Icons

This project uses:

- `flutter_launcher_icons` to generate launcher icons
- `launcher_name` to set the app display name

Re-run generators after changing `assets/icon/*` or related configuration in `pubspec.yaml`:

```bash
flutter pub run flutter_launcher_icons
flutter pub run launcher_name
```

## Production / Release

This section is for generating final builds for installation or store distribution.

### Android

#### Build APK (internal testing / direct distribution)

```bash
flutter build apk --release --dart-define=BASE_URL=https://api.example.com/api/v1/m/
```

Typical output: `build/app/outputs/flutter-apk/app-release.apk`.

#### Build App Bundle (Google Play)

```bash
flutter build appbundle --release --dart-define=BASE_URL=https://api.example.com/api/v1/m/
```

Typical output: `build/app/outputs/bundle/release/app-release.aab`.

#### Release Signing (REQUIRED for production)

Current Android config in `android/app/build.gradle.kts` uses debug signing for the `release` build type (so `flutter run --release` works).

For production releases, you should:

1) Create a keystore (example):

```bash
keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

2) Store the keystore file (e.g. `android/upload-keystore.jks`).

3) Create `android/key.properties` (do not commit) with:

```properties
storePassword=...
keyPassword=...
keyAlias=upload
storeFile=../upload-keystore.jks
```

4) Update `android/app/build.gradle.kts` to use a proper release signing config (follow standard Flutter/Android signing patterns).

### iOS (macOS)

iOS builds can only be produced on macOS.

```bash
flutter build ios --release --dart-define=BASE_URL=https://api.example.com/api/v1/m/
```

For distribution (TestFlight/App Store), complete signing and archive via Xcode.

## Troubleshooting

- `Because <pkg> requires SDK version ...`: Flutter/Dart version mismatch. Use the appropriate Flutter channel (see Prerequisites).
- `build_runner` generated file conflicts: re-run with `--delete-conflicting-outputs`.
- API not reachable on a device: ensure `BASE_URL` points to a host reachable from the device (not `localhost`).

## Security Notes

- Do not commit `android/key.properties` or any keystore files.
- Avoid hardcoding credentials in the repo; use CI/CD secrets or environment variables.
