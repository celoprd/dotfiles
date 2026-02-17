#!/bin/bash

# Configure npm authentication for GitHub Packages

set -e

echo "🔐 Configuring npm authentication for GitHub Packages..."

# Check if GITHUB_TOKEN is set
if [ -z "$GITHUB_TOKEN" ]; then
    echo "❌ Error: GITHUB_TOKEN environment variable is not set!"
    echo ""
    echo "Please ensure you have:"
    echo "1. Created config/.env.zsh from config/.env.zsh.example"
    echo "2. Added your GitHub token to config/.env.zsh"
    echo "3. Reloaded your shell: source ~/.zshrc"
    echo ""
    echo "Then run this script again."
    exit 1
fi

DOTFILES_DIR="$HOME/Skello/dotfiles"
NPMRC_TEMPLATE="$DOTFILES_DIR/config/.npmrc"
NPMRC_TARGET="$HOME/.npmrc"

echo ""
echo "Setting up ~/.npmrc..."

# If .npmrc is a symlink, remove it
if [ -L "$NPMRC_TARGET" ]; then
    echo "Found symlink at ~/.npmrc, replacing with a copy..."
    rm "$NPMRC_TARGET"
fi

# Backup existing .npmrc if it's a regular file
if [ -f "$NPMRC_TARGET" ] && [ ! -L "$NPMRC_TARGET" ]; then
    echo "Backing up existing ~/.npmrc to ~/.npmrc.backup"
    cp "$NPMRC_TARGET" "$NPMRC_TARGET.backup"
fi

# Copy the template
echo "Copying npmrc template..."
cp "$NPMRC_TEMPLATE" "$NPMRC_TARGET"

# Remove the commented auth line if it exists
sed -i.tmp '/^# \/\/npm.pkg.github.com\/:_authToken/d' "$NPMRC_TARGET"
rm "$NPMRC_TARGET.tmp"

# Add the auth token
echo "Adding GitHub Packages authentication..."
echo "" >> "$NPMRC_TARGET"
echo "# GitHub Packages authentication token" >> "$NPMRC_TARGET"
echo "//npm.pkg.github.com/:_authToken=${GITHUB_TOKEN}" >> "$NPMRC_TARGET"

echo "✅ npm authentication configured successfully!"
echo ""
echo "📝 Note: ~/.npmrc is now a regular file (not a symlink)"
echo "   This allows storing your private token securely."
echo "   The file contains your GitHub token and should NOT be committed to git."
echo ""
echo "You can now install @skelloapp packages:"
echo "  pnpm install"
echo "  npm install"
echo ""
