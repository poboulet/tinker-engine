#!/usr/bin/env zsh

exportString="export PATH=\"$PWD/bin:\$PATH\""

# Check if .zshrc exists
if [[ -e ~/.zshrc ]]; then
    # Check if the string already exists in .zshrc
    if ! grep -qF "$exportString" ~/.zshrc; then
        echo "$exportString" >>~/.zshrc
    fi
    source ~/.zshrc
fi
