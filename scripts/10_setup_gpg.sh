#!/bin/bash

# Setup GPG for commit signing

set -e

echo "🔐 Setting up GPG for commit signing..."

# Check if GPG is installed
if ! command -v gpg &> /dev/null; then
    echo "✗ GPG is not installed. Installing via Homebrew..."
    brew install gpg
fi

# Check if a GPG key already exists
if gpg --list-secret-keys --keyid-format=long | grep -q "sec"; then
    echo "✓ GPG key already exists"
    echo ""
    echo "Existing GPG keys:"
    gpg --list-secret-keys --keyid-format=long
else
    echo "No existing GPG key found. Let's create one..."
    echo ""
    echo "Please provide the following information:"
    read -p "First and Last name: " name
    read -p "Email (use your @skello.io email): " email

    if [ -z "$name" ] || [ -z "$email" ]; then
        echo "✗ Name and email are required"
        exit 1
    fi

    echo "Generating GPG key..."
    gpg --batch --generate-key <<EOF
%no-protection
Key-Type: RSA
Key-Length: 4096
Subkey-Type: RSA
Subkey-Length: 4096
Name-Real: $name
Name-Email: $email
Expire-Date: 0
EOF

    echo "✓ GPG key generated"
fi

# Get the key ID
KEY_ID=$(gpg --list-secret-keys --keyid-format=long | grep "sec" | head -n 1 | sed 's/.*\/\([A-F0-9]*\).*/\1/')

if [ -z "$KEY_ID" ]; then
    echo "✗ Failed to get GPG key ID"
    exit 1
fi

echo ""
echo "Your GPG key ID: $KEY_ID"
echo ""

# Configure Git to use GPG
echo "Configuring Git to use GPG signing..."
git config --global user.signingkey "$KEY_ID"
git config --global commit.gpgsign true
git config --global gpg.program gpg
echo "✓ Git configured for GPG signing"

# Export GPG_TTY in shell profile (already in .zshrc)
echo ""
echo "======================================"
echo "Your GPG public key:"
echo "======================================"
gpg --armor --export "$KEY_ID"
echo "======================================"
echo ""
echo "📋 Copy the above GPG public key and add it to GitHub:"
echo "   1. Go to https://github.com/settings/keys"
echo "   2. Click 'New GPG key'"
echo "   3. Paste the entire key above (including BEGIN and END lines)"
echo "   4. Click 'Add GPG key'"
echo ""
echo "To copy the key to clipboard, run:"
echo "   gpg --armor --export $KEY_ID | pbcopy"
echo ""
echo "⚠️  Remember: You'll be asked for your GPG passphrase on your first commit"
echo ""
echo "If you encounter issues with GPG signing, run:"
echo "   export GPG_TTY=\$(tty)"
echo ""
