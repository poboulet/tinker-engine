# Install dependencies for the project using Conan.
#!/bin/bash

set -e

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
cd "$SCRIPT_DIR/.."

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
    --help | -h)
        echo "Usage: $0 [option]"
        echo "Options:"
        echo "  debug, -d     Install dependencies in for debug mode."
        echo "  release, -r   Install dependencies in for release mode. (default)"
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

CAPITALIZED_BUILD_TYPE=$(echo "$BUILD_TYPE" | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')

mkdir -p conan
conan install . --output-folder=./build/$BUILD_TYPE --build=missing -s build_type=$CAPITALIZED_BUILD_TYPE$()
