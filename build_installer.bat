@echo off
:: SnapVideo Installer Build Script
:: Script tạo file installer (setup.exe) bằng Inno Setup

title SnapVideo - Build Installer

color 0B
echo.
echo ========================================
echo   SnapVideo - Installer Builder
echo ========================================
echo.

:: Kiểm tra file SnapVideo.exe
if not exist "SnapVideo.exe" (
    echo [ERROR] Khong tim thay file SnapVideo.exe!
    echo.
    echo Vui long chay "build_exe.bat" truoc de tao file .exe
    echo.
    pause
    exit /b 1
)

echo [OK] Tim thay file SnapVideo.exe
echo.

:: Kiểm tra Inno Setup
echo Kiem tra Inno Setup...

set INNO_PATH=""
set INNO_PATH_64="C:\Program Files (x86)\Inno Setup 6\ISCC.exe"
set INNO_PATH_32="C:\Program Files\Inno Setup 6\ISCC.exe"

if exist %INNO_PATH_64% (
    set INNO_PATH=%INNO_PATH_64%
    echo [OK] Tim thay Inno Setup (64-bit)
) else if exist %INNO_PATH_32% (
    set INNO_PATH=%INNO_PATH_32%
    echo [OK] Tim thay Inno Setup (32-bit)
) else (
    echo [ERROR] Khong tim thay Inno Setup!
    echo.
    echo Inno Setup la cong cu tao installer mien phi.
    echo.
    echo Vui long:
    echo 1. Tai Inno Setup tu: https://jrsoftware.org/isdl.php
    echo 2. Cai dat Inno Setup
    echo 3. Chay lai script nay
    echo.
    echo Hoac ban co the su dung truc tiep file SnapVideo.exe
    echo ma khong can tao installer!
    echo.
    pause
    exit /b 1
)

echo.

:: Tạo thư mục output
if not exist "output" mkdir output
echo Tao thu muc output...
echo.

:: Build installer
echo Dang build installer...
echo Qua trinh nay co the mat 1-2 phut...
echo.

%INNO_PATH% installer.iss

if %errorlevel% equ 0 (
    echo.
    echo ========================================
    echo   BUILD INSTALLER THANH CONG!
    echo ========================================
    echo.
    echo File installer: output\SnapVideo_Setup_v1.0.0.exe
    echo.
    echo Ban co the:
    echo 1. Chay file setup de cai dat SnapVideo
    echo 2. Chia se file setup nay cho nguoi khac
    echo 3. Nguoi dung chi can chay setup, khong can Python!
    echo.
    echo Kich thuoc:
    dir "output\SnapVideo_Setup_v*.exe" | findstr "SnapVideo_Setup"
    echo.
) else (
    echo.
    echo [ERROR] Build installer that bai!
    echo Vui long kiem tra log loi o tren.
    echo.
)

pause

