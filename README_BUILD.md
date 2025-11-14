# Baaki Khata Launcher - Build Instructions

This is a simple Android launcher app that opens https://baakikhata.mmpurbouddhasangha.org.in/ in Google Chrome with minimal UI.

## Building the APK Without Android Studio

### Option 1: Using Gradle (Recommended)

#### Prerequisites:
1. **Java JDK 8 or higher** - Download from [Oracle](https://www.oracle.com/java/technologies/downloads/) or [OpenJDK](https://adoptium.net/)
2. **Android SDK** - Download from [Android Developer](https://developer.android.com/studio#command-tools)
3. **Gradle** - Download from [Gradle Releases](https://gradle.org/releases/)

#### Setup Steps:

1. **Install Java JDK**
   - Download and install JDK 8 or higher
   - Set `JAVA_HOME` environment variable to JDK installation path
   - Add `%JAVA_HOME%\bin` to PATH (Windows) or `$JAVA_HOME/bin` to PATH (Linux/Mac)

2. **Install Android SDK**
   - Download Android SDK Command Line Tools
   - Extract to a folder (e.g., `C:\Android\sdk`)
   - Set `ANDROID_HOME` environment variable to SDK path
   - Add `%ANDROID_HOME%\platform-tools` and `%ANDROID_HOME%\tools\bin` to PATH

3. **Install Gradle**
   - Download Gradle from https://gradle.org/releases/
   - Extract to a folder
   - Add Gradle `bin` folder to PATH

4. **Accept Android Licenses**
   ```bash
   sdkmanager --licenses
   ```
   Accept all licenses when prompted.

5. **Build the APK**

   **Windows:**
   ```cmd
   BUILD_APK.bat
   ```

   **Linux/Mac:**
   ```bash
   chmod +x BUILD_APK.sh
   ./BUILD_APK.sh
   ```

   **Or manually:**
   ```bash
   gradle clean
   gradle assembleRelease
   ```

6. **Find the APK**
   - The APK will be located at: `app/build/outputs/apk/release/app-release.apk`

### Option 2: Using Android Studio (If Available)

1. Open the project in Android Studio
2. Go to **Build** → **Build Bundle(s) / APK(s)** → **Build APK(s)**
3. Wait for build to complete
4. Click **locate** in the notification to find the APK

### Option 3: Online Build Services

You can also use online services like:
- **GitHub Actions** (if you have a GitHub account)
- **Bitrise** (free tier available)
- **CircleCI** (free tier available)

## Signing the APK (Optional)

For distribution, you may want to sign the APK:

1. Generate a keystore:
   ```bash
   keytool -genkey -v -keystore baakikhata.keystore -alias baakikhata -keyalg RSA -keysize 2048 -validity 10000
   ```

2. Create `keystore.properties` in the project root:
   ```
   storePassword=your_store_password
   keyPassword=your_key_password
   keyAlias=baakikhata
   storeFile=baakikhata.keystore
   ```

3. Update `app/build.gradle` to include signing config (see Android documentation)

## Troubleshooting

### "Gradle not found"
- Make sure Gradle is installed and added to PATH
- Verify with: `gradle --version`

### "SDK not found"
- Set `ANDROID_HOME` environment variable
- Make sure Android SDK is properly installed

### "Java not found"
- Install JDK 8 or higher
- Set `JAVA_HOME` environment variable

### Build fails with dependency errors
- Make sure you have internet connection (Gradle downloads dependencies)
- Check if repositories are accessible (google(), mavenCentral())

## APK Location

After successful build, the APK will be at:
```
app/build/outputs/apk/release/app-release.apk
```

## Features

- Opens website in Google Chrome (not WebView)
- Minimal UI with hidden URL bar (using Chrome Custom Tabs)
- Simple launcher - just opens the website
- Auto-launches Chrome when app is opened

## Notes

- The app requires Google Chrome to be installed on the device
- If Chrome is not installed, it will fallback to the default browser
- The URL bar hiding works best with Chrome Custom Tabs

