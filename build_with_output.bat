@echo off
echo Building APK with full output...
echo.
gradlew.bat clean assembleRelease --no-daemon --stacktrace > build_full_output.txt 2>&1

echo.
echo ========================================
if %ERRORLEVEL% EQU 0 (
    echo BUILD SUCCESSFUL!
    echo ========================================
    if exist "app\build\outputs\apk\release\app-release.apk" (
        echo.
        echo APK Location: app\build\outputs\apk\release\app-release.apk
        explorer "app\build\outputs\apk\release"
    )
) else (
    echo BUILD FAILED!
    echo ========================================
    echo.
    echo Check build_full_output.txt for details.
    echo.
    echo Last 30 lines of output:
    powershell -Command "Get-Content build_full_output.txt -Tail 30"
)
echo.
pause

