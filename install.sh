#!/bin/bash
# Dotfiles Installer
# Creates symlinks from dotfiles repo to home directory

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing dotfiles..."
echo "  Source: $DOTFILES_DIR"
echo ""

# Function to create symlink with backup
symlink() {
    local src="$1"
    local dst="$2"

    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        echo "  Backing up existing $dst to $dst.backup"
        mv "$dst" "$dst.backup"
    fi

    if [ -L "$dst" ]; then
        local current_target=$(readlink "$dst")
        if [ "$current_target" = "$src" ]; then
            echo "  Already linked: $dst"
            return
        fi
        rm "$dst"
    fi

    ln -s "$src" "$dst"
    echo "  Linked: $dst -> $src"
}

# Ensure config directories exist
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.config/karabiner"

echo "Linking dotfiles..."

# Shell configuration
symlink "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

# Starship prompt configuration
symlink "$DOTFILES_DIR/starship.toml" "$HOME/.config/starship.toml"

# Aerospace window manager (optional)
if [ -f "$DOTFILES_DIR/.aerospace.toml" ]; then
    symlink "$DOTFILES_DIR/.aerospace.toml" "$HOME/.aerospace.toml"
fi

# Git configuration
symlink "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"

# Vim configuration
symlink "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"

# Neovim configuration
symlink "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

# Tmux configuration
symlink "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"

# Karabiner configuration
symlink "$DOTFILES_DIR/karabiner.json" "$HOME/.config/karabiner/karabiner.json"

echo ""
echo "Dotfiles installed!"
echo ""
echo "Linked files:"
echo "  ~/.zshrc"
echo "  ~/.config/starship.toml"
echo "  ~/.aerospace.toml"
echo "  ~/.gitconfig"
echo "  ~/.vimrc"
echo "  ~/.config/nvim"
echo "  ~/.tmux.conf"
echo "  ~/.config/karabiner/karabiner.json"
echo ""
echo "Prerequisites (install via Homebrew):"
echo "  brew install starship zoxide bat eza fzf ripgrep fd neovim"
echo ""
echo "For Vim plugins:"
echo "  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim"
echo "  vim +PluginInstall +qall"
echo ""
echo "For Neovim plugins:"
echo "  nvim  # Lazy.nvim will auto-install on first launch"
echo ""
echo "For Claude Code config:"
echo "  ./install-claude.sh"
echo ""
