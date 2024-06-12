#!/bin/bash

# Path to the user's home directory and the dotfiles directory
HOME_DIR="$HOME"
DOTFILES_DIR="$(dirname "$(readlink -f "$0")")"
echo "Home dir is $HOME"
echo "I am at ${DOTFILES_DIR}"

# Path to the current and new zshrc files
CURRENT_ZSHRC="$HOME_DIR/.zshrc"
NEW_ZSHRC="$DOTFILES_DIR/zshrc"

# Check if the .zshrc file exists and is not already a symbolic link that
# points to the intended target
if [[ -L "$CURRENT_ZSHRC" ]]; then
    # Check if the existing symlink correctly points to the new .zshrc
    EXISTING_LINK="$(readlink -f "$CURRENT_ZSHRC")"
    echo "Found an existing link: $CURRENT_ZSHRC -> $EXISTING_LINK"
    echo "Target $NEW_ZSHRC is required"
    if [[ "$EXISTING_LINK" == "$NEW_ZSHRC" ]]; then
        echo "Symlink is already set up correctly."
    else
        echo "Symlink exists but points to a different file: $EXISTING_LINK. Perhaps set by another dotfiles project clone in a different location? Anyway, updating symlink..."
        ln -sf "$NEW_ZSHRC" "$CURRENT_ZSHRC"
    fi
elif [[ -f "$CURRENT_ZSHRC" ]]; then
    echo "Found an existing file at $CURRENT_ZSHRC"
    # Find an available backup filename
    BACKUP="$HOME/.zshrc.bak"
    i=0
    while [[ -f "$BACKUP$i" ]]; do
        let i+=1
    done
    BACKUP="$BACKUP$i"
    # Move the existing .zshrc to the backup
    mv "$CURRENT_ZSHRC" "$BACKUP"
    echo "Moved existing .zshrc to backup file: $BACKUP"
    # Create a new symbolic link
    ln -sf "$NEW_ZSHRC" "$CURRENT_ZSHRC"
    echo "Symlink created: $CURRENT_ZSHRC -> $NEW_ZSHRC"
else
    # No .zshrc exists, simply create the symlink
    ln -sf "$NEW_ZSHRC" "$CURRENT_ZSHRC"
    echo "Symlink created: $CURRENT_ZSHRC -> $NEW_ZSHRC"
fi
