#!/bin/bash

# Default to release build type
BUILD_TYPE="release"

# If an argument is provided, use it to set the build type
if [ "$#" -eq 1 ]; then
    if [ "$1" = "debug" ]; then
        BUILD_TYPE="debug"
    elif [ "$1" != "release" ]; then
        echo "Invalid build type. Accepted values are 'debug' or 'release'. Default is 'release'."
        exit 1
    fi
fi

BUILD_DIR="build/$BUILD_TYPE"
mkdir -p "$BUILD_DIR"

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
cd "$SCRIPT_DIR/.."

$SCRIPT_DIR/update-dependencies.sh $BUILD_TYPE


./scripts/update-sources.sh -d ./src
./scripts/update-sources.sh -d ./test

# Navigate to build directory
pushd "./$BUILD_DIR"

# Capitalize the first letter of BUILD_TYPE for CMAKE_BUILD_TYPE value
CMAKE_BUILD_TYPE=$(echo "$BUILD_TYPE" | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')

cmake ../.. -DCMAKE_TOOLCHAIN_FILE=conan_toolchain.cmake -DCMAKE_BUILD_TYPE="$CMAKE_BUILD_TYPE" -DBUILD_TESTS=ON
cmake --build .

# Return to the original directory
popd
