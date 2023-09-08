# Run static code analysis using Cppcheck

#!/bin/bash

# Get the directory of the script
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
cd "$SCRIPT_DIR/.."

# If no arguments are provided, default to current directory
if [ "$#" -eq 0 ]; then
    cppcheck --enable=all --suppress=missingIncludeSystem --project=compile_commands.json
else
    cppcheck --enable=all --suppress=missingIncludeSystem --file-filter=$1 --project=compile_commands.json
fi
