#!/bin/bash
set -e

# Check if MacOS SDK exists
SDK_VERSION=""
SDK_NAME="MacOSX${SDK_VERSION}.sdk"
SDK_ARCHIVE="${SDK_NAME}.tar.xz"

if [ ! -f "$SDK_ARCHIVE" ]; then
    echo "MacOS SDK not found!"
    echo "Please obtain ${SDK_ARCHIVE} from a Mac with Xcode installed:"
    echo ""
    echo "On your Mac, run:"
    echo "  cd /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/"
    echo "  tar -cJf ${SDK_ARCHIVE} ${SDK_NAME}"
    echo ""
    echo "Then copy ${SDK_ARCHIVE} to this directory and run this script again."
    exit 1
fi

# Prepare SDK
echo "Preparing MacOS SDK..."
./util/prepare_macos_sdk.sh

# Build for both architectures
echo "Building for macOS x64..."
./build.sh mac64 gpl

echo "Building for macOS ARM64..."
./build.sh macarm64 gpl

echo "Build complete! Check the artifacts directory for the builds." 