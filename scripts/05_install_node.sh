#!/bin/bash

# Install Node.js using 'n' version manager

set -e

echo "📗 Installing Node.js with 'n' version manager..."

# Set N_PREFIX early
export N_PREFIX="$HOME/.n"
export PATH="$N_PREFIX/bin:$PATH"

# Check if n is already installed
if command -v n &> /dev/null; then
    echo "✓ 'n' already installed"
else
    echo "Installing 'n'..."
    curl -fsSL https://raw.githubusercontent.com/tj/n/master/bin/n -o /tmp/n
    bash /tmp/n lts
    rm /tmp/n
    # Re-export PATH to include the newly installed n
    export PATH="$N_PREFIX/bin:$PATH"
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
corepack enable

# Install pnpm
echo "Installing pnpm..."
corepack prepare pnpm@latest --activate

echo "✓ Node.js installation complete"
echo "Installed versions:"
n ls
