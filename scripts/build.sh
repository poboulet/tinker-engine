#!/bin/bash

set -e

BUILD_TESTS="OFF"
COVERAGE="OFF"

while [[ "$#" -gt 0 ]]; do
    case "$1" in
    --preset | -p)
        PRESET="$2"
        shift
        ;;
    --tests | -t)
        BUILD_TESTS="ON"
        shift
        ;;
    --coverage | -c)
        BUILD_TESTS="ON"
        COVERAGE="ON"
        shift
        ;;
    --help | -h)
        echo "Usage: $0 [build_type] [options]"
        echo "Presets:"
        echo "  debug-unix-x64       Build in debug mode for Unix x64."
        echo "  release-unix-x64     Build in release mode for Unix x64."
        echo "  debug-windows-x64    Build in debug mode for Windows x64."
        echo "  release-windows-x64  Build in release mode for Windows x64."
        echo "Options:"
        echo "  --tests, -t          Build with tests."
        echo "  --coverage, -c       Build with tests and coverage."
        echo "  --help, -h           Display this help message."
        exit 0
        ;;

    *)
        shift
        ;;
    esac
done

if [[ -z "$PRESET" ]]; then
    echo "Error: Please specify a build preset."
    exit 1
fi

BUILD_DIR="build/$BUILD_TYPE"
SCRIPT_DIR="scripts/"

./vcpkg/vcpkg install
./scripts/update-sources.sh -d ./core
./scripts/update-sources.sh -d ./test

CMAKE_BUILD_TYPE=$(echo "$BUILD_TYPE" | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')

export CXX=$(which clang++)

cmake --preset $PRESET -DBUILD_TESTS="$BUILD_TESTS" -DCOVERAGE="$COVERAGE" -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
cmake --build --preset $PRESET
