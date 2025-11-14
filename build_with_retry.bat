@echo off
setlocal enabledelayedexpansion

echo ========================================
echo APK Builder with Auto-Retry
echo ========================================
echo.

set MAX_RETRIES=3
set RETRY_COUNT=0
set BUILD_SUCCESS=0

:retry_build
set /a RETRY_COUNT+=1
echo.
echo Attempt %RETRY_COUNT% of %MAX_RETRIES%
echo.

REM Stop daemons before each attempt
call gradlew.bat --stop >nul 2>&1
timeout /t 2 /nobreak >nul

REM Try to build
call gradlew.bat clean assembleRelease --no-daemon --console=plain

if %ERRORLEVEL% EQU 0 (
    if exist "app\build\outputs\apk\release\app-release.apk" (
        set BUILD_SUCCESS=1
        goto build_success
    ) else (
        echo Build completed but APK not found. Retrying...
    )
) else (
    echo Build failed. Error code: %ERRORLEVEL%
    if %RETRY_COUNT% LSS %MAX_RETRIES% (
        echo Waiting 5 seconds before retry...
        timeout /t 5 /nobreak >nul
        goto retry_build
    )
)

if %BUILD_SUCCESS% EQU 0 (
    echo.
    echo ========================================
    echo BUILD FAILED AFTER %MAX_RETRIES% ATTEMPTS
    echo ========================================
    echo.
    echo Please try:
    echo 1. Check internet connection
    echo 2. Verify Java: java -version
    echo 3. Verify Android SDK: echo %%ANDROID_SDK_ROOT%%
    echo 4. Check local.properties file exists
    echo 5. Try: gradlew.bat --stop
    echo.
    pause
    exit /b 1
)

:build_success
echo.
echo ========================================
echo BUILD SUCCESSFUL!
echo ========================================
echo.
echo APK Location: app\build\outputs\apk\release\app-release.apk
echo.
for %%F in ("app\build\outputs\apk\release\app-release.apk") do (
    echo File Size: %%~zF bytes
    echo Created: %%~tF
)
echo.
echo Opening folder...
start explorer "app\build\outputs\apk\release"
echo.
pause

