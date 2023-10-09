# Lint the project using clang-tidy
#!/bin/bash

set -e

BUILD_PATH="./build/release"
SOURCE_DIR="."
EXCLUDED_DIRS=('build' 'vcpkg_installed' 'deploy' 'CMakeFiles' 'vcpkg')

while getopts "p:s:e:" opt; do
    case "$opt" in
    p)
        BUILD_PATH="$OPTARG"
        ;;
    s)
        SOURCE_DIR="$OPTARG"
        ;;
    e)
        IFS=',' read -ra ADDR <<<"$OPTARG"
        EXCLUDED_DIRS=()
        for dir in "${ADDR[@]}"; do
            EXCLUDED_DIRS+=("$dir")
        done
        ;;
    \?)
        echo "Usage: $0 [-p build_path] [-s source_directory] [-e excluded_dirs_comma_separated]"
        exit 1
        ;;
    esac
done

# Build the find exclusion arguments based on EXCLUDED_DIRS
FIND_EXCLUSIONS=""
for dir in "${EXCLUDED_DIRS[@]}"; do
    FIND_EXCLUSIONS="$FIND_EXCLUSIONS ! -path \"$SOURCE_DIR/$dir/*\""
done

echo "Running clang-tidy on files in $SOURCE_DIR"

echo $FIND_EXCLUSIONS
eval "find \"$SOURCE_DIR\" \( -name '*.cpp' -o -name '*.cc' -o -name '*.cxx' -o -name '*.c++' \) $FIND_EXCLUSIONS" | xargs clang-tidy -p "$BUILD_PATH"
