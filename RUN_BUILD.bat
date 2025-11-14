@echo off
echo ========================================
echo Building Baaki Khata Launcher APK
echo ========================================
echo.
echo This will take 5-10 minutes on first run.
echo Please DO NOT close this window.
echo.
echo The build will:
echo 1. Download Gradle (if needed)
echo 2. Download Android dependencies
echo 3. Compile the app
echo 4. Generate the APK
echo.
echo Starting now...
echo.

cd /d "%~dp0"

call gradlew.bat clean assembleRelease --no-daemon --stacktrace

echo.
echo ========================================
if exist "app\build\outputs\apk\release\app-release.apk" (
    echo BUILD SUCCESSFUL!
    echo ========================================
    echo.
    echo APK Location:
    echo app\build\outputs\apk\release\app-release.apk
    echo.
    for %%F in ("app\build\outputs\apk\release\app-release.apk") do (
        echo File Size: %%~zF bytes
        echo Created: %%~tF
    )
    echo.
    echo Opening folder...
    start explorer "app\build\outputs\apk\release"
) else (
    echo BUILD FAILED OR NOT COMPLETE
    echo ========================================
    echo.
    echo Please check for error messages above.
    echo.
    echo Common issues:
    echo - Internet connection needed for downloads
    echo - Java JDK must be installed
    echo - Android SDK path must be correct in local.properties
    echo.
)
echo.
pause

