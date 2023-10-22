# Test the project using CTest
#!/bin/bash

set -e

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
cd "$SCRIPT_DIR/.."

# Initialize default build type and flags
DEBUG_FLAG=0
RELEASE_FLAG=0
COVERAGE=false

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

pushd "./build/$PRESET/test"
ctest
popd

if $COVERAGE; then
    echo ${PWD}
    ls -a

    llvm-profdata merge -sparse ./build/${PRESET}/coverage/*.profraw -o ./build/${PRESET}/coverage/tinker.profdata
    llvm-cov show ./build/${PRESET}/test/TinkerEngine.test -object=./build/${PRESET}/core/TinkerEngine -instr-profile=./build/${PRESET}/coverage/tinker.profdata -format=html -output-dir=coverage_report -ignore-filename-regex=".*test/.*"
fi
