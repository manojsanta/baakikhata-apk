# PowerShell APK Builder
# Alternative build method using PowerShell

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "APK Builder (PowerShell)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check prerequisites
Write-Host "Checking prerequisites..." -ForegroundColor Yellow

# Check Java
try {
    $javaVersion = java -version 2>&1
    Write-Host "✓ Java found" -ForegroundColor Green
} catch {
    Write-Host "✗ Java not found!" -ForegroundColor Red
    Write-Host "Please install Java JDK" -ForegroundColor Red
    exit 1
}

# Check Android SDK
if (-not $env:ANDROID_SDK_ROOT) {
    Write-Host "✗ ANDROID_SDK_ROOT not set!" -ForegroundColor Red
    exit 1
} else {
    Write-Host "✓ Android SDK found: $env:ANDROID_SDK_ROOT" -ForegroundColor Green
}

# Check local.properties
if (-not (Test-Path "local.properties")) {
    Write-Host "✗ local.properties not found!" -ForegroundColor Red
    exit 1
} else {
    Write-Host "✓ local.properties found" -ForegroundColor Green
}

Write-Host ""
Write-Host "Starting build..." -ForegroundColor Yellow
Write-Host "This will take 5-10 minutes on first run." -ForegroundColor Yellow
Write-Host ""

# Stop daemons
Write-Host "Stopping Gradle daemons..." -ForegroundColor Gray
& .\gradlew.bat --stop | Out-Null

# Build
Write-Host "Building APK..." -ForegroundColor Yellow
$buildOutput = & .\gradlew.bat clean assembleRelease --no-daemon 2>&1

# Check result
if ($LASTEXITCODE -eq 0) {
    if (Test-Path "app\build\outputs\apk\release\app-release.apk") {
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Green
        Write-Host "BUILD SUCCESSFUL!" -ForegroundColor Green
        Write-Host "========================================" -ForegroundColor Green
        Write-Host ""
        
        $apk = Get-Item "app\build\outputs\apk\release\app-release.apk"
        Write-Host "APK Location: $($apk.FullName)" -ForegroundColor Green
        Write-Host "File Size: $([math]::Round($apk.Length/1MB, 2)) MB" -ForegroundColor Green
        Write-Host "Created: $($apk.LastWriteTime)" -ForegroundColor Green
        Write-Host ""
        
        Write-Host "Opening folder..." -ForegroundColor Yellow
        Start-Process explorer.exe -ArgumentList "app\build\outputs\apk\release"
    } else {
        Write-Host ""
        Write-Host "Build completed but APK not found!" -ForegroundColor Red
        Write-Host "Check build output above for errors." -ForegroundColor Red
    }
} else {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "BUILD FAILED!" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "Error output:" -ForegroundColor Red
    $buildOutput | Select-Object -Last 20
}

Write-Host ""
Read-Host "Press Enter to exit"

