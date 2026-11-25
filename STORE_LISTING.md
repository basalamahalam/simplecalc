# Play Store Listing Copy for SimpleCalc

Reference copy for the Play Console "Store listing" page, kept in the repo so it's versioned alongside the app.

## Short description (≤ 80 characters)

```
Kalkulator sederhana, cepat, tanpa iklan dan tanpa pengumpulan data.
```

## Full description

```
SimpleCalc adalah aplikasi kalkulator sederhana untuk kebutuhan hitung sehari-hari.

Fitur:
• Operasi dasar: tambah, kurang, kali, bagi
• Mendukung urutan operasi matematika yang benar (perkalian dan pembagian didahulukan)
• Desimal, persen, hapus satu digit (backspace), dan hapus semua
• Tampilan bersih mengikuti Material Design, otomatis menyesuaikan mode terang/gelap

Privasi:
SimpleCalc tidak memerlukan koneksi internet, tidak menampilkan iklan, tidak memerlukan akun, dan tidak mengumpulkan data apa pun dari perangkat Anda. Semua perhitungan dilakukan sepenuhnya di perangkat Anda.

Ringan, cepat, dan langsung bisa dipakai tanpa pengaturan tambahan.
```

## Visual assets

- App icon (512×512): `store_assets/icon_512.png` — generated from `assets/icon/icon.png` via `scripts/generate_store_assets.py`.
- Feature graphic (1024×500): `store_assets/feature_graphic.png` — same script.
- Phone screenshots (≥ 2 required): not generated here — capture from a running build (`flutter run`) on a device or emulator.

To regenerate the icon/feature graphic after changing the app icon artwork:

```bash
python3 scripts/generate_icon.py
python3 scripts/generate_store_assets.py
```
