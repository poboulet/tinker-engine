#!/usr/bin/env bash

exportString="export PATH=\"$PWD/bin:\$PATH\""

OS=$(uname)

# Check if .bashrc exists
if [[ -e ~/.bashrc ]]; then
    # Check if the string already exists in .bashrc
    if [[ $OS == "Darwin" ]]; then
        # Check if ~/.bash_profile exists and the string is not already present
        if [[ -e ~/.bash_profile && ! $(grep -qF "$exportString" ~/.bash_profile) ]]; then
            echo "MacOS: Adding paths to ~/bash_profile"
            echo "$exportString" >>~/.bash_profile
            source ~/.bash_profile
        fi
    fi

    if ! grep -qF "$exportString" ~/.bashrc; then
        echo "Adding paths to ~/.bashrc"
        echo "$exportString" >>~/.bashrc
        source ~/.bashrc
    fi
fi
