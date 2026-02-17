# 🚀 Quick Start Guide

## Complete Installation (new Mac)

```bash
# 1. Clone this repository
mkdir -p ~/skello
cd ~/skello
git clone git@github.com:<your-username>/dotfiles.git
cd dotfiles

# 2. Run complete installation
./install.sh
```

The installation will:
- ✅ Install Xcode Command Line Tools
- ✅ Install Homebrew
- ✅ Install all applications (VSCode, Warp, Slack, Notion, etc.)
- ✅ Install Oh My Zsh
- ✅ Install Node.js (v20, v22, v24) with 'n'
- ✅ Install Ruby 2.7.3 with rbenv
- ✅ Install AWS CLI, EAS CLI
- ✅ Create your SSH and GPG keys
- ✅ Create symbolic links to your configs

## After Installation

### 1. Add your SSH key to GitHub

```bash
# Copy your SSH public key
pbcopy < ~/.ssh/id_ed25519.pub

# Then go to https://github.com/settings/keys and add it
```

### 2. Add your GPG key to GitHub

```bash
# List your GPG keys
gpg --list-secret-keys --keyid-format=long

# Copy your GPG public key (replace KEY_ID with your ID)
gpg --armor --export KEY_ID | pbcopy

# Then go to https://github.com/settings/keys and add it
```

### 3. Test GitHub connection

```bash
ssh -T git@github.com
# Should display: Hi username! You've successfully authenticated...
```

### 4. Configure your environment variables

```bash
# Edit the .env.zsh file
nano ~/dotfiles/config/.env.zsh

# Add your tokens and company variables
```

### 5. Reload your shell

```bash
source ~/.zshrc
```

## Partial Installation (update)

You can also run scripts individually:

```bash
# Install only Node.js
./scripts/05_install_node.sh

# Recreate only symbolic links
./scripts/08_setup_symlinks.sh

# Update Homebrew packages
brew bundle --file=~/skello/dotfiles/Brewfile
```

## Git Configuration

After installation, verify your Git configuration:

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@skello.io"
git config --global user.signingkey YOUR_GPG_KEY_ID
```

## Clone Skello Projects

```bash
# Run the Skello repositories clone script
./scripts/11_clone_skello_repos.sh
```

This will clone:
- All `svc-*` microservices
- All `skello-*` projects
- `skelloapp/actions` and `skelloapp/skills`
- DevOps repository

## Verify Installation

```bash
# Verify installed versions
node --version      # Should display v22.x.x
npm --version
pnpm --version
ruby --version      # Should display 2.7.3
git --version
aws --version
eas --version
```

## Common Issues

### Rosetta (Apple Silicon)

If you're on Apple Silicon (M1/M2/M3):
```bash
# Verify architecture
arch

# For some tools, you may need to use Rosetta
# Applications → Right click on Terminal → Get Info → Check "Open using Rosetta"
```

### GPG not signing commits

```bash
export GPG_TTY=$(tty)
```

### Homebrew not found after installation

```bash
# Apple Silicon
eval "$(/opt/homebrew/bin/brew shellenv)"

# Intel
eval "$(/usr/local/bin/brew shellenv)"
```

## Help

For more information, see the complete [README.md](README.md).
