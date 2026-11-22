# Bantu Cari - Mafaza Games

Game edukasi anak: hafalkan letak benda selama 3 detik, lalu cari benda dalam gelap
memakai senter. Melatih ingatan, fokus, dan kosakata. Bisa main 1, 2, atau 4 pemain.

## Cara upload ke GitHub (otomatis)
1. Ekstrak file ZIP ini ke sebuah folder (jangan dijalankan dari dalam ZIP).
2. Pasang Git untuk Windows: https://git-scm.com/download/win
   (disarankan juga GitHub CLI: https://cli.github.com agar semuanya otomatis).
3. Klik dua kali **UPLOAD-KE-GITHUB.bat**, isi username GitHub dan nama repository.
4. Setelah selesai, game bisa dibuka di `https://USERNAME.github.io/NAMA-REPO/`.

Menjalankan .bat yang sama lagi akan memperbarui game di GitHub.

## Isi folder
- `index.html` : game (versi untuk dibuka langsung di komputer)
- `index.template.html` : cetakan; .bat mengisi alamat situs untuk pratinjau WhatsApp
- `assets/` : logo Mafaza Games, ikon tab browser, gambar pratinjau WhatsApp
- `UPLOAD-KE-GITHUB.bat` : skrip upload otomatis

## Pratinjau WhatsApp
Judul, deskripsi, dan gambar pratinjau diatur lewat tag `og:` di `index.template.html`.
Jika pratinjau lama masih muncul, tambahkan `?v=2` di akhir tautan saat membagikannya.
