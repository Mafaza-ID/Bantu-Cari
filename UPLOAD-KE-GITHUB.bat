@echo off
setlocal EnableExtensions
chcp 65001 >nul
title Upload Bantu Cari ke GitHub - Mafaza Games
cd /d "%~dp0"
cls
echo ============================================================
echo    BANTU CARI - Mafaza Games
echo    Upload otomatis ke GitHub + GitHub Pages
echo ============================================================
echo.

where git >nul 2>nul
if errorlevel 1 goto NOGIT

set "GH_USER="
set "GH_REPO="
set /p GH_USER=Masukkan USERNAME GitHub Anda: 
if "%GH_USER%"=="" goto NOUSER
set /p GH_REPO=Nama repository [Enter = bantu-cari]: 
if "%GH_REPO%"=="" set "GH_REPO=bantu-cari"

set "SITE=https://%GH_USER%.github.io/%GH_REPO%"
if /i "%GH_REPO%"=="%GH_USER%.github.io" set "SITE=https://%GH_USER%.github.io"

echo.
echo [1/5] Membuat index.html dengan alamat %SITE%
powershell -NoProfile -ExecutionPolicy Bypass -Command "$d=(Get-Location).Path; $t=[IO.File]::ReadAllText((Join-Path $d 'index.template.html'),[Text.Encoding]::UTF8); $t=$t.Replace('__SITE_URL__','%SITE%'); [IO.File]::WriteAllText((Join-Path $d 'index.html'),$t,(New-Object Text.UTF8Encoding($false)))"
if errorlevel 1 goto FAIL

echo [2/5] Menyiapkan Git dan commit...
if not exist ".git" git init >nul
git symbolic-ref HEAD refs/heads/main
set "GN="
set "GE="
for /f "delims=" %%i in ('git config user.name 2^>nul') do set "GN=%%i"
for /f "delims=" %%i in ('git config user.email 2^>nul') do set "GE=%%i"
if "%GN%"=="" git config user.name "%GH_USER%"
if "%GE%"=="" git config user.email "%GH_USER%@users.noreply.github.com"
git add -A
git commit -m "Upload Bantu Cari - Mafaza Games" >nul 2>nul
git branch -M main >nul 2>nul

where gh >nul 2>nul
if errorlevel 1 goto MANUAL
gh auth status >nul 2>nul
if errorlevel 1 echo Anda belum login. Jendela login GitHub akan terbuka, ikuti petunjuknya...
if errorlevel 1 gh auth login --web --git-protocol https
gh auth status >nul 2>nul
if errorlevel 1 goto MANUAL

echo [3/5] Membuat repository %GH_USER%/%GH_REPO% dan upload...
gh repo create "%GH_USER%/%GH_REPO%" --public --source=. --remote=origin --push
if errorlevel 1 goto EXISTS
goto PAGES

:EXISTS
echo Repository sudah ada. Menghubungkan dan mengirim pembaruan...
git remote remove origin >nul 2>nul
git remote add origin "https://github.com/%GH_USER%/%GH_REPO%.git"
git push -u origin main
if errorlevel 1 goto FAIL

:PAGES
echo [4/5] Mengaktifkan GitHub Pages...
gh api --method POST "repos/%GH_USER%/%GH_REPO%/pages" -f "source[branch]=main" -f "source[path]=/" >nul 2>nul
goto DONE

:MANUAL
echo.
echo GitHub CLI tidak ada atau belum login. Memakai cara manual:
echo.
echo   1. Halaman pembuatan repository akan dibuka di browser.
echo   2. Pastikan nama = %GH_REPO% dan pilih Public.
echo   3. JANGAN centang README atau .gitignore. Klik Create repository.
echo   4. Kembali ke jendela ini lalu tekan tombol apa saja.
echo.
start "" "https://github.com/new?name=%GH_REPO%&visibility=public"
pause
echo [3/5] Mengirim file ke GitHub. Jika diminta, login lewat jendela yang muncul...
git remote remove origin >nul 2>nul
git remote add origin "https://github.com/%GH_USER%/%GH_REPO%.git"
git push -u origin main
if errorlevel 1 goto FAIL
echo [4/5] Aktifkan Pages secara manual di halaman yang akan dibuka:
echo   Source = Deploy from a branch, Branch = main, folder = root, lalu Save.
start "" "https://github.com/%GH_USER%/%GH_REPO%/settings/pages"
pause
goto DONE

:DONE
echo.
echo [5/5] SELESAI!
echo ------------------------------------------------------------
echo  Alamat game : %SITE%/
echo ------------------------------------------------------------
echo  Tunggu 1-2 menit sampai GitHub Pages aktif, lalu buka alamat di atas.
echo  Bagikan alamat itu ke WhatsApp supaya tampil judul, stiker, dan deskripsi.
echo  Untuk memperbarui game: ubah file, lalu jalankan file .bat ini lagi.
echo.
start "" "%SITE%/"
pause
endlocal
exit /b 0

:NOGIT
echo Git belum terpasang di komputer ini.
echo Halaman unduhan akan dibuka. Pasang Git, lalu jalankan file ini lagi.
start "" "https://git-scm.com/download/win"
pause
exit /b 1

:NOUSER
echo Username tidak boleh kosong.
pause
exit /b 1

:FAIL
echo.
echo Terjadi kesalahan. Baca pesan di atas, perbaiki, lalu jalankan lagi.
pause
exit /b 1
