#!/bin/bash

# Clone Skello repositories

set -e

echo "📦 Cloning Skello repositories..."

# Define the base directory for Skello projects
SKELLO_DIR="$HOME/skello"

# Check if GitHub CLI is installed
if ! command -v gh &> /dev/null; then
    echo "✗ GitHub CLI (gh) is not installed."
    echo "Installing GitHub CLI..."
    brew install gh
fi

# Authenticate with GitHub if not already done
if ! gh auth status &> /dev/null; then
    echo "Please authenticate with GitHub:"
    gh auth login
fi

# Create Skello directory
if [ ! -d "$SKELLO_DIR" ]; then
    echo "Creating $SKELLO_DIR directory..."
    mkdir -p "$SKELLO_DIR"
fi

cd "$SKELLO_DIR"

echo "📥 Fetching repository list from skelloapp organization..."

# Function to clone a repo if it doesn't exist
clone_repo() {
    local repo_name=$1
    local repo_url="git@github.com:skelloapp/${repo_name}.git"

    if [ -d "$SKELLO_DIR/$repo_name" ]; then
        echo "✓ $repo_name already exists, skipping..."
    else
        echo "Cloning $repo_name..."
        git clone "$repo_url" "$SKELLO_DIR/$repo_name"
        echo "✓ $repo_name cloned"
    fi
}

# Clone DevOps repository
echo ""
echo "📦 Cloning DevOps repository..."
clone_repo "devops"

# Get all repositories from skelloapp organization
echo ""
echo "📦 Fetching all svc-* repositories..."
SVC_REPOS=$(gh repo list skelloapp -L 500 --json name --jq '.[] | select(.name | startswith("svc-")) | .name')

if [ -n "$SVC_REPOS" ]; then
    echo "Found $(echo "$SVC_REPOS" | wc -l | tr -d ' ') svc-* repositories"
    while IFS= read -r repo; do
        clone_repo "$repo"
    done <<< "$SVC_REPOS"
else
    echo "⚠ No svc-* repositories found"
fi

# Get all skello-* repositories
echo ""
echo "📦 Fetching all skello-* repositories..."
SKELLO_REPOS=$(gh repo list skelloapp -L 500 --json name --jq '.[] | select(.name | startswith("skello-")) | .name')

if [ -n "$SKELLO_REPOS" ]; then
    echo "Found $(echo "$SKELLO_REPOS" | wc -l | tr -d ' ') skello-* repositories"
    while IFS= read -r repo; do
        clone_repo "$repo"
    done <<< "$SKELLO_REPOS"
else
    echo "⚠ No skello-* repositories found"
fi

# Clone specific repositories
echo ""
echo "📦 Cloning specific repositories..."
clone_repo "actions"
clone_repo "skills"
clone_repo "superadmin"

# Install skills
echo ""
echo "🔧 Installing skills..."
if [ -d "$SKELLO_DIR/skills" ]; then
    cd "$SKELLO_DIR"
    echo "Running: pnpx skills add skelloapp/skills"
    pnpx skills add skelloapp/skills || echo "⚠ Skills installation encountered an issue (this may be normal)"
    echo "✓ Skills installation attempted"
else
    echo "⚠ Skills repository not found, skipping installation"
fi

echo ""
echo "✓ All repositories cloned successfully!"
echo ""
echo "Summary:"
echo "  - DevOps repository: $SKELLO_DIR/devops"
echo "  - Microservices (svc-*): $SKELLO_DIR/svc-*"
echo "  - Projects (skello-*): $SKELLO_DIR/skello-*"
echo "  - Actions: $SKELLO_DIR/actions"
echo "  - Skills: $SKELLO_DIR/skills"
echo "  - Superadmin: $SKELLO_DIR/superadmin"
echo ""
echo "To navigate to a project, use:"
echo "  cd $SKELLO_DIR/<project-name>"
