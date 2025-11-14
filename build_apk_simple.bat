@echo off
echo Building APK... This may take 5-10 minutes on first run.
echo.
echo Starting build process...
echo.

gradlew.bat clean assembleRelease > build_log.txt 2>&1

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo BUILD SUCCESSFUL!
    echo ========================================
    echo.
    if exist "app\build\outputs\apk\release\app-release.apk" (
        echo APK generated successfully!
        echo Location: app\build\outputs\apk\release\app-release.apk
        echo.
        explorer "app\build\outputs\apk\release"
    ) else (
        echo Warning: Build completed but APK not found.
        echo Check build_log.txt for details.
    )
) else (
    echo.
    echo ========================================
    echo BUILD FAILED!
    echo ========================================
    echo.
    echo Check build_log.txt for error details.
    type build_log.txt | findstr /i "error fail"
)

echo.
pause

