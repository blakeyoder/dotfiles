#!/bin/bash
# Bootstrap script for fresh macOS install
# Run: curl -fsSL https://raw.githubusercontent.com/blakeyoder/dotfiles/master/bootstrap.sh | bash
# Or: ./bootstrap.sh

set -e

echo "============================================"
echo "  Blake's macOS Development Environment"
echo "============================================"
echo ""

DOTFILES_DIR="$HOME/dotfiles"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Check if running on macOS
if [[ "$(uname)" != "Darwin" ]]; then
    error "This script is designed for macOS only"
    exit 1
fi

# Install Xcode Command Line Tools
if ! xcode-select -p &>/dev/null; then
    info "Installing Xcode Command Line Tools..."
    xcode-select --install
    echo "Press Enter after Xcode Command Line Tools installation completes..."
    read -r
else
    info "Xcode Command Line Tools already installed"
fi

# Install Homebrew
if ! command -v brew &>/dev/null; then
    info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon
    if [[ -f "/opt/homebrew/bin/brew" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    info "Homebrew already installed"
fi

# Clone dotfiles
if [ -d "$DOTFILES_DIR" ]; then
    info "Dotfiles directory exists, pulling latest..."
    cd "$DOTFILES_DIR" && git pull
else
    info "Cloning dotfiles..."
    git clone https://github.com/blakeyoder/dotfiles.git "$DOTFILES_DIR"
fi

cd "$DOTFILES_DIR"

# Install packages from Brewfile
info "Installing Homebrew packages..."
brew bundle install --file="$DOTFILES_DIR/Brewfile"

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    info "Installing Oh My Zsh..."
    RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    info "Oh My Zsh already installed"
fi

# Install Zsh plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    info "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
else
    info "zsh-autosuggestions already installed"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    info "Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
else
    info "zsh-syntax-highlighting already installed"
fi

# Run dotfiles install script
info "Creating symlinks..."
"$DOTFILES_DIR/install.sh"

# Install Vundle for Vim
if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]; then
    info "Installing Vundle for Vim..."
    git clone https://github.com/VundleVim/Vundle.vim.git "$HOME/.vim/bundle/Vundle.vim"
    info "Installing Vim plugins..."
    vim +PluginInstall +qall
else
    info "Vundle already installed"
fi

# Setup NVM directory
mkdir -p "$HOME/.nvm"

# Create secrets file template if it doesn't exist
if [ ! -f "$HOME/.secrets" ]; then
    info "Creating ~/.secrets template..."
    cat > "$HOME/.secrets" << 'EOF'
# ~/.secrets - API keys and credentials (not tracked in git)
# export OPENAI_API_KEY="your-key-here"
# export ANTHROPIC_API_KEY="your-key-here"
EOF
    chmod 600 "$HOME/.secrets"
fi

echo ""
echo "============================================"
echo "  Installation Complete!"
echo "============================================"
echo ""
echo "Next steps:"
echo ""
echo "1. Restart your terminal or run: source ~/.zshrc"
echo ""
echo "2. Install Node.js via NVM:"
echo "   nvm install --lts"
echo ""
echo "3. Launch Neovim to install plugins:"
echo "   nvim"
echo ""
echo "4. Configure iTerm2 (optional):"
echo "   iTerm2 -> Preferences -> Profiles -> Other Actions -> Import JSON Profiles"
echo "   Select: $DOTFILES_DIR/com.googlecode.iterm2.plist"
echo ""
echo "5. Add your API keys to ~/.secrets"
echo ""
echo "6. Restart Karabiner if key mappings aren't working:"
echo "   launchctl kickstart -k gui/\$(id -u)/org.pqrs.karabiner.karabiner_console_user_server"
echo ""
