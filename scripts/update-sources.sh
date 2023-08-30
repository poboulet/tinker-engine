#!/bin/bash

CMAKE_FILE="./CMakeLists.txt"

export AUTO_UPDATE_CPP_FILES=$(find ./src -name "*.cpp" | sed 's/.*/    &/')

# Replace the SOURCES variable in the CMakeLists.txt file
perl -i -pe 'BEGIN{undef $/;} s/set\(SOURCES.*?\)/set(SOURCES \n$ENV{AUTO_UPDATE_CPP_FILES}\n)/sm' "$CMAKE_FILE"

# Check if the replace was successful
if [ $? -eq 0 ]; then
    echo -e "Updated CMake sources ($CMAKE_FILE) with the following files:\n$AUTO_UPDATE_CPP_FILES"
else
    echo "$CMAKE_FILE update failed."
fi