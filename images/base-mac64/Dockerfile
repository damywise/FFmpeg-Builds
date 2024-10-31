ARG GH_REPO=ghcr.io/yt-dlp/ffmpeg-builds
FROM $GH_REPO/base:latest

# Install required packages
RUN apt-get update && \
    apt-get install -y \
    clang \
    libxml2-dev \
    xz-utils \
    cmake \
    patch \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# Download and setup MacOS SDK
RUN mkdir -p /opt/osxcross && \
    cd /opt/osxcross && \
    wget -q https://github.com/tpoechtrager/osxcross/archive/refs/heads/master.tar.gz && \
    tar xf master.tar.gz && \
    mv osxcross-master/* . && \
    rm -rf osxcross-master master.tar.gz

# Copy MacOS SDK
COPY sdk/MacOSX.sdk.tar.xz /opt/osxcross/tarballs/

# Build OSXCross
RUN cd /opt/osxcross && \
    UNATTENDED=1 ./build.sh && \
    rm -rf /opt/osxcross/build

# Prepare cross environment
RUN mkdir /opt/ffbuild

ENV FFBUILD_TOOLCHAIN=x86_64-apple-darwin \
    FFBUILD_RUST_TARGET=x86_64-apple-darwin \
    MACOSX_DEPLOYMENT_TARGET=10.15

RUN rustup target add "$FFBUILD_RUST_TARGET"

ADD toolchain.cmake /toolchain.cmake
ADD cross.meson /cross.meson

ENV PATH="/opt/osxcross/bin:${PATH}" \
    FFBUILD_TARGET_FLAGS="--pkg-config=pkg-config --arch=x86_64 --target-os=darwin" \
    FFBUILD_CROSS_PREFIX=${FFBUILD_TOOLCHAIN}- \
    FFBUILD_PREFIX=/opt/ffbuild \
    FFBUILD_CMAKE_TOOLCHAIN=/toolchain.cmake \
    PKG_CONFIG=pkg-config \
    PKG_CONFIG_LIBDIR=/opt/ffbuild/lib/pkgconfig:/opt/ffbuild/share/pkgconfig \
    CC="${FFBUILD_TOOLCHAIN}-clang" \
    CXX="${FFBUILD_TOOLCHAIN}-clang++" \
    LD="${FFBUILD_TOOLCHAIN}-ld" \
    AR="${FFBUILD_TOOLCHAIN}-ar" \
    RANLIB="${FFBUILD_TOOLCHAIN}-ranlib" \
    NM="${FFBUILD_TOOLCHAIN}-nm" \
    STRIP="${FFBUILD_TOOLCHAIN}-strip" \
    CFLAGS="-I/opt/ffbuild/include -O2 -pipe" \
    CXXFLAGS="-I/opt/ffbuild/include -O2 -pipe" \
    LDFLAGS="-L/opt/ffbuild/lib -O2 -pipe" 