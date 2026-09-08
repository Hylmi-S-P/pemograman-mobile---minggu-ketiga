# Tugas #4 Mobile Developer — Navigasi Antar Screen & Interaktivitas State

Repositori ini berisi implementasi aplikasi Flutter untuk **Tugas #4 Mobile Developer** yang mendemonstrasikan teknik **Stack Navigation (`Navigator.push` dan `Navigator.pop`)** serta manajemen **State Interaktif (`StatefulWidget` & `setState`)**.

---

## 📋 Daftar Isi
- [Tentang Aplikasi](#-tentang-aplikasi)
- [Struktur & Fitur Sesuai Spesifikasi Tugas](#-struktur--fitur-sesuai-spesifikasi-tugas)
- [Panduan Setup & Menjalankan Project (Mulai dari Clone)](#-panduan-setup--menjalankan-project-mulai-dari-clone)
- [Panduan Menjalankan Server Lokal](#-panduan-menjalankan-server-lokal)
- [Panduan Import Database MySQL](#-panduan-import-database-mysql)
- [Pengujian (Widget Testing)](#-pengujian-widget-testing)

---

## 📱 Tentang Aplikasi

Aplikasi menampilkan katalog paket layanan IT dengan alur navigasi dari daftar paket ke halaman rincian:
1. **Screen 1 (Beranda / Katalog):** Menampilkan daftar 3 kartu paket layanan IT.
2. **Screen 2 (Detail Katalog):** Menampilkan detail paket dengan tata letak vertikal, deskripsi berlatar warna pastel, serta interaksi state dinamis.

---

## 🎯 Struktur & Fitur Sesuai Spesifikasi Tugas

| Komponen | Spesifikasi Tugas | Implementasi di Kode |
| --- | --- | --- |
| **Screen 1 (Beranda)** | Wajib `StatelessWidget` | `CatalogHomeScreen` berupa `StatelessWidget`. |
| **Daftar Item** | Menampilkan 3 kartu via `ListView` & `ListTile` | Menggunakan `ListView.separated` berisi 3 paket (Starter, Profesional, Enterprise) dengan komponen `ListTile` dan tombol CTA. |
| **Navigasi** | Stack Navigation (`Navigator.push`) | Berpindah ke Screen 2 menggunakan `Navigator.push(context, MaterialPageRoute(...))`. |
| **Screen 2 (Detail)** | Wajib `StatefulWidget` & Layout `Column` | `DetailCatalogScreen` berupa `StatefulWidget` dengan tata letak vertikal `Column`. |
| **Elemen Visual Screen 2** | Icon Back, Text Info, Container Pastel | Memiliki tombol kembali di `AppBar` (`Navigator.pop`), teks harga & nama paket, serta `Container` warna pastel dengan padding untuk deskripsi paket. |
| **Interaktivitas State** | Perubahan state interaktif (`setState`) | Toggle favorit/bookmark, counter kuantitas kebutuhan proyek (kalkulasi harga otomatis), dan tombol konfirmasi pemilihan paket. |

---

## 🚀 Panduan Setup & Menjalankan Project (Mulai dari Clone)

Ikuti langkah-langkah di bawah ini jika Anda baru saja mengkloning repositori ini ke komputer Anda:

### 1. Prasyarat Sistem
Pastikan perangkat Anda telah terpasang:
- **Git:** [Download Git](https://git-scm.com/)
- **Flutter SDK:** Versi 3.12 atau lebih baru ([Panduan Instalasi Flutter](https://docs.flutter.dev/get-started/install))
- **Editor:** Visual Studio Code atau Android Studio (disertai ekstensi Flutter & Dart)
- **Target Device:** Google Chrome / Brave Browser, Android Emulator, atau perangkat fisik Android

Periksa kesiapan environment dengan perintah:
```bash
flutter doctor
```
*(Pastikan Flutter dan Chrome/Android toolchain berstatus centang hijau).*

---

### 2. Kloning Repositori
Buka terminal / Command Prompt / Git Bash, lalu jalankan perintah:
```bash
git clone https://github.com/Hylmi-S-P/pemograman-mobile---minggu-ketiga.git
```

Masuk ke direktori proyek yang baru di-clone:
```bash
cd pemograman-mobile---minggu-ketiga
```

---

### 3. Mengunduh Dependensi Proyek
Jalankan perintah berikut untuk mengunduh semua paket dependensi yang dibutuhkan:
```bash
flutter pub get
```

---

### 4. Menjalankan Aplikasi

#### A. Menjalankan di Web Browser (Chrome / Brave):
```bash
flutter run -d chrome
```

#### B. Menjalankan di Android Emulator / Perangkat Fisik:
1. Pastikan emulator aktif atau perangkat terhubung via USB Debugging.
2. Cek perangkat yang terdeteksi:
   ```bash
   flutter devices
   ```
3. Jalankan aplikasi:
   ```bash
   flutter run
   ```

---

## 🖥️ Panduan Menjalankan Server Lokal

Apabila aplikasi dihubungkan dengan layanan API / backend lokal, ikuti langkah berikut untuk mengaktifkan server lokal:

### 1. Menggunakan Stack Web Server (XAMPP / Laragon)
1. Buka control panel **XAMPP** atau **Laragon**.
2. Klik tombol **Start** pada modul:
   - **Apache** (Web Server lokal, default port: `80` atau `8080`).
   - **MySQL** (Database Server, default port: `3306`).
3. Uji apakah server telah berjalan dengan membuka browser ke:
   ```text
   http://localhost/
   ```

### 2. Menjalankan REST API Server (Jika Menggunakan File PHP / Node.js)
- **PHP Built-in Server (opsional):**
  Jika endpoint API berada di dalam folder backend/api:
  ```bash
  cd path/to/api
  php -S localhost:8000
  ```
- **Node.js / Express (opsional):**
  ```bash
  cd path/to/server
  npm install
  npm start
  ```

---

## 🗄️ Panduan Import Database MySQL

Berikut adalah langkah-langkah menyiapkan basis data MySQL untuk kebutuhan data backend:

1. **Buka phpMyAdmin:**
   Buka peramban (browser) dan akses alamat:
   ```text
   http://localhost/phpmyadmin
   ```

2. **Buat Database Baru:**
   - Pilih menu **Databases** (Basis Data) pada panel navigasi atas.
   - Di kolom **Database name** (Nama basis data), masukkan nama database, misalnya:
     ```text
     db_katalog_layanan
     ```
   - Pilih collation `utf8mb4_general_ci`, kemudian klik tombol **Create** (Buat).

3. **Lakukan Import File SQL:**
   - Klik nama database yang baru dibuat (`db_katalog_layanan`) pada daftar sebelah kiri.
   - Klik tab menu **Import** di bagian atas.
   - Pada bagian **File to import**, klik tombol **Choose File** (Pilih Berkas).
   - Cari dan pilih berkas dump SQL Anda (misal: `database.sql` atau file `.sql` terkait).
   - Biarkan opsi lainnya pada nilai default, lalu gulir ke bawah dan klik tombol **Import** (Kirim).

4. **Verifikasi:**
   - Tunggu beberapa saat hingga muncul pesan konfirmasi berwarna hijau:
     > *"Import has been successfully finished, XX queries executed."*
   - Periksa tabel-tabel yang terbentuk di panel sebelah kiri untuk memastikan struktur tabel dan data berhasil diimpor.

---

## 🧪 Pengujian (Widget Testing)

Proyek ini telah dilengkapi dengan pengujian unit dan widget otomatis untuk memvalidasi:
- Render Screen 1 dengan 3 kartu katalog.
- Alur Stack Navigation (`push` ke Screen 2 dan `pop` kembali ke Screen 1).
- Perubahan state interaktif pada Screen 2 (Bookmark, kuantitas order, dan tombol konfirmasi).

Jalankan pengujian menggunakan:
```bash
flutter test
```

---

## 📁 Struktur Berkas Utama

```text
├── lib/
│   └── main.dart            # Entry point, model data, Screen 1 (Stateless), & Screen 2 (Stateful)
├── test/
│   └── widget_test.dart     # Unit & widget tests pengujian alur navigasi & state
├── pubspec.yaml             # Konfigurasi dependensi dan metadata proyek
└── README.md                # Dokumentasi proyek
```
