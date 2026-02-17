#!/bin/bash

# Install Homebrew packages and applications from Brewfile

set -e

echo "📦 Installing Homebrew packages and applications..."

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
BREWFILE="$DOTFILES_DIR/Brewfile"

if [ ! -f "$BREWFILE" ]; then
    echo "✗ Brewfile not found at $BREWFILE"
    exit 1
fi

# Load Homebrew into PATH if it exists
if [[ $(uname -m) == 'arm64' ]]; then
    # Apple Silicon
    if [ -f "/opt/homebrew/bin/brew" ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    # Intel
    if [ -f "/usr/local/bin/brew" ]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
fi

# Check if brew is installed
if ! command -v brew &> /dev/null; then
    echo "✗ Homebrew is not installed. Please run 02_install_homebrew.sh first."
    exit 1
fi

# Install everything from Brewfile
echo "Installing packages from Brewfile..."
echo "This may take a while..."
brew bundle --file="$BREWFILE"

echo "✓ All Homebrew packages and applications installed"

# Cleanup
echo "Cleaning up..."
brew cleanup

echo "✓ Cleanup complete"
