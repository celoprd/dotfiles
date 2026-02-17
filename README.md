# Dotfiles - Mac Configuration

This project contains all configuration files and installation scripts to quickly set up a new Mac.

## 🚀 Quick Start

```bash
# Clone this repo
git clone git@github.com:<your-username>/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Run complete installation
./install.sh
```

## 📋 What's Installed

### Applications (via Homebrew Cask)
- Visual Studio Code
- Warp (terminal)
- Slack
- OpenVPN Connect
- Notion
- Notion Calendar

### Development Tools
- Xcode Command Line Tools
- Homebrew
- Git
- Oh My Zsh
- Node.js (via n) - versions 20, 22, 24
- EAS CLI (Expo)
- AWS CLI

### Skello Tools (company)
- rbenv (Ruby version manager)
- Ruby 2.7.3
- PostgreSQL 13
- Redis
- Memcached
- jq
- pnpm
- yarn
- GPG (for signing commits)

## 📁 Project Structure

```
dotfiles/
├── README.md                    # Complete documentation
├── QUICKSTART.md               # Quick start guide
├── SKELLO.md                   # Skello-specific configuration
├── MAINTENANCE.md              # Maintenance guide
├── install.sh                  # Main installation script
├── Brewfile                    # Homebrew applications list
├── .gitignore                  # Files to ignore
├── docs/                       # Additional documentation
│   └── NPMRC_SETUP.md         # NPM/GitHub Packages setup
├── config/                     # Configuration files
│   ├── .zshrc                 # Zsh configuration + aliases
│   ├── .npmrc                 # npm configuration (GitHub Packages)
│   ├── .gitconfig             # Git configuration
│   ├── .env.zsh               # Environment variables
│   └── .gitignore_global      # Global gitignore
└── scripts/                    # Installation scripts
    ├── 01_install_xcode.sh
    ├── 02_install_homebrew.sh
    ├── 03_install_homebrew_packages.sh
    ├── 04_install_oh_my_zsh.sh
    ├── 05_install_node.sh
    ├── 06_install_ruby.sh
    ├── 07_install_additional_tools.sh
    ├── 08_setup_symlinks.sh
    ├── 09_setup_ssh.sh
    ├── 10_setup_gpg.sh
    └── 11_clone_skello_repos.sh
```

## 🔗 Symbolic Links

Configuration files are automatically created with symbolic links:
- `~/.zshrc` → `~/dotfiles/config/.zshrc`
- `~/.npmrc` → `~/dotfiles/config/.npmrc`
- `~/.gitconfig` → `~/dotfiles/config/.gitconfig`
- `~/.env.zsh` → `~/dotfiles/config/.env.zsh`

## ⚙️ GitHub Configuration

Edit `config/.env.zsh` to add your environment variables:
```bash
# GitHub Personal Access Token
# Create at: https://github.com/settings/tokens
# Required scopes: repo, read:packages, write:packages
export GITHUB_TOKEN="ghp_your_personal_access_token_here"
export GITHUB_USERNAME="your_github_username"

# Other environment variables
```

**Important for npm**: After setting `GITHUB_TOKEN`, add this line to your `~/.npmrc`:
```bash
echo "//npm.pkg.github.com/:_authToken=\${GITHUB_TOKEN}" >> ~/.npmrc
```

See [docs/NPMRC_SETUP.md](docs/NPMRC_SETUP.md) for detailed npm/GitHub Packages configuration.

## 🍎 Apple Silicon Notes

If you have a Mac with Apple Silicon processor (M1/M2/M3), some tools may require Rosetta:
- Open Terminal/iTerm2 with Rosetta: `Applications → Right click → Get Info → check 'Open using Rosetta'`
- Verify mode: `arch` (should display `i386` in Rosetta mode, `arm64` in native mode)

## 📝 Post-Installation Manual Configuration

After automatic installation, you will need to:

1. **SSH Key for GitHub**
   - Key is generated automatically
   - Copy public key: `cat ~/.ssh/id_ed25519.pub`
   - Add to GitHub: https://github.com/settings/keys

2. **GPG Key for signing commits**
   - Key is generated automatically
   - Display key: `gpg --armor --export <KEY_ID>`
   - Add to GitHub: https://github.com/settings/keys

3. **Test GitHub connection**
   ```bash
   ssh -T git@github.com
   ```

4. **Environment variables**
   - Edit `~/dotfiles/config/.env.zsh`
   - Add your tokens and company variables

## 🔄 Updating Dotfiles

To update configurations:
```bash
cd ~/dotfiles
git pull
./scripts/08_setup_symlinks.sh  # Recreate links if needed
source ~/.zshrc
```

## 📦 Adding New Applications

Edit the `Brewfile` and add:
```ruby
# For a GUI application
cask "app-name"

# For a CLI package
brew "package-name"
```

Then run: `brew bundle --file=~/dotfiles/Brewfile`

## 🛠 Individual Scripts

You can also run scripts individually:
```bash
# Install only Node.js
./scripts/05_install_node.sh

# Recreate only symbolic links
./scripts/08_setup_symlinks.sh
```

## 📚 Resources

- [Homebrew](https://brew.sh)
- [Oh My Zsh](https://ohmyz.sh)
- [n - Node version manager](https://github.com/tj/n)
- [GitHub SSH Setup](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)
- [GPG Signing Commits](https://docs.github.com/en/authentication/managing-commit-signature-verification)
