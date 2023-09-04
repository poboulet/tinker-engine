#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
cd "$SCRIPT_DIR/.."

$SCRIPT_DIR/update-dependencies.sh
$SCRIPT_DIR/build.sh