#!/bin/bash

./scripts/update-sources.sh

# Remove existing build directory and recreate it
rm -rf build
mkdir -p build

# Navigate to build directory
pushd build

# Run CMake and make
cmake ..
make

# Return to the original directory
popd
