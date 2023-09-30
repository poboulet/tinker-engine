# Test the project using CTest
#!/bin/bash

set -e

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
cd "$SCRIPT_DIR/.."

# Initialize default build type and flags
BUILD_TYPE="release"
DEBUG_FLAG=0
RELEASE_FLAG=0
COVERAGE=false

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
    --cover | -c)
        COVERAGE=true
        shift
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

pushd "./build/$BUILD_TYPE/test"
ctest
popd

if $COVERAGE; then
    echo ${PWD}
    ls -a

    llvm-profdata merge -sparse ./build/${BUILD_TYPE}/coverage/*.profraw -o ./build/${BUILD_TYPE}/coverage/tinker.profdata
    llvm-cov show ./build/${BUILD_TYPE}/test/TinkerEngine.test -object=./build/${BUILD_TYPE}/core/TinkerEngine -instr-profile=./build/${BUILD_TYPE}/coverage/tinker.profdata -format=html -output-dir=coverage_report -ignore-filename-regex=".*test/.*"
fi
