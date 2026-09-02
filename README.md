# pricing_card — Minggu Ketiga

Project Flutter untuk tugas **Minggu Ketiga (Kartu Harga Layanan IT)** di
mata kuliah Mobile Dev semester 3.

## Tujuan

Menampilkan dua kartu paket harga dengan layout yang berubah mengikuti
lebar viewport:

- **Portrait / layar sempit** → 1 kolom vertikal (mobile-first).
- **Landscape dengan ruang cukup (lebar >= 720 px)** → 2 kolom berdampingan.

Breakpoint landscape sengaja membutuhkan dua kondisi sekaligus: orientasi landscape
dan lebar minimal 720 logical px. Landscape yang terlalu sempit tetap memakai satu
kolom agar isi kartu tidak terjepit.

## Paket yang tersedia

| Paket | Harga | Highlight |
| --- | --- | --- |
| Paket Starter | Rp 1.500.000 / proyek | Landing page sederhana |
| Paket Profesional | Rp 5.000.000 / proyek | Aplikasi custom end-to-end (badge Rekomendasi) |

Badge Rekomendasi hanya muncul di paket Profesional. CTA di kartu profesional
memakai warna aksen yang sedikit lebih gelap agar visual hierarchy tetap
terbaca di kedua layout.

## Menjalankan

```bash
cd "D:\tugas kuliah\semester 3\mobile\minggu ketiga"
flutter pub get
flutter run -d emulator-5554
```

Emulator yang dipakai adalah `Pixel_8_API_36` dengan GPU mode host (lihat
`D:\tugas kuliah\semester 3\mobile\tugas_mobile\CONTEXT-DUMP.md` untuk
catatan workaround black screen).

## Perbaikan UI terbaru

- Kartu sekarang dikelompokkan dalam content width yang eksplisit agar selalu
  berada di tengah viewport, bukan mengikuti shrink-wrap `Column`.
- Saat isi kartu lebih pendek daripada viewport, content diberi `minHeight` dan
  di-center secara vertikal; saat lebih panjang, tetap dapat di-scroll normal.
- Overscroll Android memakai `ClampingScrollPhysics` dan `MaterialScrollBehavior`
  tanpa overscroll indicator, sehingga layar tidak melakukan efek stretch saat
  ditarik.
- Tombol `Pilih Paket` memakai `foregroundColor: Colors.white`, tinggi minimal
  48 px, dan feedback `SnackBar` sesuai paket.
- Kartu memiliki spacing konsisten, border halus, shadow ringan, serta palette
  text yang lebih jelas.


## Struktur kode

- `lib/main.dart` — entry point + model `PricingPackage`, widget
  `PricingCard`, dan `PricingPackageList` yang memegang layout responsif.
- `test/widget_test.dart` — widget test untuk render, layout responsif, dan
  interaksi CTA.