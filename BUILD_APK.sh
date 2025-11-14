#!/bin/bash

echo "========================================"
echo "Building Baaki Khata Launcher APK"
echo "========================================"
echo ""

# Check if gradle is available
if ! command -v gradle &> /dev/null; then
    echo "ERROR: Gradle is not installed or not in PATH"
    echo ""
    echo "Please install Gradle:"
    echo "1. Download from https://gradle.org/releases/"
    echo "2. Extract and add to PATH"
    echo "OR"
    echo "Use Android Studio to build the APK"
    echo ""
    exit 1
fi

echo "Gradle found. Starting build..."
echo ""

# Clean previous builds
echo "Cleaning previous builds..."
gradle clean

# Build release APK
echo ""
echo "Building release APK..."
gradle assembleRelease

if [ $? -eq 0 ]; then
    echo ""
    echo "========================================"
    echo "BUILD SUCCESSFUL!"
    echo "========================================"
    echo ""
    echo "APK location: app/build/outputs/apk/release/app-release.apk"
    echo ""
    echo "You can now share this APK file."
    echo ""
else
    echo ""
    echo "========================================"
    echo "BUILD FAILED!"
    echo "========================================"
    echo ""
    echo "Please check the error messages above."
    echo ""
fi

