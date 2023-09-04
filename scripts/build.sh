#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
cd "$SCRIPT_DIR/.."

mkdir -p build

./scripts/update-sources.sh -d ./src
./scripts/update-sources.sh -d ./test

# # Navigate to build directory
pushd ./build

# # Run CMake and make
cmake .. -DCMAKE_TOOLCHAIN_FILE=conan_toolchain.cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTS=ON
cmake --build .

# # Return to the original directory
popd
