# Manual APK Build Steps (Alternative Method)

If automated builds fail, follow these manual steps:

## Step 1: Verify Prerequisites

```cmd
java -version
echo %ANDROID_SDK_ROOT%
```

Both should show output.

## Step 2: Clean Previous Builds

```cmd
gradlew.bat --stop
gradlew.bat clean
```

## Step 3: Build Step by Step

### Step 3a: Download Dependencies (First Time Only)
```cmd
gradlew.bat dependencies --no-daemon
```
Wait for this to complete (5-10 minutes first time).

### Step 3b: Compile Code
```cmd
gradlew.bat compileReleaseJavaWithJavac --no-daemon
```

### Step 3c: Generate Resources
```cmd
gradlew.bat processReleaseResources --no-daemon
```

### Step 3d: Build APK
```cmd
gradlew.bat assembleRelease --no-daemon
```

## Step 4: Verify APK

```cmd
dir app\build\outputs\apk\release\app-release.apk
```

## Alternative: Use Android SDK Tools Directly

If Gradle completely fails, you can use Android SDK tools:

1. **Compile Java to DEX:**
   ```cmd
   %ANDROID_SDK_ROOT%\build-tools\28.0.3\dx.bat --dex --output=classes.dex app\build\intermediates\javac\release\classes
   ```

2. **Package APK:**
   ```cmd
   %ANDROID_SDK_ROOT%\build-tools\28.0.3\aapt.exe package -f -M app\src\main\AndroidManifest.xml -S app\src\main\res -I %ANDROID_SDK_ROOT%\platforms\android-34\android.jar -F app-release-unsigned.apk
   ```

3. **Add DEX to APK:**
   ```cmd
   %ANDROID_SDK_ROOT%\build-tools\28.0.3\aapt.exe add app-release-unsigned.apk classes.dex
   ```

4. **Sign APK:**
   ```cmd
   jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore debug.keystore app-release-unsigned.apk androiddebugkey
   ```

5. **Align APK:**
   ```cmd
   %ANDROID_SDK_ROOT%\build-tools\28.0.3\zipalign -v 4 app-release-unsigned.apk app-release.apk
   ```

This is more complex but works if Gradle fails.

