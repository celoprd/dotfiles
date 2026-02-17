#!/bin/bash

# Setup SSH keys for GitHub

set -e

echo "🔑 Setting up SSH keys for GitHub..."

SSH_DIR="$HOME/.ssh"
SSH_KEY="$SSH_DIR/id_ed25519"

# Create .ssh directory if it doesn't exist
if [ ! -d "$SSH_DIR" ]; then
    echo "Creating .ssh directory..."
    mkdir -p "$SSH_DIR"
    chmod 700 "$SSH_DIR"
fi

# Generate SSH key if it doesn't exist
if [ -f "$SSH_KEY" ]; then
    echo "✓ SSH key already exists at $SSH_KEY"
else
    echo "Generating new SSH key..."
    echo "Please enter your GitHub email address:"
    read -p "Email: " email

    if [ -z "$email" ]; then
        echo "✗ Email is required"
        exit 1
    fi

    ssh-keygen -t ed25519 -o -a 100 -f "$SSH_KEY" -C "$email"
    echo "✓ SSH key generated"
fi

# Setup SSH config
SSH_CONFIG="$SSH_DIR/config"
if [ -f "$SSH_CONFIG" ]; then
    echo "✓ SSH config already exists"
else
    echo "Creating SSH config..."
    cat > "$SSH_CONFIG" << 'EOF'
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519

Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519
EOF
    chmod 600 "$SSH_CONFIG"
    echo "✓ SSH config created"
fi

# Start ssh-agent and add key
echo "Adding SSH key to ssh-agent..."
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain "$SSH_KEY" 2>/dev/null || ssh-add "$SSH_KEY"

# Display public key
echo ""
echo "======================================"
echo "Your SSH public key:"
echo "======================================"
cat "${SSH_KEY}.pub"
echo "======================================"
echo ""
echo "📋 Copy the above SSH public key and add it to GitHub:"
echo "   1. Go to https://github.com/settings/keys"
echo "   2. Click 'New SSH key'"
echo "   3. Paste the key above"
echo "   4. Click 'Add SSH key'"
echo ""
echo "To copy the key to clipboard, run:"
echo "   pbcopy < ~/.ssh/id_ed25519.pub"
echo ""
echo "After adding the key to GitHub, test the connection with:"
echo "   ssh -T git@github.com"
echo ""
