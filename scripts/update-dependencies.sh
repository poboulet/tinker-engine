SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
cd "$SCRIPT_DIR/.."

BUILD_TYPE="release"

# If an argument is provided, use it to set the build type
if [ "$#" -eq 1 ]; then
    if [ "$1" = "debug" ]; then
        BUILD_TYPE="debug"
    elif [ "$1" != "release" ]; then
        echo "Invalid build type. Accepted values are 'debug' or 'release'. Default is 'release'."
        exit 1
    fi
fi

CAPITALIZED_BUILD_TYPE=$(echo "$BUILD_TYPE" | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')

conan install . --output-folder=./build/$BUILD_TYPE --build=missing -s build_type=$CAPITALIZED_BUILD_TYPE