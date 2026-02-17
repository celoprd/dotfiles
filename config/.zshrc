# ===== ZSH CONFIGURATION =====
# Path to Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Theme - change to your preference
# Popular themes: robbyrussell, agnoster, powerlevel10k/powerlevel10k
ZSH_THEME="robbyrussell"

# Plugins
plugins=(
  git
  npm
  node
  rbenv
  yarn
  docker
  docker-compose
  aws
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Load Oh My Zsh (only if installed)
if [ -f "$ZSH/oh-my-zsh.sh" ]; then
  source $ZSH/oh-my-zsh.sh
fi

# ===== ENVIRONMENT VARIABLES =====

# Load custom environment variables
if [ -f ~/.env.zsh ]; then
  source ~/.env.zsh
fi

# ===== PATH CONFIGURATION =====

# Homebrew (adjust for Apple Silicon if needed)
if [[ $(uname -m) == 'arm64' ]]; then
  # Apple Silicon
  if [ -f "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
else
  # Intel
  if [ -f "/usr/local/bin/brew" ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi

# rbenv (Ruby version manager)
if command -v rbenv &> /dev/null; then
  eval "$(rbenv init - zsh)"
fi

# n (Node version manager)
export N_PREFIX="$HOME/.n"
export PATH="$N_PREFIX/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# Yarn global
export PATH="$HOME/.yarn/bin:$PATH"

# Local bin
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# ===== ALIASES =====

# Git aliases
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git log --oneline --graph --decorate"
alias gco="git checkout"
alias gcb="git checkout -b"
alias gd="git diff"
alias gpl="git pull"

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~"

# Better ls with eza (if installed)
if command -v eza &> /dev/null; then
  alias ls="eza"
  alias ll="eza -l"
  alias la="eza -la"
  alias lt="eza --tree"
else
  alias ll="ls -lh"
  alias la="ls -lah"
fi

# Better cat with bat (if installed)
if command -v bat &> /dev/null; then
  alias cat="bat"
fi

# Shortcuts
alias zshconfig="code ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"
alias reload="source ~/.zshrc"

# npm aliases
alias ni="npm install"
alias nid="npm install --save-dev"
alias nig="npm install -g"
alias nr="npm run"
alias ns="npm start"
alias nt="npm test"

# pnpm aliases
alias pi="pnpm install"
alias pa="pnpm add"
alias pr="pnpm run"

# Docker aliases
alias dc="docker-compose"
alias dcu="docker-compose up"
alias dcd="docker-compose down"
alias dcl="docker-compose logs -f"

# ===== FUNCTIONS =====

# Create a new directory and enter it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Extract various archive formats
extract() {
  if [ -f $1 ]; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# ===== GPG CONFIGURATION =====
# Required for GPG signing commits
export GPG_TTY=$(tty)

# ===== SKELLO SPECIFIC =====

# Add any Skello-specific configurations here
# Example: Shortcuts to Skello projects
alias cdskello="cd ~/skello/skello-app"
alias cdmobile="cd ~/skello/skello-mobile"
alias cdsuperadmin="cd ~/skello/superadmin"

# ===== HISTORY CONFIGURATION =====
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

# ===== OTHER SETTINGS =====

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Use modern completion system
autoload -Uz compinit
compinit

# Welcome message
echo "🚀 Welcome back! Environment loaded successfully."
echo "💡 Type 'reload' to reload this configuration"
