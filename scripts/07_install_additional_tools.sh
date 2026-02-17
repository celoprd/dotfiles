#!/bin/bash

# Install additional development tools

set -e

echo "🛠️  Installing additional development tools..."

# AWS CLI
echo "Installing AWS CLI..."
if command -v aws &> /dev/null; then
    echo "✓ AWS CLI already installed"
    aws --version
else
    echo "Downloading and installing AWS CLI..."
    if [[ $(uname -m) == 'arm64' ]]; then
        # Apple Silicon
        curl "https://awscli.amazonaws.com/AWSCLIV2-arm64.pkg" -o "/tmp/AWSCLIV2.pkg"
    else
        # Intel
        curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "/tmp/AWSCLIV2.pkg"
    fi
    sudo installer -pkg /tmp/AWSCLIV2.pkg -target /
    rm /tmp/AWSCLIV2.pkg
    echo "✓ AWS CLI installed"
    aws --version
fi

# EAS CLI (Expo Application Services)
echo "Installing EAS CLI..."
if command -v eas &> /dev/null; then
    echo "✓ EAS CLI already installed"
    eas --version
else
    echo "Installing EAS CLI globally via npm..."
    npm install -g eas-cli
    echo "✓ EAS CLI installed"
    eas --version
fi

# GitHub CLI (useful for GitHub operations)
echo "Installing GitHub CLI..."
if command -v gh &> /dev/null; then
    echo "✓ GitHub CLI already installed"
    gh --version
else
    brew install gh
    echo "✓ GitHub CLI installed"
    gh --version
fi

echo "✓ Additional development tools installation complete"
