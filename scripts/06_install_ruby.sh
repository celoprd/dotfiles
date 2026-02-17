#!/bin/bash

# Install Ruby using rbenv

set -e

echo "💎 Installing Ruby with rbenv..."

# Check if rbenv is installed
if ! command -v rbenv &> /dev/null; then
    echo "✗ rbenv is not installed. Please run 03_install_homebrew_packages.sh first."
    exit 1
fi

# Initialize rbenv
eval "$(rbenv init - zsh)"

# Install Ruby 2.7.3 (required for Skello)
RUBY_VERSION="2.7.3"

if rbenv versions | grep -q "$RUBY_VERSION"; then
    echo "✓ Ruby $RUBY_VERSION already installed"
else
    echo "Installing Ruby $RUBY_VERSION (this may take a while)..."
    rbenv install $RUBY_VERSION
    echo "✓ Ruby $RUBY_VERSION installed"
fi

# Set global Ruby version
echo "Setting Ruby $RUBY_VERSION as global version..."
rbenv global $RUBY_VERSION

# Verify installation
echo "Verifying Ruby installation..."
ruby --version

# Install Bundler
echo "Installing Bundler..."
gem install bundler -v 2.3.21

# Install useful development gems
echo "Installing useful development gems..."
gem install rake rspec rubocop rubocop-performance pry pry-byebug colored

# Rehash rbenv
rbenv rehash

echo "✓ Ruby installation complete"
echo "Installed Ruby version:"
rbenv versions
