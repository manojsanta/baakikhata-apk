# Quick Build Guide

## Simplest Method: Use Android SDK Command Line Tools

### Step 1: Install Prerequisites

1. **Download Java JDK 11+** from https://adoptium.net/
2. **Download Android SDK Command Line Tools** from https://developer.android.com/studio#command-tools
3. **Download Gradle 7.5+** from https://gradle.org/releases/

### Step 2: Setup Environment Variables (Windows)

Open PowerShell as Administrator and run:

```powershell
# Set Java Home (replace with your JDK path)
[Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\Program Files\Java\jdk-11", "Machine")

# Set Android Home (replace with your SDK path)
[Environment]::SetEnvironmentVariable("ANDROID_HOME", "C:\Android\sdk", "Machine")

# Add to PATH
$currentPath = [Environment]::GetEnvironmentVariable("Path", "Machine")
[Environment]::SetEnvironmentVariable("Path", "$currentPath;C:\Android\sdk\platform-tools;C:\Android\sdk\tools\bin;C:\gradle\bin", "Machine")
```

### Step 3: Create local.properties

Create a file named `local.properties` in the project root with:

```properties
sdk.dir=C:\\Android\\sdk
```

(Replace `C:\\Android\\sdk` with your actual Android SDK path)

### Step 4: Accept Licenses

```bash
sdkmanager --licenses
```

Type `y` and press Enter for each license.

### Step 5: Build APK

**Windows:**
```cmd
BUILD_APK.bat
```

**Or manually:**
```cmd
gradle clean assembleRelease
```

### Step 6: Find Your APK

The APK will be at: `app\build\outputs\apk\release\app-release.apk`

---

## Alternative: Use Online CI/CD

If you have a GitHub account, you can push this code to GitHub and use GitHub Actions to build the APK automatically. This requires no local setup!

---

## Need Help?

If you encounter errors:
1. Make sure Java, Android SDK, and Gradle are in your PATH
2. Verify `local.properties` has the correct SDK path
3. Check that all Android licenses are accepted
4. Ensure you have internet connection (for downloading dependencies)

