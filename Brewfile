# Brewfile - Homebrew Bundle
# This file defines all packages and applications to install via Homebrew
# Install with: brew bundle --file=~/dotfiles/Brewfile

# Taps (additional repositories) - removed deprecated taps

# ===== CORE DEVELOPMENT TOOLS =====

# Version control
brew "git"

# Shell
brew "zsh"

# Ruby version manager (for Skello projects)
brew "rbenv"
brew "ruby-build"

# Package managers
brew "yarn"

# ===== SKELLO REQUIRED TOOLS =====

# Databases
brew "postgresql@13"
brew "redis"
brew "memcached"

# Utilities
brew "jq"              # JSON processor
brew "gpg"             # For signing commits
brew "wget"            # Download utility
brew "curl"            # Transfer data utility

# ===== ADDITIONAL DEVELOPMENT TOOLS =====

# AWS CLI (installed via script, but can be managed here too)
# brew "awscli"

# Node.js utilities (n is installed via script)
# Note: We don't install node via brew to avoid conflicts with 'n'

# Other useful tools
brew "tree"            # Display directory tree
brew "htop"            # Better top
brew "fzf"             # Fuzzy finder
brew "ripgrep"         # Fast search tool
brew "bat"             # Better cat with syntax highlighting
brew "eza"             # Better ls (modern replacement for exa)

# ===== APPLICATIONS (CASKS) =====

# Development
cask "visual-studio-code"

# Terminal
cask "warp"

# Communication
cask "slack"

# VPN
cask "openvpn-connect"

# Productivity
cask "notion"
cask "notion-calendar"

# Security
cask "dashlane"

# ===== OPTIONAL BUT RECOMMENDED =====

# Browsers (uncomment if needed)
cask "google-chrome"
cask "firefox"

# Other useful apps (uncomment if needed)
cask "docker"
cask "postman"
cask "iterm2"           # Alternative terminal
cask "sublime-text"     # Text editor
cask "spotify"

# Mac App Store applications (if using 'mas')
# mas "Xcode", id: 497799835
