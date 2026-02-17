# 🏢 Skello Configuration

This document contains Skello-specific information for your development environment setup.

## Prerequisites Installed

✅ The following tools have been installed via the dotfiles scripts:

- **Xcode Command Line Tools** - For Git and compilation
- **Homebrew** - Package manager
- **Git** - Version control
- **Oh My Zsh** - Enhanced shell
- **rbenv** - Ruby version manager
- **Ruby 2.7.3** - Version required for Rails projects
- **PostgreSQL 13** - Database
- **Redis** - Cache and queues
- **Memcached** - Cache
- **Node.js** (v20, v22, v24) - For front-end projects
- **Yarn** - JS package manager
- **pnpm** - Modern JS package manager
- **jq** - JSON manipulation
- **GPG** - Commit signing

## GitHub Configuration

### 1. Environment Variables

Edit `~/dotfiles/config/.env.zsh` and add:

```bash
# GitHub Personal Access Token
export GITHUB_TOKEN="ghp_your_personal_access_token_here"
export GITHUB_USERNAME="your_github_username"

# AWS profile for Skello
export AWS_PROFILE="skello-dev"
export AWS_REGION="eu-west-1"
```

### 2. SSH Configuration for GitHub

Your SSH key has been configured. Add it to GitHub:

```bash
# Copy public key
cat ~/.ssh/id_ed25519.pub | pbcopy

# Go to https://github.com/settings/keys
# Click "New SSH key"
# Paste and save
```

### 3. GPG Configuration for Signing Commits

**⚠️ IMPORTANT: All Skello commits must be signed!**

```bash
# Display your GPG key
gpg --list-secret-keys --keyid-format=long

# Copy public key (replace KEY_ID)
gpg --armor --export KEY_ID | pbcopy

# Go to https://github.com/settings/keys
# Click "New GPG key"
# Paste and save
```

### 4. Verify Signature

```bash
# Make a test commit
cd ~/skello/test-repo
git commit --allow-empty -m "Test signed commit"

# Verify on GitHub that the "Verified" badge appears ✅
```

## Clone Skello Repositories

```bash
# Run the automated clone script
cd ~/dotfiles
./scripts/11_clone_skello_repos.sh
```

This script will clone:
- DevOps repository
- All `svc-*` microservices
- All `skello-*` projects
- `skelloapp/actions` and `skelloapp/skills`

It will also install skills with `pnpx skills add skelloapp/skills`

## Project Configuration

### Skello App (Rails)

```bash
cd ~/skello/skello-app

# Install gems
bundle install

# Setup database
rails db:setup

# Start server
rails server
```

### Skello Mobile (React Native)

```bash
cd ~/skello/skello-mobile

# Install dependencies
pnpm install

# For iOS
cd ios && pod install && cd ..

# Start Metro bundler
pnpm start

# In another terminal, start the app
pnpm ios  # or pnpm android
```

### Superadmin

```bash
cd ~/skello/superadmin

# Install dependencies
bundle install

# Setup database
rails db:setup

# Start server
rails server -p 3001
```

## Services to Start

To develop on Skello projects, you'll need:

```bash
# PostgreSQL
brew services start postgresql@13

# Redis
brew services start redis

# Memcached
brew services start memcached
```

To stop:
```bash
brew services stop postgresql@13
brew services stop redis
brew services stop memcached
```

## Environment Access

### Via SSH (if configured)

Follow internal documentation for:
- EC2 instance access
- Bastion configuration
- Rails console access on ECS

### AWS CLI

```bash
# Configure your AWS profile
aws configure --profile skello-dev

# Test
aws s3 ls --profile skello-dev
```

## Recommended Development Tools

### VSCode Extensions

Install these extensions in VSCode:
- Ruby
- Rails
- GitLens
- ESLint
- Prettier
- Docker
- PostgreSQL
- React Native Tools

```bash
# Install via CLI
code --install-extension rebornix.ruby
code --install-extension shopify.ruby-lsp
code --install-extension eamodio.gitlens
code --install-extension dbaeumer.vscode-eslint
code --install-extension esbenp.prettier-vscode
```

### Useful Aliases (already in .zshrc)

```bash
# Quick navigation
cdskello       # Go to skello-app
cdmobile       # Go to skello-mobile
cdsuperadmin   # Go to superadmin

# Git
gs    # git status
gco   # git checkout
gcb   # git checkout -b
gp    # git push
gl    # git log (graphical format)
```

## Recommended Git Workflow

```bash
# 1. Create a branch from sandbox
git checkout sandbox
git pull
git checkout -b feature/my-feature

# 2. Make your changes and commits
git add .
git commit -m "feat: feature description"

# 3. Push and create a Pull Request
git push origin feature/my-feature

# 4. On GitHub, create PR to sandbox
```

## Troubleshooting

### Incorrect Ruby version

```bash
rbenv install 2.7.3
rbenv global 2.7.3
ruby --version  # Should display 2.7.3
```

### PostgreSQL won't start

```bash
brew services restart postgresql@13
brew services list
```

### Gems won't install

```bash
# Check Bundler version
gem install bundler -v 2.3.21

# Clean and reinstall
bundle clean --force
bundle install
```

### Broken Node modules

```bash
# Clean cache
pnpm store prune

# Reinstall
rm -rf node_modules
pnpm install
```

## Resources

- **Skello Documentation**: [Internal Notion]
- **GitHub Skello**: https://github.com/skelloapp
- **Slack**: #dev channel for questions

## Important Notes

1. ⚠️ Always work on branches, never directly on `main` or `sandbox`
2. ✅ All commits must be signed with GPG
3. 📝 Follow branch and commit naming conventions
4. 🔍 Make reasonably sized PRs for easier review
5. 🧪 Always run tests before pushing

## Post-Installation Checklist

- [ ] SSH key added to GitHub
- [ ] GPG key added to GitHub
- [ ] Signed commits verified (✅ badge on GitHub)
- [ ] Environment variables configured in `.env.zsh`
- [ ] Skello repositories cloned
- [ ] PostgreSQL, Redis, Memcached started
- [ ] skello-app setup and functional
- [ ] skello-mobile setup and functional
- [ ] VSCode extensions installed
- [ ] AWS access configured (if applicable)
- [ ] Skills installed
