## 🌟 Fitur Unggulan

### 1. 📝 Manajemen Absensi Siswa
- **Input Absensi Cepat**: Antarmuka mudah untuk input status kehadiran (Hadir, Sakit, Izin, Alpha).
- **Rekap Otomatis**: Sistem otomatis menghitung persentase kehadiran per bulan dan per semester.
- **Validasi Cerdas**: Mencegah input absensi di hari libur atau hari Minggu.
- **Indikator Warna**: Visualisasi status kehadiran yang jelas di dashboard rekap.

### 2. 📖 Jurnal Mengajar Guru
- **Catatan Harian**: Input materi ajar, jam pelajaran, dan kelas dengan mudah.
- **Dokumentasi Kegitan**: Upload foto kegiatan belajar mengajar langsung ke jurnal.
- **Riwayat Lengkap**: Guru bisa melihat dan mencetak riwayat mengajar mereka kapan saja.

### 3. 📊 Laporan & Cetak (Export)
Aplikasi menyediakan berbagai format laporan siap cetak (standar dinas):
- **Cetak Jurnal**: Format PDF rapi dengan tanda tangan Kepala Sekolah.
- **Cetak Absensi**:
  - Rekap Bulanan (PDF & Excel)
  - Rekap Semester (PDF & Excel)
- **Format Excel**: Download rekap absensi ke `.xlsx` untuk pengolahan lebih lanjut.

### 4. 👥 Manajemen Data Terpadu
- **Data Siswa**: Tambah, Edit, Hapus, dan **Import via Excel** (Mass Upload).
- **Data Guru & GTK**: Manajemen akun pengguna dengan Role (Admin, Guru, Kepsek).
- **Manajemen Kelas**: Pengelompokan siswa berdasarkan tahun ajaran.
- **Kalender Akademik**: Atur hari libur nasional dan cuti bersama.

### 5. ⚙️ Sistem & Keamanan
- **Role-Based Access**:
  - **Admin**: Akses penuh ke pengaturan sistem, user, dan semua data.
  - **Guru**: Khusus input jurnal dan lihat absensi kelas ajar.
  - **Kepsek**: Monitoring laporan dan statistik.
- **Auto Backup (Google Drive)**: Amankan database secara otomatis ke Cloud (Google Drive) dengan Service Account.
- **Auto Update (OTA)**: Sistem notifikasi dan update otomatis jika versi baru tersedia (via GitHub/Google Drive).
- **Security**: Password terenkripsi, proteksi CSRF, dan session management.

---

## 💻 Spesifikasi Teknis

- **Bahasa Pemrograman**: Python 3.11 (Flask Framework)
- **Database**: SQLite (Ringan, tanpa perlu install server database terpisah)
- **Frontend**: HTML5, Bootstrap 5, JavaScript (Responsif di HP/Tablet/Laptop)
- **Deployment**:
  - **Windows**: Single Portable EXE (Tanpa install).
  - **Linux**: Service Systemd (Gunicorn).
