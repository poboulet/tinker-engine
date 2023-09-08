# Update the CMakeLists.txt file with the list of all .cpp files in the current directory
#!/bin/bash

ROOT_FOLDER="$(dirname "$(readlink -f "$0")")/.."
cd $ROOT_FOLDER

while [ $# -gt 0 ]; do
    case "$1" in
    -h | --help)
        echo "Usage: $0 [OPTIONS]"
        echo "Options:"
        echo "  -d, --directory            Specify the target folder that contains the CMake file"
        echo "  -h, --help                 Display this help message"
        exit 0
        ;;
    -d | --directory)
        Directory="$2"
        shift
        ;;
    *)
        echo "Unknown parameter passed: $1"
        exit 1
        ;;
    esac
    shift
done

if [ "$Directory" == "" ]; then
    echo "No target directory specified. Defaulting to ./"
    export Directory=.
fi

export CMakeFilePath=./CMakeLists.txt

pushd $Directory
export AUTO_UPDATE_CPP_FILES=$(find . -name "*.cpp" | sed 's/.*/    &/')
perl -i -pe 'BEGIN{undef $/;} s/set\(SOURCES.*?\)/set(SOURCES \n$ENV{AUTO_UPDATE_CPP_FILES}\n)/sm' $CMakeFilePath

# Check if the replace was successful
if [ $? -eq 0 ]; then
    echo -e "\n--------------------------------------------------------------------------------------"
    echo -e "Updated CMake sources ($CMakeFilePath) with the following files:\n$AUTO_UPDATE_CPP_FILES"
    echo -e "--------------------------------------------------------------------------------------\n"
else
    echo "$CMakeFilePath update failed. \n"
fi

popd
