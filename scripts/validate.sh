# Run static code analysis using Cppcheck

#!/bin/bash

set -e

# Get the directory of the script
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
cd "$SCRIPT_DIR/.."

while [[ "$#" -gt 0 ]]; do
    case "$1" in
    --preset | -p)
        PRESET="$2"
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

if ! command -v cppcheck &>/dev/null; then
    echo "Error: cppcheck is not installed or not found in PATH."
    exit 1
fi

# If no arguments are provided, default to current directory
cppcheck --enable=all --suppress=missingIncludeSystem --suppress=unusedFunction --project=build/${PRESET}/compile_commands.json 2>./temp_cppcheck_output.txt
if [ -s temp_cppcheck_output.txt ]; then
    echo "Cppcheck found issues:"
    cat temp_cppcheck_output.txt
    exit 1
else
    echo "No issues found by cppcheck"
fi
