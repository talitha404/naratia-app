## 📚 Naratia

**“Kenapa kamu selalu jadi penonton di cerita orang lain?”**

**“Bagaimana kalau kamu bukan cuma pembaca… tapi bagian dari cerita?”**

Di Naratia, karakter utama adalah kamu.

Setiap dialog terasa lebih dekat.
Setiap konflik terasa lebih nyata.

Karena cerita terbaik…
adalah cerita di mana kamu ada di dalamnya.

✨ Masuk ke ceritamu sendiri.


---

## 📑Deskripsi

Naratia adalah platform digital untuk menulis dan membaca cerita berbasis mobile yang bisa digunakan oleh OS Android dan iOs.

Yang membuat Naratia berbeda adalah fitur self insert, yaitu kemampuan untuk *menyesuaikan nama karakter utama* dalam cerita menjadi nama pembaca. Dengan begitu, cerita terasa lebih personal karena pembaca seolah menjadi bagian langsung dari alur yang dibaca.

---

## 🚀 Fitur yang Berhasil Dikembangkan

* 🔐 Autentikasi (Register & Login)
* 👤 Manajemen Profil Pengguna
* ✍️ CRUD Cerita (Create, Read, Update, Delete)
* 🩷 Like

---

## 🛠️ Teknologi yang Digunakan

* **Flutter** (Dart Framework)
* **Laravel** (PHP Framework)

---

## 📂 Struktur Project MVVM

```
lib/
├── models/
│   └── story.dart
│   └── chapter.dart
│
├── services/
│   └── api_service.dart
│
├── viewmodels/
│   ├── auth_viewmodel.dart
│   ├── bookmark_viewmodel.dart
│   ├── home_viewmodel.dart
│   ├── library_viewmodel.dart
│   ├── profile_viewmodel.dart
│   ├── reader_viewmodel.dart
│   ├── search_viewmodel.dart
│   └── write_story_viewmodel.dart
│
├── views/
│   ├── auth/
│   │   ├── login_screen.dart
│   │   ├── register_screen.dart
│   │   └── welcome_screen.dart
│   │
│   ├── baca/
│   │   └── baca_screen.dart
│   │
│   ├── detail/
│   │   └── detail_screen.dart
│   │
│   ├── home/
│   │   ├── home_content.dart
│   │   └── home_screen.dart
│   │
│   ├── library/
│   │   └── library_screen.dart
│   │
│   ├── notification/
│   │   └── notification_screen.dart
│   │
│   ├── profile/
│   │   ├── edit_profile_screen.dart
│   │   ├── help_screen.dart
│   │   ├── profile_screen.dart
│   │   ├── saved_stories_screen.dart
│   │   ├── settings_screen.dart
│   │   ├── social_media_screen.dart
│   │   └── storage_screen.dart
│   │
│   ├── search/
│   │   └── search_screen.dart
│   │
│   ├── splash/
│   │   └── splash_screen.dart
│   │
│   ├── story/
│   │   └── story_detail_screen.dart
│   │   └── read_screen.dart
│   │
│   └── write/
│       ├── create_story_screen.dart
│       ├── draft_list_screen.dart
│       ├── editor_screen.dart
│       ├── preview_screen.dart
│       ├── published_list_screen.dart
│       └── write_hub_screen.dart
│
└── main.dart
```

---

# ✅ Alur Lengkap Setup Frontend Naratia

## 🧩 1. Siapkan Backend

* Clone repository:

```bash
git clone https://github.com/talitha404/naratia-backend-app.git
cd naratia-backend-app
```

ikuti langkah langkah setup yang terterah di readme.md

---

## 📥 2. Clone Repository

```bash
git clone https://github.com/talitha404/naratia-app.git
cd naratia-app
```

---

## 📦 3. Install Dependency

```bash
flutter pub get
```

---

## 🚀 4. Nyalakan Emulator dan Jalankan 

```bash
flutter run
```

---

## 👥 Tim Pengembang
Aplikasi ini dikembangkan oleh kelompok mahasiswa dengan pembagian tugas sebagai berikut:

| Nama Lengkap | NPM | Fitur & Komponen yang Dibuat |
| :--- | :--- | :--- |
takaan | **An Nisa' Fatmawati** | 24082010053 | - Perpustakaan <br> - Pencarian <br> |
| **Helen Risky Dwi Wahyuni** | 24082010054 |  - Autentikasi <br> - Manajemen User <br> |
| **Talitha Nabila Candra** | 24082010061 | - Backend <br> - Tulis |
| **Rindi Antika Qumalasari** | 24082010064 | - Baca <br> - Splash <br> - Like |

---

## 📌 Catatan Pengembangan

* Frontend Flutter wajib terhubung dengan Backend  **Laravel**
* Meski telah memakai struktur MVVM, masih banyak yang perlu dirapikan untuk pengembangan selanjutnya.
* Pengembangan yang diharapakan terjadi di masa depan:
  - Fitur komentar dan bagikan
  - Fitur bookmark
  - Fitur pengikut
  - Fitur publish cerita 
  - Dan masih banyak lagi
