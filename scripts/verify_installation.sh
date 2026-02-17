#!/bin/bash

# Verify Installation Script
# This script checks that all tools are properly installed and accessible

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "🔍 Verifying Dotfiles Installation..."
echo ""

# Function to check command
check_command() {
    local cmd=$1
    local name=$2
    if command -v "$cmd" &> /dev/null; then
        version=$($cmd --version 2>&1 | head -1)
        echo -e "${GREEN}✓${NC} $name: $version"
        return 0
    else
        echo -e "${RED}✗${NC} $name: NOT FOUND"
        return 1
    fi
}

# Check Homebrew
echo "📦 Package Managers:"
check_command brew "Homebrew"
echo ""

# Check Version Managers
echo "🔧 Version Managers:"
check_command n "n (Node version manager)"
check_command rbenv "rbenv (Ruby version manager)"
echo ""

# Check Node.js ecosystem
echo "📗 Node.js Ecosystem:"
check_command node "Node.js"
check_command npm "npm"
check_command pnpm "pnpm"
check_command yarn "yarn"
echo ""

# Check Ruby
echo "💎 Ruby:"
check_command ruby "Ruby"
check_command gem "gem"
check_command bundle "bundle"
echo ""

# Check Git & Tools
echo "🔨 Development Tools:"
check_command git "Git"
check_command aws "AWS CLI"
check_command jq "jq"
check_command gh "GitHub CLI"
echo ""

# Check Databases
echo "🗄️  Databases:"
check_command psql "PostgreSQL"
check_command redis-cli "Redis"
check_command memcached "Memcached"
echo ""

# Check PATH
echo "🛤️  PATH Configuration:"
echo "N_PREFIX: $N_PREFIX"
echo "Node binary: $(which node 2>/dev/null || echo 'NOT FOUND')"
echo "pnpm binary: $(which pnpm 2>/dev/null || echo 'NOT FOUND')"
echo "n binary: $(which n 2>/dev/null || echo 'NOT FOUND')"
echo ""

# Check symlinks
echo "🔗 Configuration Symlinks:"
if [ -L "$HOME/.zshrc" ]; then
    echo -e "${GREEN}✓${NC} ~/.zshrc → $(readlink ~/.zshrc)"
else
    echo -e "${RED}✗${NC} ~/.zshrc not a symlink"
fi

if [ -L "$HOME/.gitconfig" ]; then
    echo -e "${GREEN}✓${NC} ~/.gitconfig → $(readlink ~/.gitconfig)"
else
    echo -e "${RED}✗${NC} ~/.gitconfig not a symlink"
fi

if [ -L "$HOME/.npmrc" ]; then
    echo -e "${GREEN}✓${NC} ~/.npmrc → $(readlink ~/.npmrc)"
else
    echo -e "${RED}✗${NC} ~/.npmrc not a symlink"
fi

if [ -L "$HOME/.env.zsh" ]; then
    echo -e "${GREEN}✓${NC} ~/.env.zsh → $(readlink ~/.env.zsh)"
else
    echo -e "${YELLOW}⚠${NC} ~/.env.zsh not found (create from .env.zsh.example)"
fi

echo ""
echo "📝 Troubleshooting:"
echo "If commands are not found, try:"
echo "  1. Reload your shell: ${YELLOW}source ~/.zshrc${NC}"
echo "  2. Restart your terminal"
echo "  3. Check your PATH: ${YELLOW}echo \$PATH${NC}"
echo ""
