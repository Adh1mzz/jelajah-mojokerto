# Jelajah Mojokerto - Adhim

Aplikasi katalog destinasi wisata Kabupaten dan Kota Mojokerto berbasis **Flutter (Dart)** dan **Riverpod** (UTS Pemrograman Mobile - IN-45331).

## Identitas Mahasiswa & Personalisasi
- **Nama Lengkap**: Ahmad Fauzul Adhim
- **Nama Panggilan (AppBar)**: Adhim (`Jelajah Mojokerto - Adhim`)
- **NIM**: 52404110003
- **Digit Terakhir NIM**: `3`
- **Seed Color (`ColorScheme.fromSeed`)**: `Colors.indigo`
- **Font (`google_fonts`)**: `Nunito`

## Struktur Folder
```text
lib/
├── main.dart
├── models/
│   ├── kategori_wisata.dart
│   ├── destinasi.dart
│   └── rupiah_extension.dart
├── data/
│   └── destinasi_data.dart
├── providers/
│   └── wisata_providers.dart
├── theme/
│   └── app_theme.dart
├── screens/
│   ├── main_screen.dart
│   ├── beranda_tab.dart
│   ├── jelajah_tab.dart
│   ├── favorit_tab.dart
│   └── detail_screen.dart
└── widgets/
    ├── destinasi_card.dart
    └── network_image_with_fallback.dart
```

## Cara Menjalankan Project
1. Buat project Flutter kosong atau salin isi folder `lib/`, `pubspec.yaml`, dan `README.md` ke direktori project Flutter Anda (`flutter create jelajah_mojokerto`).
2. Jalankan perintah berikut di terminal:
   ```bash
   flutter pub get
   flutter run
   ```
