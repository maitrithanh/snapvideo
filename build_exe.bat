@echo off
:: SnapVideo Build Script
:: Script tự động build file .exe từ Python code

title SnapVideo - Build Executable

color 0B
echo.
echo ========================================
echo     SnapVideo - Build Tool
echo ========================================
echo.

:: Kiểm tra Python
echo [1/5] Kiem tra Python...
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Python chua duoc cai dat!
    echo Vui long cai dat Python truoc!
    pause
    exit /b 1
)
echo [OK] Python: 
python --version
echo.

:: Cài đặt PyInstaller nếu chưa có
echo [2/5] Kiem tra PyInstaller...
python -c "import PyInstaller" >nul 2>&1
if %errorlevel% neq 0 (
    echo [INFO] Dang cai dat PyInstaller...
    pip install pyinstaller
    if %errorlevel% neq 0 (
        echo [ERROR] Khong the cai dat PyInstaller!
        pause
        exit /b 1
    )
)
echo [OK] PyInstaller da san sang!
echo.

:: Cài đặt dependencies
echo [3/5] Cai dat dependencies...
pip install -r requirements.txt
if %errorlevel% neq 0 (
    echo [ERROR] Khong the cai dat dependencies!
    pause
    exit /b 1
)
echo [OK] Dependencies da duoc cai dat!
echo.

:: Xóa build cũ nếu có
echo [4/5] Lam sach build cu...
if exist "build" rmdir /s /q build
if exist "dist" rmdir /s /q dist
if exist "SnapVideo.exe" del /q SnapVideo.exe
echo [OK] Da lam sach!
echo.

:: Build executable
echo [5/5] Dang build file .exe...
echo Qua trinh nay co the mat 2-5 phut, vui long doi...
echo.

pyinstaller --clean snapvideo.spec

if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Build that bai!
    echo.
    echo Vui long kiem tra log loi o tren.
    pause
    exit /b 1
)

:: Di chuyển file exe ra ngoài
if exist "dist\SnapVideo.exe" (
    copy "dist\SnapVideo.exe" "SnapVideo.exe" >nul
    echo.
    echo ========================================
    echo   BUILD THANH CONG!
    echo ========================================
    echo.
    echo File thuc thi: SnapVideo.exe
    echo Kich thuoc: 
    dir "SnapVideo.exe" | findstr "SnapVideo.exe"
    echo.
    echo Ban co the:
    echo 1. Chay truc tiep file SnapVideo.exe
    echo 2. Chia se file nay cho nguoi khac (khong can Python!)
    echo 3. Tao installer voi Inno Setup (xem HUONG_DAN_BUILD.txt)
    echo.
    echo Luu y: File exe nay chi chay duoc tren Windows!
    echo.
) else (
    echo.
    echo [ERROR] Khong tim thay file SnapVideo.exe!
    echo Vui long kiem tra thu muc dist\
    echo.
)

pause

