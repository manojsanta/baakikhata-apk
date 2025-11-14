@echo off
setlocal enabledelayedexpansion

echo ========================================
echo Simple APK Builder
echo ========================================
echo.

REM Check Java
java -version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Java not found!
    echo Please install Java JDK and add to PATH
    pause
    exit /b 1
)

REM Check Android SDK
if not defined ANDROID_SDK_ROOT (
    echo ERROR: ANDROID_SDK_ROOT not set!
    echo Please set Android SDK environment variable
    pause
    exit /b 1
)

echo Java: OK
echo Android SDK: OK
echo.

REM Stop any running Gradle daemons
echo Stopping Gradle daemons...
call gradlew.bat --stop >nul 2>&1

echo.
echo Starting build...
echo This will take 5-10 minutes on first run.
echo Please wait and DO NOT close this window.
echo.

REM Build with timeout handling
timeout /t 2 /nobreak >nul

call gradlew.bat assembleRelease --no-daemon --console=plain

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo BUILD SUCCESSFUL!
    echo ========================================
    echo.
    if exist "app\build\outputs\apk\release\app-release.apk" (
        echo APK Location: app\build\outputs\apk\release\app-release.apk
        echo.
        for %%F in ("app\build\outputs\apk\release\app-release.apk") do (
            echo File Size: %%~zF bytes
            echo Created: %%~tF
        )
        echo.
        echo Opening folder...
        start explorer "app\build\outputs\apk\release"
    ) else (
        echo ERROR: APK file not found!
        echo Build completed but APK is missing.
    )
) else (
    echo.
    echo ========================================
    echo BUILD FAILED!
    echo ========================================
    echo.
    echo Check the error messages above.
    echo.
    echo Common fixes:
    echo 1. Make sure internet is connected
    echo 2. Check Java is installed: java -version
    echo 3. Verify Android SDK path in local.properties
    echo 4. Try: gradlew.bat --stop (then rebuild)
)

echo.
pause

