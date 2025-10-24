@echo off
:: SnapVideo Installation Script
:: Script tự động cài đặt SnapVideo

title SnapVideo - Installation

color 0A
echo.
echo ========================================
echo   SnapVideo Installation Wizard
echo ========================================
echo.

:: Kiểm tra Python
echo [1/4] Kiem tra Python...
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Python chua duoc cai dat!
    echo.
    echo Vui long:
    echo 1. Tai Python tu: https://www.python.org/downloads/
    echo 2. Cai dat va nho tick "Add Python to PATH"
    echo 3. Chay lai file nay sau khi cai Python
    echo.
    pause
    exit /b 1
)

python --version
echo [OK] Python da san sang!
echo.

:: Cập nhật pip
echo [2/4] Cap nhat pip...
python -m pip install --upgrade pip >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] Pip da duoc cap nhat!
) else (
    echo [WARNING] Khong the cap nhat pip, tiep tuc...
)
echo.

:: Cài đặt thư viện
echo [3/4] Cai dat cac thu vien can thiet...
echo Vui long doi, qua trinh nay co the mat vai phut...
echo.

pip install -r requirements.txt

if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Cai dat that bai!
    echo.
    echo Thu cac buoc sau:
    echo 1. Kiem tra ket noi internet
    echo 2. Chay Command Prompt voi quyen Administrator
    echo 3. Thu chay: python -m pip install -r requirements.txt
    echo.
    pause
    exit /b 1
)

echo.
echo [OK] Cai dat thu vien thanh cong!
echo.

:: Kiểm tra FFmpeg
echo [4/4] Kiem tra FFmpeg...
ffmpeg -version >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] FFmpeg da duoc cai dat!
    echo Ban co the tai video chat luong cao!
) else (
    echo [WARNING] FFmpeg chua duoc cai dat!
    echo.
    echo De tai video chat luong cao va chuyen doi MP3:
    echo - Chay Command Prompt voi quyen Administrator
    echo - Goi lenh: winget install ffmpeg
    echo.
    echo Hoac doc huong dan trong file HUONG_DAN_CAI_DAT.txt
    echo.
    echo SnapVideo van hoat dong binh thuong nhung co the
    echo khong tai duoc mot so dinh dang video chat luong cao.
)

echo.
echo ========================================
echo   CAI DAT HOAN TAT!
echo ========================================
echo.
echo SnapVideo da san sang su dung!
echo.
echo Cach su dung:
echo - Double-click file "run_snapvideo.bat"
echo - Hoac chay lenh: python snapvideo.py
echo.
echo Doc them huong dan chi tiet trong:
echo - README.md (Tieng Anh)
echo - HUONG_DAN_CAI_DAT.txt (Tieng Viet)
echo.
echo Chuc ban su dung vui ve! ^_^
echo.
pause

