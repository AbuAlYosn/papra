@echo off
:: WaraqStation Windows Installation Script
:: محطة إدارة الوثائق العربية - سكريبت التثبيت لنظام ويندوز
:: 
:: This script will install WaraqStation on your Windows computer
:: يقوم هذا السكريبت بتثبيت WaraqStation على جهاز الكمبيوتر الخاص بك

setlocal EnableDelayedExpansion

echo.
echo ================================
echo    WaraqStation Installation
echo    محطة إدارة الوثائق العربية
echo ================================
echo.

:: Check if running as administrator
echo [INFO] Checking administrator privileges...
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] This script requires administrator privileges.
    echo [ERROR] Please right-click and select "Run as administrator"
    echo.
    echo [خطأ] يتطلب هذا السكريبت صلاحيات المدير
    echo [خطأ] يرجى النقر بالزر الأيمن واختيار "تشغيل كمسؤول"
    pause
    exit /b 1
)

echo [SUCCESS] Administrator privileges confirmed.
echo [نجح] تم تأكيد صلاحيات المدير.
echo.

:: Check if Docker is installed
echo [INFO] Checking Docker installation...
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Docker is not installed or not accessible.
    echo [ERROR] Please install Docker Desktop for Windows first.
    echo [ERROR] Download from: https://docs.docker.com/desktop/install/windows-install/
    echo.
    echo [خطأ] Docker غير مثبت أو غير متاح
    echo [خطأ] يرجى تثبيت Docker Desktop لنظام ويندوز أولاً
    echo [خطأ] تحميل من: https://docs.docker.com/desktop/install/windows-install/
    pause
    exit /b 1
)

echo [SUCCESS] Docker is installed.
echo [نجح] Docker مثبت.
echo.

:: Create WaraqStation directory
set "WARAQ_DIR=%USERPROFILE%\WaraqStation"
echo [INFO] Creating WaraqStation directory: %WARAQ_DIR%
if not exist "%WARAQ_DIR%" (
    mkdir "%WARAQ_DIR%"
    echo [SUCCESS] Directory created.
    echo [نجح] تم إنشاء المجلد.
) else (
    echo [INFO] Directory already exists.
    echo [معلومات] المجلد موجود بالفعل.
)

:: Create data directory for persistent storage
set "DATA_DIR=%WARAQ_DIR%\data"
if not exist "%DATA_DIR%" (
    mkdir "%DATA_DIR%"
    echo [INFO] Created data directory for document storage.
    echo [معلومات] تم إنشاء مجلد البيانات لتخزين الوثائق.
)

:: Stop existing WaraqStation container if running
echo [INFO] Stopping any existing WaraqStation containers...
docker stop waraqstation >nul 2>&1
docker rm waraqstation >nul 2>&1
echo [INFO] Cleanup completed.
echo [معلومات] تم تنظيف الحاويات السابقة.
echo.

:: Check if WaraqStation image exists locally
echo [INFO] Checking for WaraqStation Docker image...
docker image inspect waraqstation:latest >nul 2>&1
if %errorlevel% neq 0 (
    :: Check if Dockerfile.waraqstation exists in current directory
    if exist "docker\Dockerfile.waraqstation" (
        echo [INFO] Building WaraqStation from source...
        echo [معلومات] جاري بناء WaraqStation من المصدر...
        docker build -t waraqstation:latest -f docker/Dockerfile.waraqstation .
        if %errorlevel% neq 0 (
            echo [ERROR] Failed to build WaraqStation image.
            echo [خطأ] فشل في بناء صورة WaraqStation.
            pause
            exit /b 1
        )
    ) else (
        echo [INFO] WaraqStation image not found locally and no Dockerfile available.
        echo [INFO] Please ensure the WaraqStation image is available or build from source.
        echo.
        echo [معلومات] صورة WaraqStation غير موجودة محلياً ولا يوجد Dockerfile متاح
        echo [معلومات] يرجى التأكد من توفر صورة WaraqStation أو البناء من المصدر
        pause
        exit /b 1
    )
) else (
    echo [SUCCESS] WaraqStation image found.
    echo [نجح] تم العثور على صورة WaraqStation.
)

echo.
echo [INFO] Starting WaraqStation container...
echo [معلومات] جاري تشغيل حاوية WaraqStation...

:: Run WaraqStation container
docker run -d ^
    --name waraqstation ^
    --restart unless-stopped ^
    -p 1221:1221 ^
    -v "%DATA_DIR%:/app/app-data" ^
    waraqstation:latest

if %errorlevel% equ 0 (
    echo [SUCCESS] WaraqStation started successfully!
    echo [نجح] تم تشغيل WaraqStation بنجاح!
    echo.
    echo ================================
    echo    Installation Complete!
    echo    اكتمل التثبيت!
    echo ================================
    echo.
    echo Access WaraqStation at: http://localhost:1221
    echo الوصول إلى WaraqStation على: http://localhost:1221
    echo.
    echo Your documents will be stored in: %DATA_DIR%
    echo ستُحفظ وثائقك في: %DATA_DIR%
    echo.
    
    :: Create desktop shortcut
    set "SHORTCUT_PATH=%USERPROFILE%\Desktop\WaraqStation.url"
    echo [URL] > "%SHORTCUT_PATH%"
    echo URL=http://localhost:1221 >> "%SHORTCUT_PATH%"
    echo IconFile=shell32.dll >> "%SHORTCUT_PATH%"
    echo IconIndex=13 >> "%SHORTCUT_PATH%"
    echo [SUCCESS] Desktop shortcut created.
    echo [نجح] تم إنشاء اختصار على سطح المكتب.
    echo.
    
    :: Create management scripts
    echo [INFO] Creating management scripts...
    echo [معلومات] جاري إنشاء سكريبتات الإدارة...
    
    :: Start script
    echo @echo off > "%WARAQ_DIR%\start-waraqstation.bat"
    echo echo Starting WaraqStation... >> "%WARAQ_DIR%\start-waraqstation.bat"
    echo echo جاري تشغيل WaraqStation... >> "%WARAQ_DIR%\start-waraqstation.bat"
    echo docker start waraqstation >> "%WARAQ_DIR%\start-waraqstation.bat"
    echo if %%errorlevel%% equ 0 ( >> "%WARAQ_DIR%\start-waraqstation.bat"
    echo     echo WaraqStation started successfully! >> "%WARAQ_DIR%\start-waraqstation.bat"
    echo     echo تم تشغيل WaraqStation بنجاح! >> "%WARAQ_DIR%\start-waraqstation.bat"
    echo     echo Access at: http://localhost:1221 >> "%WARAQ_DIR%\start-waraqstation.bat"
    echo     echo الوصول على: http://localhost:1221 >> "%WARAQ_DIR%\start-waraqstation.bat"
    echo     start http://localhost:1221 >> "%WARAQ_DIR%\start-waraqstation.bat"
    echo ^) else ( >> "%WARAQ_DIR%\start-waraqstation.bat"
    echo     echo Failed to start WaraqStation. >> "%WARAQ_DIR%\start-waraqstation.bat"
    echo     echo فشل في تشغيل WaraqStation. >> "%WARAQ_DIR%\start-waraqstation.bat"
    echo ^) >> "%WARAQ_DIR%\start-waraqstation.bat"
    echo pause >> "%WARAQ_DIR%\start-waraqstation.bat"
    
    :: Stop script
    echo @echo off > "%WARAQ_DIR%\stop-waraqstation.bat"
    echo echo Stopping WaraqStation... >> "%WARAQ_DIR%\stop-waraqstation.bat"
    echo echo جاري إيقاف WaraqStation... >> "%WARAQ_DIR%\stop-waraqstation.bat"
    echo docker stop waraqstation >> "%WARAQ_DIR%\stop-waraqstation.bat"
    echo echo WaraqStation stopped. >> "%WARAQ_DIR%\stop-waraqstation.bat"
    echo echo تم إيقاف WaraqStation. >> "%WARAQ_DIR%\stop-waraqstation.bat"
    echo pause >> "%WARAQ_DIR%\stop-waraqstation.bat"
    
    :: Update script
    echo @echo off > "%WARAQ_DIR%\update-waraqstation.bat"
    echo echo Updating WaraqStation... >> "%WARAQ_DIR%\update-waraqstation.bat"
    echo echo جاري تحديث WaraqStation... >> "%WARAQ_DIR%\update-waraqstation.bat"
    echo docker stop waraqstation >> "%WARAQ_DIR%\update-waraqstation.bat"
    echo docker rm waraqstation >> "%WARAQ_DIR%\update-waraqstation.bat"
    echo docker pull waraqstation:latest >> "%WARAQ_DIR%\update-waraqstation.bat"
    echo docker run -d --name waraqstation --restart unless-stopped -p 1221:1221 -v "%DATA_DIR%:/app/app-data" waraqstation:latest >> "%WARAQ_DIR%\update-waraqstation.bat"
    echo echo WaraqStation updated and restarted. >> "%WARAQ_DIR%\update-waraqstation.bat"
    echo echo تم تحديث وإعادة تشغيل WaraqStation. >> "%WARAQ_DIR%\update-waraqstation.bat"
    echo pause >> "%WARAQ_DIR%\update-waraqstation.bat"
    
    echo [SUCCESS] Management scripts created in: %WARAQ_DIR%
    echo [نجح] تم إنشاء سكريبتات الإدارة في: %WARAQ_DIR%
    echo.
    echo Available scripts:
    echo السكريبتات المتاحة:
    echo - start-waraqstation.bat : Start WaraqStation / تشغيل WaraqStation
    echo - stop-waraqstation.bat  : Stop WaraqStation / إيقاف WaraqStation  
    echo - update-waraqstation.bat: Update WaraqStation / تحديث WaraqStation
    echo.
    
    :: Open browser after a short delay
    echo [INFO] Opening WaraqStation in your browser...
    echo [معلومات] جاري فتح WaraqStation في المتصفح...
    timeout /t 10 /nobreak >nul
    start http://localhost:1221
    
) else (
    echo [ERROR] Failed to start WaraqStation container.
    echo [خطأ] فشل في تشغيل حاوية WaraqStation.
    echo.
    echo Please check Docker logs for more information:
    echo يرجى فحص سجلات Docker للمزيد من المعلومات:
    echo docker logs waraqstation
)

echo.
echo Installation script completed.
echo اكتمل سكريبت التثبيت.
pause