# Run static code analysis using Cppcheck

#!/bin/bash

# Get the directory of the script
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
cd "$SCRIPT_DIR/.."

# Initialize default build type and flags
BUILD_TYPE="release"
DEBUG_FLAG=0
RELEASE_FLAG=0
BUILD_TESTS="OFF"

while [[ "$#" -gt 0 ]]; do
    case "$1" in
    --debug | -d)
        BUILD_TYPE="debug"
        DEBUG_FLAG=1
        shift
        ;;
    --release | -r)
        RELEASE_FLAG=1
        shift
        ;;
    *)
        echo "Invalid argument: $1. Use '--help' for usage details."
        exit 1
        ;;
    esac
done

# If no arguments are provided, default to current directory
if [ "$#" -eq 0 ]; then
    cppcheck --enable=all --suppress=missingIncludeSystem --project=build/${BUILD_TYPE}/compile_commands.json
else
    cppcheck --enable=all --suppress=missingIncludeSystem --file-filter=$1 --project=build/${BUILD_TYPE}/compile_commands.json
fi
