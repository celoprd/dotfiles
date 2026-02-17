# 🔄 Maintenance and Updates

This guide explains how to maintain and update your dotfiles configuration.

## Initialize Git Repository

If you haven't initialized Git in this folder yet:

```bash
cd ~/dotfiles

# Initialize Git
git init

# Add all files
git add .

# First commit
git commit -m "Initial dotfiles setup"

# Create a repository on GitHub
# Then add the remote
git remote add origin git@github.com:YOUR_USERNAME/dotfiles.git

# Push
git branch -M main
git push -u origin main
```

## Save Your Changes

When you modify your configurations:

```bash
cd ~/dotfiles

# View changes
git status

# Add modified files
git add config/.zshrc
git add config/.npmrc
# or all modified files
git add .

# Commit with descriptive message
git commit -m "feat: add new git aliases"

# Push to GitHub
git push
```

## Update on a New Machine

```bash
# Clone your dotfiles
git clone git@github.com:YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Run installation
./install.sh
```

## Sync Between Multiple Machines

### On source machine (where you make changes)

```bash
cd ~/dotfiles
git add .
git commit -m "Update configurations"
git push
```

### On target machine (where you want to get changes)

```bash
cd ~/dotfiles
git pull

# Recreate symbolic links if necessary
./scripts/08_setup_symlinks.sh

# Reload shell configuration
source ~/.zshrc
```

## Add New Applications

### Via Brewfile

1. Edit `Brewfile`:
```bash
nano ~/dotfiles/Brewfile
```

2. Add the application:
```ruby
# For a GUI application
cask "app-name"

# For a CLI tool
brew "package-name"
```

3. Install:
```bash
brew bundle --file=~/dotfiles/Brewfile
```

4. Save:
```bash
cd ~/dotfiles
git add Brewfile
git commit -m "Add new application: app-name"
git push
```

## Add New Aliases or Functions

1. Edit `.zshrc`:
```bash
nano ~/dotfiles/config/.zshrc
```

2. Add your aliases in the `# ALIASES` section:
```bash
alias my_alias="my command"
```

3. Changes are automatic via symbolic link
```bash
source ~/.zshrc
```

4. Save:
```bash
cd ~/dotfiles
git add config/.zshrc
git commit -m "Add new aliases"
git push
```

## Add New Environment Variables

1. Edit `.env.zsh`:
```bash
nano ~/dotfiles/config/.env.zsh
```

2. Add your variables:
```bash
export MY_VARIABLE="my_value"
```

3. Reload:
```bash
source ~/.zshrc
```

**⚠️ WARNING**: NEVER commit secrets/tokens to Git!

```bash
# .env.zsh is already in .gitignore to avoid committing secrets
# You can create a template without sensitive values
cp config/.env.zsh config/.env.zsh.template
```

## Update Installed Tools

### Homebrew

```bash
# Update Homebrew
brew update

# Update all packages
brew upgrade

# Clean old versions
brew cleanup
```

### Node.js

```bash
# List available versions
n ls-remote

# Install a new version
n install 24

# Use a specific version
n 24
```

### Ruby

```bash
# List available versions
rbenv install -l

# Install a new version
rbenv install 3.3.0

# Set as global version
rbenv global 3.3.0
```

### Ruby Gems

```bash
gem update
```

### Global npm Packages

```bash
npm update -g
```

## Create Backup Before Major Update

```bash
# Via Time Machine (recommended)
# Or manually

# Backup current configurations
cp -r ~/dotfiles ~/dotfiles.backup.$(date +%Y%m%d)

# Or create a Git branch
cd ~/dotfiles
git checkout -b backup-$(date +%Y%m%d)
git push origin backup-$(date +%Y%m%d)
git checkout main
```

## Restore from Backup

```bash
# Restore from a branch
cd ~/dotfiles
git checkout backup-20260217
./install.sh
```

## Clean Uninstall

If you want to remove dotfiles:

```bash
# 1. Remove symbolic links
rm ~/.zshrc
rm ~/.npmrc
rm ~/.gitconfig
rm ~/.env.zsh
rm ~/.gitignore_global

# 2. Restore backups if they exist
mv ~/.zshrc.backup ~/.zshrc
mv ~/.npmrc.backup ~/.npmrc
# etc...

# 3. Optional: remove dotfiles folder
rm -rf ~/dotfiles
```

## Version Control for Scripts

If you modify installation scripts, remember to:

1. Test on a virtual machine first
2. Document changes
3. Version with clear commits

```bash
git add scripts/05_install_node.sh
git commit -m "fix: correct Node.js installation for Apple Silicon"
git push
```

## Share with Team

If you want to share your dotfiles with the Skello team:

1. Clean sensitive information
2. Create a template version of `.env.zsh`
3. Document setup specifics
4. Create a README for the team

## Monthly Maintenance Checklist

- [ ] `brew update && brew upgrade` - Update Homebrew
- [ ] `brew cleanup` - Clean old versions
- [ ] Check for new Node.js versions
- [ ] Check for new Ruby versions if needed
- [ ] Update global gems
- [ ] Update global npm packages
- [ ] Backup dotfiles to GitHub
- [ ] Verify symbolic links still work
- [ ] Test installation scripts on a branch

## Resources

- [Awesome Dotfiles](https://github.com/webpro/awesome-dotfiles) - Inspiration
- [Homebrew Documentation](https://docs.brew.sh/)
- [Oh My Zsh Wiki](https://github.com/ohmyzsh/ohmyzsh/wiki)

## Support

For questions about these dotfiles:
- Check logs: `tail -f /var/log/install.log`
- Ask on Slack #dev
- Create an issue on the GitHub repository
