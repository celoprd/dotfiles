#!/bin/bash

# Setup symbolic links for configuration files

set -e

echo "🔗 Creating symbolic links for configuration files..."

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
CONFIG_DIR="$DOTFILES_DIR/config"

# Function to create symlink
create_symlink() {
    local source="$1"
    local target="$2"

    # If target already exists and is not a symlink, backup
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo "Backing up existing $target to ${target}.backup"
        mv "$target" "${target}.backup"
    fi

    # If target is already a symlink to the correct source, skip
    if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
        echo "✓ $target already linked correctly"
        return
    fi

    # Remove existing symlink if it points elsewhere
    if [ -L "$target" ]; then
        echo "Removing existing symlink $target"
        rm "$target"
    fi

    # Create symlink
    echo "Creating symlink: $target -> $source"
    ln -s "$source" "$target"
    echo "✓ Created symlink for $(basename $target)"
}

# Create symlinks for configuration files
create_symlink "$CONFIG_DIR/.zshrc" "$HOME/.zshrc"
create_symlink "$CONFIG_DIR/.npmrc" "$HOME/.npmrc"
create_symlink "$CONFIG_DIR/.gitconfig" "$HOME/.gitconfig"
create_symlink "$CONFIG_DIR/.env.zsh" "$HOME/.env.zsh"
create_symlink "$CONFIG_DIR/.gitignore_global" "$HOME/.gitignore_global"

echo ""
echo "✓ All symbolic links created successfully"
echo ""
echo "Configuration files are now linked to ~/dotfiles/config/"
echo "Any changes to files in ~/dotfiles/config/ will be reflected in your home directory"
