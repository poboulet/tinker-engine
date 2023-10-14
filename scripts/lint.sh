# Lint the project using clang-tidy
#!/bin/bash

set -e

SOURCE_DIR="."
EXCLUDED_DIRS=('build' 'vcpkg_installed' 'deploy' 'CMakeFiles' 'vcpkg')

while [[ "$#" -gt 0 ]]; do
    case "$1" in
    --preset | -p)
        PRESET="$2"
        shift
        ;;
    --coverage | -c)
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
        echo "  --coverage, -c       Run tests with coverage."
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

# Build the find exclusion arguments based on EXCLUDED_DIRS
FIND_EXCLUSIONS=""
for dir in "${EXCLUDED_DIRS[@]}"; do
    FIND_EXCLUSIONS="$FIND_EXCLUSIONS ! -path \"$SOURCE_DIR/$dir/*\""
done

echo "Running clang-tidy on files in $SOURCE_DIR"

echo $FIND_EXCLUSIONS
eval "find \"$SOURCE_DIR\" \( -name '*.cpp' -o -name '*.cc' -o -name '*.cxx' -o -name '*.c++' \) $FIND_EXCLUSIONS" | xargs clang-tidy -p "./build/$PRESET"
