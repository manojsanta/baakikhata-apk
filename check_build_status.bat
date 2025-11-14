@echo off
if exist "app\build\outputs\apk\release\app-release.apk" (
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
    explorer "app\build\outputs\apk\release"
) else (
    echo.
    echo Build is still in progress or has not completed yet.
    echo.
    echo Please wait for the build to finish, or run:
    echo   build_apk_now.bat
    echo.
    echo The build process may take 5-10 minutes the first time
    echo (while downloading Gradle and dependencies).
    echo.
)
pause

