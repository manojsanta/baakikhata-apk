@echo off
echo ========================================
echo Building Baaki Khata Launcher APK
echo ========================================
echo.
echo This will download Gradle (first time only) and build the APK.
echo Please be patient, this may take several minutes...
echo.

call gradlew.bat clean assembleRelease

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo BUILD SUCCESSFUL!
    echo ========================================
    echo.
    echo APK location: app\build\outputs\apk\release\app-release.apk
    echo.
    if exist "app\build\outputs\apk\release\app-release.apk" (
        echo APK file found! You can now share this file.
        echo.
        explorer "app\build\outputs\apk\release"
    ) else (
        echo Warning: APK file not found at expected location.
    )
    echo.
) else (
    echo.
    echo ========================================
    echo BUILD FAILED!
    echo ========================================
    echo.
    echo Please check the error messages above.
    echo Make sure you have:
    echo - Java JDK installed and JAVA_HOME set
    echo - Android SDK installed and ANDROID_SDK_ROOT set
    echo - Internet connection (for downloading dependencies)
    echo.
)

pause

