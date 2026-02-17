#!/bin/bash

# Configure PATH for GUI applications on macOS
# This ensures tools like npx, pnpm, n are available to VS Code and other GUI apps

set -e

echo "🔧 Configuring PATH for GUI applications (VS Code, MCP servers, etc.)..."

# Create or update ~/.zprofile to export PATH for GUI apps
ZPROFILE="$HOME/.zprofile"

echo ""
echo "Setting up ~/.zprofile for GUI applications..."

# Backup existing .zprofile if it exists
if [ -f "$ZPROFILE" ] && [ ! -L "$ZPROFILE" ]; then
    echo "Backing up existing .zprofile to .zprofile.backup"
    cp "$ZPROFILE" "$ZPROFILE.backup"
fi

# Create .zprofile with PATH configuration
cat > "$ZPROFILE" << 'EOF'
# PATH configuration for GUI applications
# This file is loaded by login shells and makes tools available to GUI apps like VS Code

# Homebrew
if [[ $(uname -m) == 'arm64' ]]; then
  # Apple Silicon
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  # Intel
  eval "$(/usr/local/bin/brew shellenv)"
fi

# n (Node version manager)
export N_PREFIX="$HOME/.n"
export PATH="$N_PREFIX/bin:$PATH"

# npm global packages (for n, npx, and other global tools)
export PATH="$HOME/.npm-global/bin:$PATH"

# rbenv (Ruby)
if command -v rbenv &> /dev/null; then
  eval "$(rbenv init - zsh)"
fi

# Yarn global
export PATH="$HOME/.yarn/bin:$PATH"

# Local bin
export PATH="$HOME/.local/bin:$PATH"
EOF

echo "✅ ~/.zprofile created successfully"

echo ""
echo "🔄 To apply these changes to running GUI applications:"
echo "   1. Restart VS Code completely (Cmd+Q then reopen)"
echo "   2. Or restart your Mac"
echo ""
echo "  After restart, GUI apps will have access to:"
echo "   - npx, pnpm, npm (from ~/.n/bin and ~/.npm-global/bin)"
echo "   - node, n (Node version manager)"
echo "   - All other tools in your PATH"
echo ""
echo "✓ Configuration complete!"
