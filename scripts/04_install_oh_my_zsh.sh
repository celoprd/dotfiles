#!/bin/bash

# Install Oh My Zsh

set -e

echo "🎨 Installing Oh My Zsh..."

# Check if already installed
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "✓ Oh My Zsh already installed"
else
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    echo "✓ Oh My Zsh installed"
fi

# Install popular plugins
echo "Installing Oh My Zsh plugins..."

# zsh-autosuggestions
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    echo "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    echo "✓ zsh-autosuggestions installed"
else
    echo "✓ zsh-autosuggestions already installed"
fi

# zsh-syntax-highlighting
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
    echo "Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    echo "✓ zsh-syntax-highlighting installed"
else
    echo "✓ zsh-syntax-highlighting already installed"
fi

echo "✓ Oh My Zsh and plugins installation complete"
