#!/bin/bash
set -e

# This script downloads and prepares the MacOS SDK for cross-compilation
# You need to provide your own copy of the MacOS SDK due to licensing restrictions

SDK_VERSION="11.3"
SDK_NAME="MacOSX${SDK_VERSION}.sdk"
SDK_ARCHIVE="${SDK_NAME}.tar.xz"

if [ ! -f "$SDK_ARCHIVE" ]; then
    echo "Please provide ${SDK_ARCHIVE} in the current directory"
    echo "Due to licensing restrictions, we cannot distribute the SDK"
    echo "You can extract it from Xcode.app with:"
    echo "  Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/${SDK_NAME}"
    exit 1
fi

for target in mac64 macarm64; do
    mkdir -p "images/base-${target}/sdk"
    cp "$SDK_ARCHIVE" "images/base-${target}/sdk/"
done

echo "SDK preparation complete" 