@echo off
:: SnapVideo Launcher
:: File batch để chạy SnapVideo trên Windows

title SnapVideo - Video Downloader

echo.
echo ========================================
echo      SnapVideo - Video Downloader
echo ========================================
echo.

:: Kiểm tra Python có được cài đặt không
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Python chua duoc cai dat!
    echo.
    echo Vui long cai dat Python tu: https://www.python.org/downloads/
    echo Nho tick chon "Add Python to PATH" khi cai dat!
    echo.
    pause
    exit /b 1
)

echo [OK] Python da duoc cai dat
echo.

:: Kiểm tra và cài đặt thư viện nếu cần
echo Dang kiem tra thu vien...
python -c "import yt_dlp" >nul 2>&1
if %errorlevel% neq 0 (
    echo [INFO] Dang cai dat cac thu vien can thiet...
    echo Vui long doi...
    echo.
    pip install -r requirements.txt
    if %errorlevel% neq 0 (
        echo.
        echo [ERROR] Khong the cai dat thu vien!
        echo Vui long chay lenh: pip install -r requirements.txt
        echo.
        pause
        exit /b 1
    )
    echo.
    echo [OK] Cai dat thu vien thanh cong!
    echo.
)

:: Chạy SnapVideo
echo Dang khoi dong SnapVideo...
echo.
python snapvideo.py

:: Nếu có lỗi
if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Co loi xay ra khi chay ung dung!
    echo.
    pause
)

exit /b 0

