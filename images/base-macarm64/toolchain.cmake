set(CMAKE_SYSTEM_NAME Darwin)
set(CMAKE_SYSTEM_PROCESSOR arm64)

set(triple aarch64-apple-darwin)

set(CMAKE_C_COMPILER ${triple}-clang)
set(CMAKE_CXX_COMPILER ${triple}-clang++)
set(CMAKE_AR ${triple}-ar)
set(CMAKE_RANLIB ${triple}-ranlib)
set(CMAKE_STRIP ${triple}-strip)

set(CMAKE_FIND_ROOT_PATH /opt/osxcross/SDK/MacOSX11.3.sdk /opt/ffbuild)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY) 