@echo off
chcp 65001 >nul
title Dim Design Studio — Auto Deploy

cls
echo.
echo ╔══════════════════════════════════════════════════════╗
echo ║        DIM DESIGN STUDIO — AUTO DEPLOY TOOL         ║
echo ║   Hotline: +84 0913 774 502                         ║
echo ╚══════════════════════════════════════════════════════╝
echo.
echo Script nay se tu dong:
echo   [+] Kiem tra Node.js va Git
echo   [+] Cai dat Vercel CLI
echo   [+] Tao file .env.local
echo   [+] Push code len GitHub
echo   [+] Deploy len Vercel
echo.
pause

:: ── Kiểm tra Node.js ─────────────────────────────────────────
echo.
echo [1/7] Kiem tra Node.js...
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Node.js chua duoc cai. Dang tai...
    echo Vui long tai Node.js tai: https://nodejs.org
    echo Chon "LTS" va cai dat, sau do chay lai script nay.
    pause
    start https://nodejs.org
    exit /b
)
for /f "tokens=*" %%i in ('node --version') do set NODE_VER=%%i
echo [OK] Node.js %NODE_VER%

:: ── Kiểm tra Git ─────────────────────────────────────────────
echo.
echo [2/7] Kiem tra Git...
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Git chua duoc cai. Dang mo trang tai...
    start https://git-scm.com/download/win
    echo Cai dat Git xong roi chay lai script nay.
    pause
    exit /b
)
echo [OK] Git da co san

:: ── Cài Vercel CLI ────────────────────────────────────────────
echo.
echo [3/7] Cai Vercel CLI...
vercel --version >nul 2>&1
if %errorlevel% neq 0 (
    npm install -g vercel
)
echo [OK] Vercel CLI ready

:: ── Cài dependencies ─────────────────────────────────────────
echo.
echo [4/7] Cai dat dependencies...
npm install --legacy-peer-deps
if %errorlevel% neq 0 (
    echo LOI: Khong the cai dependencies
    pause
    exit /b
)
echo [OK] Dependencies xong

:: ── Thu thập thông tin ────────────────────────────────────────
echo.
echo ══════════════════════════════════════════════════════
echo [5/7] Nhap thong tin dich vu
echo ══════════════════════════════════════════════════════

echo.
echo [DATABASE - Neon.tech - Mien phi]
echo  1. Mo trinh duyet → https://neon.tech
echo  2. Sign Up (dung Google cho nhanh)
echo  3. Create Project → dat ten: dim-design-studio
echo  4. Copy "Connection String"
echo.
set /p DATABASE_URL="  Dan DATABASE_URL vao day: "

echo.
echo [CLOUDINARY - Luu anh - Mien phi]
echo  1. Mo trinh duyet → https://cloudinary.com
echo  2. Sign Up (dung Google)
echo  3. Vao Dashboard, copy 3 gia tri sau:
echo.
set /p CLOUD_NAME="  Cloud Name: "
set /p CLOUD_KEY="  API Key: "
set /p CLOUD_SECRET="  API Secret: "

echo.
echo [GITHUB - Luu code]
echo  1. Mo trinh duyet → https://github.com
echo  2. Sign In hoac Sign Up
echo  3. Nhan '+' → 'New repository'
echo  4. Dat ten: dim-design-studio
echo  5. Nhan 'Create repository'
echo.
set /p GITHUB_USER="  GitHub username cua ban: "

:: ── Tạo NEXTAUTH_SECRET ───────────────────────────────────────
echo.
echo [6/7] Tao bien bao mat...
:: Generate a pseudo-random secret using PowerShell
for /f "tokens=*" %%i in ('powershell -Command "[System.Convert]::ToBase64String([System.Security.Cryptography.RandomNumberGenerator]::GetBytes(32))"') do set NEXTAUTH_SECRET=%%i
echo [OK] NEXTAUTH_SECRET da tao

:: ── Tạo .env.local ────────────────────────────────────────────
echo.
echo Tao file .env.local...

(
echo # Dim Design Studio — Tu dong tao boi setup.bat
echo DATABASE_URL=%DATABASE_URL%
echo.
echo NEXTAUTH_URL=https://dim-design-studio.vercel.app
echo NEXTAUTH_SECRET=%NEXTAUTH_SECRET%
echo.
echo NEXT_PUBLIC_CLOUDINARY_CLOUD_NAME=%CLOUD_NAME%
echo CLOUDINARY_API_KEY=%CLOUD_KEY%
echo CLOUDINARY_API_SECRET=%CLOUD_SECRET%
echo.
echo NEXT_PUBLIC_APP_URL=https://dim-design-studio.vercel.app
echo NEXT_PUBLIC_APP_NAME=Dim Design Studio
) > .env.local

echo [OK] File .env.local da tao

:: ── Push lên GitHub ───────────────────────────────────────────
echo.
echo [7/7] Push len GitHub va deploy...

git init 2>nul
git add .
git commit -m "feat: Dim Design Studio initial deploy"

git remote remove origin 2>nul
git remote add origin https://github.com/%GITHUB_USER%/dim-design-studio.git
git branch -M main
git push -u origin main

echo.
echo Deploy len Vercel (can dang nhap - trinh duyet se mo)...
echo.

vercel --prod --yes --name dim-design-studio ^
  --env DATABASE_URL="%DATABASE_URL%" ^
  --env NEXTAUTH_URL="https://dim-design-studio.vercel.app" ^
  --env NEXTAUTH_SECRET="%NEXTAUTH_SECRET%" ^
  --env NEXT_PUBLIC_CLOUDINARY_CLOUD_NAME="%CLOUD_NAME%" ^
  --env CLOUDINARY_API_KEY="%CLOUD_KEY%" ^
  --env CLOUDINARY_API_SECRET="%CLOUD_SECRET%" ^
  --env NEXT_PUBLIC_APP_URL="https://dim-design-studio.vercel.app" ^
  --env NEXT_PUBLIC_APP_NAME="Dim Design Studio" ^
  --build-env DATABASE_URL="%DATABASE_URL%"

:: ── Seed database ─────────────────────────────────────────────
echo.
echo Tao du lieu mau...
npx prisma db push
npm run db:seed

:: ── HOÀN TẤT ─────────────────────────────────────────────────
echo.
echo ╔══════════════════════════════════════════════════════╗
echo ║              DEPLOY THANH CONG!                      ║
echo ╠══════════════════════════════════════════════════════╣
echo ║                                                      ║
echo ║  Website:  https://dim-design-studio.vercel.app     ║
echo ║  Admin:    .../admin                                 ║
echo ║  Login:    admin@dimdesign.com                       ║
echo ║  Password: dimdesign2024!                            ║
echo ║                                                      ║
echo ║  Hotline:  +84 0913 774 502                         ║
echo ║  Email:    info.dimdesign@gmail.com                  ║
echo ║                                                      ║
echo ╚══════════════════════════════════════════════════════╝
echo.
echo HAY DOI MAT KHAU ADMIN SAU KHI DANG NHAP LAN DAU!
echo.
pause
