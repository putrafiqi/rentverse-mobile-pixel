# Pixel Rentverse

Aplikasi Flutter untuk Pixel Rentverse.

Dokumentasi ini menjelaskan cara menjalankan aplikasi untuk **development** dan cara menyiapkan build untuk **production/release**.

## Prasyarat

- Flutter SDK terpasang.
  - Catatan: di `pubspec.yaml` project ini menggunakan Dart SDK `^3.10.0-290.4.beta`, jadi Anda kemungkinan perlu Flutter channel **beta** (atau channel lain yang menyertakan Dart 3.10).
- Android Studio + Android SDK (untuk Android).
- Xcode (khusus macOS, untuk iOS).

Periksa versi:

```bash
flutter --version
dart --version
```

Jika perlu pindah ke channel beta:

```bash
flutter channel beta
flutter upgrade
```

## Struktur Singkat

- `lib/main.dart`: entrypoint aplikasi (membaca konfigurasi `BASE_URL`).
- `lib/app/`: konfigurasi app, routes, bloc, view.
- `lib/data/`: repository dan service (API via Dio).
- `lib/core/`: theme, interceptor, types, validation.
- `assets/`: aset gambar dan icon.

## Setup Development

1) Install dependency:

```bash
flutter pub get
```

2) Jalankan code generation (jika ada model `json_serializable`):

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

3) Jalankan aplikasi:

```bash
flutter run
```

### Konfigurasi Environment (BASE_URL)

Aplikasi membaca base URL API dari compile-time env `BASE_URL`.

- Default (jika tidak diset):
  - `http://localhost:3000/api/v1/m/`
- Untuk override saat run:

```bash
flutter run --dart-define=BASE_URL=https://api.example.com/api/v1/m/
```

Catatan:

- Pastikan URL berakhiran `/` jika backend Anda mengharapkan path base seperti di contoh.

### Mode Run

- Debug (default): `flutter run`
- Profile: `flutter run --profile`
- Release (device fisik disarankan):

```bash
flutter run --release --dart-define=BASE_URL=https://api.example.com/api/v1/m/
```

## Quality Checks

Lint & analisis:

```bash
flutter analyze
```

Test:

```bash
flutter test
```

## Assets, Nama App, dan Icon

Project ini menggunakan:

- `flutter_launcher_icons` untuk generate icon launcher
- `launcher_name` untuk set nama aplikasi

Jalankan ulang generator jika Anda mengubah `assets/icon/*` atau konfigurasi di `pubspec.yaml`:

```bash
flutter pub run flutter_launcher_icons
flutter pub run launcher_name
```

## Production / Release

Bagian ini untuk menghasilkan build final yang siap di-install atau di-upload ke store.

### Android

#### Build APK (uji internal / distribusi langsung)

```bash
flutter build apk --release --dart-define=BASE_URL=https://api.example.com/api/v1/m/
```

Output umumnya ada di `build/app/outputs/flutter-apk/app-release.apk`.

#### Build App Bundle (Play Store)

```bash
flutter build appbundle --release --dart-define=BASE_URL=https://api.example.com/api/v1/m/
```

Output umumnya ada di `build/app/outputs/bundle/release/app-release.aab`.

#### Signing Release (WAJIB untuk production)

Saat ini konfigurasi Android di `android/app/build.gradle.kts` masih menggunakan debug signing untuk build `release` (agar `flutter run --release` bisa jalan).

Untuk rilis production, Anda perlu:

1) Buat keystore (contoh):

```bash
keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

2) Simpan file keystore (mis. `android/upload-keystore.jks`).

3) Buat file `android/key.properties` (jangan di-commit) berisi:

```properties
storePassword=... 
keyPassword=...
keyAlias=upload
storeFile=../upload-keystore.jks
```

4) Update `android/app/build.gradle.kts` untuk memakai signing config release (ikuti pola signing standard Flutter/Android).

Catatan: langkah detail bisa berbeda tergantung kebijakan tim; yang penting build release tidak menggunakan debug key.

### iOS (macOS)

Build iOS hanya bisa dilakukan di macOS.

```bash
flutter build ios --release --dart-define=BASE_URL=https://api.example.com/api/v1/m/
```

Untuk distribusi (TestFlight/App Store), lanjutkan signing & archive via Xcode.

## Troubleshooting

- `Because <pkg> requires SDK version ...`: versi Flutter/Dart tidak cocok. Gunakan Flutter channel yang sesuai (lihat bagian Prasyarat).
- `build_runner` konflik file generated: jalankan lagi dengan `--delete-conflicting-outputs`.
- API tidak terhubung di device: pastikan `BASE_URL` menunjuk host yang bisa diakses device (bukan `localhost`).

## Catatan Keamanan

- Jangan commit `android/key.properties` atau file keystore.
- Jangan hardcode credential di repo; gunakan secret manager/CI variables untuk build pipeline.
