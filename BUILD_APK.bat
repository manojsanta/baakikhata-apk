@echo off
echo ========================================
echo Building Baaki Khata Launcher APK
echo ========================================
echo.

REM Check if gradle is available
where gradle >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Gradle is not installed or not in PATH
    echo.
    echo Please install Gradle:
    echo 1. Download from https://gradle.org/releases/
    echo 2. Extract and add to PATH
    echo OR
    echo Use Android Studio to build the APK
    echo.
    pause
    exit /b 1
)

echo Gradle found. Starting build...
echo.

REM Clean previous builds
echo Cleaning previous builds...
call gradle clean

REM Build release APK
echo.
echo Building release APK...
call gradle assembleRelease

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo BUILD SUCCESSFUL!
    echo ========================================
    echo.
    echo APK location: app\build\outputs\apk\release\app-release.apk
    echo.
    echo You can now share this APK file.
    echo.
) else (
    echo.
    echo ========================================
    echo BUILD FAILED!
    echo ========================================
    echo.
    echo Please check the error messages above.
    echo.
)

pause

