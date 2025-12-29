#!/bin/bash
# Claude Code Configuration Installer
# Symlinks Claude Code config from dotfiles to ~/.claude

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DOTFILES="$DOTFILES_DIR/claude"
CLAUDE_HOME="$HOME/.claude"

echo "Installing Claude Code configuration..."
echo "  Source: $CLAUDE_DOTFILES"
echo "  Target: $CLAUDE_HOME"
echo ""

# Create ~/.claude if it doesn't exist
mkdir -p "$CLAUDE_HOME"

# Function to create symlink with backup
symlink() {
    local src="$1"
    local dst="$2"

    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        echo "  Backing up existing $dst to $dst.backup"
        mv "$dst" "$dst.backup"
    fi

    if [ -L "$dst" ]; then
        rm "$dst"
    fi

    ln -s "$src" "$dst"
    echo "  Linked: $dst -> $src"
}

# Link top-level files
echo "Linking configuration files..."
symlink "$CLAUDE_DOTFILES/CLAUDE.md" "$CLAUDE_HOME/CLAUDE.md"
symlink "$CLAUDE_DOTFILES/settings.local.json" "$CLAUDE_HOME/settings.local.json"

# Link directories (commands, skills, hooks, agents)
echo "Linking directories..."
for dir in commands skills hooks agents; do
    if [ -d "$CLAUDE_DOTFILES/$dir" ]; then
        symlink "$CLAUDE_DOTFILES/$dir" "$CLAUDE_HOME/$dir"
    fi
done

# Handle settings.json with secrets
echo ""
echo "Setting up settings.json..."

SETTINGS_SRC="$CLAUDE_DOTFILES/settings.json"
SETTINGS_DST="$CLAUDE_HOME/settings.json"

if [ -f "$SETTINGS_DST" ] && [ ! -L "$SETTINGS_DST" ]; then
    # Check if existing settings has actual credentials
    if grep -q '"ARKHAM_PASSWORD": "\${ARKHAM_PASSWORD}"' "$SETTINGS_DST" 2>/dev/null; then
        # Template values - safe to overwrite
        symlink "$SETTINGS_SRC" "$SETTINGS_DST"
    else
        echo "  Existing settings.json found with credentials."
        echo "  Keeping existing file (not symlinking)."
        echo "  To update, manually merge changes from: $SETTINGS_SRC"
    fi
else
    symlink "$SETTINGS_SRC" "$SETTINGS_DST"
fi

# Create secrets template if needed
SECRETS_FILE="$HOME/.claude-secrets"
if [ ! -f "$SECRETS_FILE" ]; then
    echo ""
    echo "Creating secrets template at $SECRETS_FILE..."
    cat > "$SECRETS_FILE" << 'EOF'
# Claude Code Secrets
# Add these to your shell profile (e.g., .zshrc):
#   source ~/.claude-secrets
# Or set them as environment variables before running Claude Code

export ARKHAM_EMAIL="your-email@example.com"
export ARKHAM_PASSWORD="your-password-here"
EOF
    chmod 600 "$SECRETS_FILE"
    echo "  Created: $SECRETS_FILE (chmod 600)"
    echo "  Please edit this file with your actual credentials."
fi

echo ""
echo "Claude Code configuration installed!"
echo ""
echo "Summary:"
echo "  - CLAUDE.md (global instructions)"
echo "  - settings.json (global settings)"
echo "  - settings.local.json (permissions)"
echo "  - commands/ (prisma:validate, prisma:migrate, docs:system, arkham:store)"
echo "  - skills/ (test-driven-development, testing-anti-patterns)"
echo "  - hooks/ (linear-feature-flag-hook.py)"
echo "  - agents/ (plan-validator.md)"
echo ""
echo "Next steps:"
echo "  1. Edit ~/.claude-secrets with your credentials"
echo "  2. Add 'source ~/.claude-secrets' to your .zshrc"
echo "  3. Update MCP server paths in settings.json if needed"
echo ""
