#!/bin/bash

# Install Xcode Command Line Tools

set -e

echo "📦 Installing Xcode Command Line Tools..."

# Check if already installed
if xcode-select -p &> /dev/null; then
    echo "✓ Xcode Command Line Tools already installed"
    xcode-select -p
else
    echo "Installing Xcode Command Line Tools (this may take a while)..."
    xcode-select --install

    # Wait for installation to complete
    echo "Please complete the installation in the popup window..."
    echo "Press any key once the installation is complete..."
    read -n 1 -s

    echo "✓ Xcode Command Line Tools installed"
fi

# Verify installation
if xcode-select -p &> /dev/null; then
    echo "✓ Verification successful"
else
    echo "✗ Installation verification failed"
    exit 1
fi
