# Build the project using CMake
#!/bin/bash

set -e

# Initialize default build type and flags
BUILD_TYPE="release"
DEBUG_FLAG=0
RELEASE_FLAG=0
BUILD_TESTS="OFF"

# Process command line arguments
while [[ "$#" -gt 0 ]]; do
    case "$1" in
    --debug | -d)
        BUILD_TYPE="debug"
        DEBUG_FLAG=1
        shift
        ;;
    --release | -r)
        RELEASE_FLAG=1
        shift # Do nothing, default already set
        ;;
    --tests | -t)
        BUILD_TESTS="ON"
        shift
        ;;
    --help | -h)
        echo "Usage: $0 [option]"
        echo "Options:"
        echo "  debug, -d     Build in debug mode."
        echo "  release, -r   Build in release mode (default)."
        echo "  tests, -t     Build with tests."
        echo "  help, -h      Display this help message."
        exit 0
        ;;
    *)
        echo "Invalid argument: $1. Use '--help' for usage details."
        exit 1
        ;;
    esac
done

# Check if both debug and release flags are set
if [[ "$DEBUG_FLAG" -eq 1 && "$RELEASE_FLAG" -eq 1 ]]; then
    echo "Error: Both --debug and --release options cannot be set simultaneously."
    exit 1
fi

# Set up directories
BUILD_DIR="build/$BUILD_TYPE"
SCRIPT_DIR="scripts/"
mkdir -p "$BUILD_DIR"

# Navigate to project root

# Update dependencies and sources
$SCRIPT_DIR/update-dependencies.sh --$BUILD_TYPE
./scripts/update-sources.sh -d ./src
./scripts/update-sources.sh -d ./test

# Navigate to the build directory
pushd "./$BUILD_DIR"

# Format build type: capitalize the first letter
CMAKE_BUILD_TYPE=$(echo "$BUILD_TYPE" | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')

# Find the path to the clang-tidy executable (this is a workaround for macOS since clang-tidy in llvm points to the wrong clang++ executable)
export CXX=$(which clang++)

# Run cmake commands
cmake ../.. -DCMAKE_TOOLCHAIN_FILE=conan_toolchain.cmake -DCMAKE_BUILD_TYPE="$CMAKE_BUILD_TYPE" -DBUILD_TESTS="$BUILD_TESTS" -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
cmake --build .

# Return to the original directory
popd
