# Baaki Khata Launcher - Build Summary

## What This App Does

This Android app is a simple launcher that:
- Opens https://baakikhata.mmpurbouddhasangha.org.in/ in **Google Chrome** (not WebView)
- Uses Chrome Custom Tabs for a minimal UI experience
- Minimizes the URL bar visibility (Chrome Custom Tabs shows a minimal toolbar)

## Important Note About URL Bar Hiding

**Complete URL bar hiding** requires **Trusted Web Activities (TWA)**, which needs:
1. Digital Asset Links configuration on the website
2. Website owner's cooperation to set up `.well-known/assetlinks.json`

The current implementation uses **Chrome Custom Tabs**, which:
- Shows a minimal toolbar (much smaller than regular Chrome)
- Provides a better app-like experience
- Works without any website changes
- Is the best option when you don't control the website

## Project Structure

```
APK/
├── app/
│   ├── build.gradle          # App build configuration
│   └── src/main/
│       ├── AndroidManifest.xml
│       └── java/com/baakikhata/launcher/
│           └── MainActivity.java  # Main launcher code
├── build.gradle              # Project build configuration
├── settings.gradle
├── BUILD_APK.bat            # Windows build script
├── BUILD_APK.sh             # Linux/Mac build script
└── README_BUILD.md          # Detailed build instructions
```

## Quick Build Steps

1. **Install Prerequisites:**
   - Java JDK 11+
   - Android SDK
   - Gradle 7.5+

2. **Create `local.properties`:**
   ```
   sdk.dir=C:\\Android\\sdk
   ```
   (Update path to your Android SDK location)

3. **Build APK:**
   ```bash
   # Windows
   BUILD_APK.bat
   
   # Linux/Mac
   ./BUILD_APK.sh
   ```

4. **Find APK:**
   ```
   app/build/outputs/apk/release/app-release.apk
   ```

## Features

✅ Opens in Google Chrome (not WebView)  
✅ Minimal UI with Chrome Custom Tabs  
✅ Auto-launches website when app opens  
✅ Falls back to default browser if Chrome not installed  
✅ Simple, lightweight launcher app  

## Requirements

- Android 6.0 (API 23) or higher
- Google Chrome installed on device (for best experience)
- Internet connection (to load the website)

## Distribution

The generated APK can be shared directly. Users can install it by:
1. Enabling "Install from unknown sources" in Android settings
2. Transferring the APK to their device
3. Opening the APK file to install

## Troubleshooting

- **Build fails?** Check that Java, Android SDK, and Gradle are properly installed and in PATH
- **APK not found?** Check `app/build/outputs/apk/release/` directory
- **App doesn't open Chrome?** Make sure Google Chrome is installed on the device

