#!/bin/bash

# Install Homebrew package manager

set -e

echo "🍺 Installing Homebrew..."

# Check if already installed
if command -v brew &> /dev/null; then
    echo "✓ Homebrew already installed"
    brew --version
else
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for current session
    if [[ $(uname -m) == 'arm64' ]]; then
        # Apple Silicon
        echo "Adding Homebrew to PATH (Apple Silicon)..."
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        # Intel
        echo "Adding Homebrew to PATH (Intel)..."
        eval "$(/usr/local/bin/brew shellenv)"
    fi

    echo "✓ Homebrew installed"
fi

# Update Homebrew
echo "Updating Homebrew..."
brew update

# Verify installation
if command -v brew &> /dev/null; then
    echo "✓ Verification successful"
    brew --version
else
    echo "✗ Installation verification failed"
    exit 1
fi
