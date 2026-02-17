#!/bin/bash

# Install Node.js using 'n' version manager

set -e

echo "📗 Installing Node.js with 'n' version manager..."

# Set N_PREFIX early
export N_PREFIX="$HOME/.n"
export PATH="$N_PREFIX/bin:$PATH"

# Ensure .npm-global/bin is in PATH (where n command will be installed)
export PATH="$HOME/.npm-global/bin:$PATH"

# Check if n is already installed
if command -v n &> /dev/null; then
    echo "✓ 'n' already installed"
else
    echo "Installing 'n'..."
    # Install Node.js LTS using the n-install script
    curl -fsSL https://raw.githubusercontent.com/tj/n/master/bin/n -o /tmp/n
    bash /tmp/n lts
    rm /tmp/n

    # Install n command globally via npm
    echo "Installing 'n' command..."
    $N_PREFIX/bin/npm install -g n

    # Re-export PATH to include npm global bin
    export PATH="$HOME/.npm-global/bin:$PATH"
    echo "✓ 'n' installed"
fi

# Install Node.js versions
echo "Installing Node.js versions..."

# Use full path to n
N_BIN="$N_PREFIX/bin/n"

# Install v20
if $N_BIN ls 2>/dev/null | grep -q "20\."; then
    echo "✓ Node.js v20 already installed"
else
    echo "Installing Node.js v20..."
    $N_BIN install 20
    echo "✓ Node.js v20 installed"
fi

# Install v22
if $N_BIN ls 2>/dev/null | grep -q "22\."; then
    echo "✓ Node.js v22 already installed"
else
    echo "Installing Node.js v22..."
    $N_BIN install 22
    echo "✓ Node.js v22 installed"
fi

# Install v24 (if available, otherwise try latest)
echo "Installing Node.js v24 (or latest available)..."
$N_BIN install 24 || $N_BIN install latest

# Set default to v22
echo "Setting Node.js v22 as default..."
$N_BIN 22

# Verify installation
echo "Verifying Node.js installation..."
$N_PREFIX/bin/node --version
$N_PREFIX/bin/npm --version

# Enable corepack for pnpm
echo "Enabling corepack for pnpm..."
$N_PREFIX/bin/corepack enable

# Install pnpm via corepack
echo "Installing pnpm via corepack..."
$N_PREFIX/bin/corepack prepare pnpm@latest --activate

# Verify pnpm installation
if [ -f "$N_PREFIX/bin/pnpm" ]; then
    echo "✓ pnpm installed at $N_PREFIX/bin/pnpm"
    $N_PREFIX/bin/pnpm --version
else
    echo "⚠ pnpm binary not found, but corepack is enabled"
fi

echo "✓ Node.js installation complete"
echo "Installed versions:"
$N_BIN ls

echo ""
echo "⚠️  IMPORTANT: To use n and pnpm, reload your shell:"
echo "   source ~/.zshrc"
echo "   OR restart your terminal"
