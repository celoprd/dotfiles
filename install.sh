#!/bin/bash

# Dotfiles Installation Script
# This script automates the setup of a new Mac with all necessary tools and configurations

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get the directory where this script is located
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SCRIPTS_DIR="$DOTFILES_DIR/scripts"

echo -e "${BLUE}╔════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║     Dotfiles Installation Script - Skello     ║${NC}"
echo -e "${BLUE}╔════════════════════════════════════════════════╗${NC}"
echo ""

# Function to print step
print_step() {
    echo -e "\n${GREEN}==>${NC} ${BLUE}$1${NC}\n"
}

# Function to print success
print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

# Function to print error
print_error() {
    echo -e "${RED}✗${NC} $1"
}

# Function to print warning
print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    print_error "This script is only for macOS!"
    exit 1
fi

print_success "Running on macOS"

# Check for Apple Silicon
if [[ $(uname -m) == 'arm64' ]]; then
    print_warning "Detected Apple Silicon Mac"
    print_warning "Note: Some tools may require Rosetta 2"
    echo "To enable Rosetta for your terminal:"
    echo "  Applications → Right click on Terminal/iTerm → Get Info → 'Open using Rosetta'"
    echo ""
    read -p "Press enter to continue..."
fi

# Ask for sudo upfront
print_step "Requesting sudo access (may prompt for password)"
sudo -v

# Keep-alive: update existing sudo time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Step 1: Install Xcode Command Line Tools
print_step "Step 1/10: Installing Xcode Command Line Tools"
if [ -f "$SCRIPTS_DIR/01_install_xcode.sh" ]; then
    bash "$SCRIPTS_DIR/01_install_xcode.sh"
else
    print_warning "Script not found, skipping..."
fi

# Step 2: Install Homebrew
print_step "Step 2/10: Installing Homebrew"
if [ -f "$SCRIPTS_DIR/02_install_homebrew.sh" ]; then
    bash "$SCRIPTS_DIR/02_install_homebrew.sh"
else
    print_warning "Script not found, skipping..."
fi

# Step 3: Install Homebrew packages and applications
print_step "Step 3/10: Installing Homebrew packages and applications"
if [ -f "$SCRIPTS_DIR/03_install_homebrew_packages.sh" ]; then
    bash "$SCRIPTS_DIR/03_install_homebrew_packages.sh"
else
    print_warning "Script not found, skipping..."
fi

# Step 4: Install Oh My Zsh
print_step "Step 4/10: Installing Oh My Zsh"
if [ -f "$SCRIPTS_DIR/04_install_oh_my_zsh.sh" ]; then
    bash "$SCRIPTS_DIR/04_install_oh_my_zsh.sh"
else
    print_warning "Script not found, skipping..."
fi

# Step 5: Install Node.js
print_step "Step 5/10: Installing Node.js with 'n'"
if [ -f "$SCRIPTS_DIR/05_install_node.sh" ]; then
    bash "$SCRIPTS_DIR/05_install_node.sh"
else
    print_warning "Script not found, skipping..."
fi

# Step 6: Install Ruby
print_step "Step 6/10: Installing Ruby with rbenv"
if [ -f "$SCRIPTS_DIR/06_install_ruby.sh" ]; then
    bash "$SCRIPTS_DIR/06_install_ruby.sh"
else
    print_warning "Script not found, skipping..."
fi

# Step 7: Install additional tools (AWS CLI, EAS CLI, etc.)
print_step "Step 7/10: Installing additional development tools"
if [ -f "$SCRIPTS_DIR/07_install_additional_tools.sh" ]; then
    bash "$SCRIPTS_DIR/07_install_additional_tools.sh"
else
    print_warning "Script not found, skipping..."
fi

# Step 8: Setup symlinks
print_step "Step 8/11: Creating symbolic links for configuration files"
if [ -f "$SCRIPTS_DIR/08_setup_symlinks.sh" ]; then
    bash "$SCRIPTS_DIR/08_setup_symlinks.sh"
else
    print_warning "Script not found, skipping..."
fi

# Step 8.5: Configure npm authentication (optional)
print_step "Step 8.5/11: Configuring npm authentication for GitHub Packages (optional)"
echo "Do you want to configure npm authentication now? (requires GITHUB_TOKEN in .env.zsh) (y/N)"
read -r response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    if [ -f "$SCRIPTS_DIR/configure_npm_auth.sh" ]; then
        bash "$SCRIPTS_DIR/configure_npm_auth.sh"
    else
        print_warning "Script not found, skipping..."
    fi
else
    echo "Skipping npm authentication. You can configure it later with:"
    echo "  ./scripts/configure_npm_auth.sh"
fi

# Step 9: Setup SSH
print_step "Step 9/11: Setting up SSH keys"
if [ -f "$SCRIPTS_DIR/09_setup_ssh.sh" ]; then
    bash "$SCRIPTS_DIR/09_setup_ssh.sh"
else
    print_warning "Script not found, skipping..."
fi

# Step 10: Setup GPG
print_step "Step 10/11: Setting up GPG for commit signing"
if [ -f "$SCRIPTS_DIR/10_setup_gpg.sh" ]; then
    bash "$SCRIPTS_DIR/10_setup_gpg.sh"
else
    print_warning "Script not found, skipping..."
fi

# Step 11: Clone Skello repositories (optional)
print_step "Step 11/11: Cloning Skello repositories (optional)"
echo "Do you want to clone all Skello repositories now? (y/N)"
read -r response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    if [ -f "$SCRIPTS_DIR/11_clone_skello_repos.sh" ]; then
        bash "$SCRIPTS_DIR/11_clone_skello_repos.sh"
    else
        print_warning "Script not found, skipping..."
    fi
else
    echo "Skipping repository cloning. You can run it later with:"
    echo "  ./scripts/11_clone_skello_repos.sh"
fi

echo ""
echo -e "${BLUE}╔════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║            Installation Complete! 🎉           ║${NC}"
echo -e "${BLUE}╔════════════════════════════════════════════════╗${NC}"
echo ""

print_step "Next Steps:"
echo "1. Add your SSH public key to GitHub:"
echo -e "   ${YELLOW}cat ~/.ssh/id_ed25519.pub${NC}"
echo "   Then paste it at: https://github.com/settings/keys"
echo ""
echo "2. Add your GPG public key to GitHub:"
echo -e "   ${YELLOW}gpg --list-secret-keys --keyid-format=long${NC}"
echo -e "   ${YELLOW}gpg --armor --export <KEY_ID>${NC}"
echo "   Then paste it at: https://github.com/settings/keys"
echo ""
echo "3. Test GitHub connection:"
echo -e "   ${YELLOW}ssh -T git@github.com${NC}"
echo ""
echo "4. Edit environment variables:"
echo -e "   ${YELLOW}nano ~/dotfiles/config/.env.zsh${NC}"
echo ""
echo "5. Restart your terminal or run:"
echo -e "   ${YELLOW}source ~/.zshrc${NC}"
echo ""
print_success "All done! Enjoy your new Mac setup! 🚀"
