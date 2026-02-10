#!/bin/bash
# Bootstrap script for fresh macOS install
# Run: curl -fsSL https://raw.githubusercontent.com/blakeyoder/dotfiles/master/bootstrap.sh | bash
# Or: ./bootstrap.sh

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

# Step counter
CURRENT_STEP=0
TOTAL_STEPS=8

step() {
    CURRENT_STEP=$((CURRENT_STEP + 1))
    echo ""
    echo -e "${GREEN}[$CURRENT_STEP/$TOTAL_STEPS]${NC} $1"
}

confirm() {
    local prompt="$1"
    local response
    read -rp "$prompt [y/n] " response
    [[ "$response" =~ ^[Yy] ]]
}

run_step() {
    local description="$1"
    shift
    while true; do
        if "$@"; then
            return 0
        else
            echo ""
            error "$description failed."
            local choice
            read -rp "  [R]etry / [S]kip / [A]bort? " choice
            case "$choice" in
                [Rr]*) continue ;;
                [Ss]*) warn "Skipping: $description"; return 0 ;;
                [Aa]*) error "Aborting."; exit 1 ;;
                *) echo "  Please enter r, s, or a." ;;
            esac
        fi
    done
}

# Check if running on macOS
if [[ "$(uname)" != "Darwin" ]]; then
    error "This script is designed for macOS only"
    exit 1
fi

# Confirmation before starting
echo "This script will set up:"
echo "  - Xcode Command Line Tools"
echo "  - Homebrew"
echo "  - Brewfile packages (CLI tools, casks)"
echo "  - Oh My Zsh + plugins"
echo "  - Dotfile symlinks"
echo "  - Vim plugins (Vundle)"
echo "  - NVM (Node Version Manager)"
echo ""
if ! confirm "Proceed?"; then
    echo "Setup cancelled."
    exit 0
fi

# Step 1: Xcode Command Line Tools
step "Installing Xcode Command Line Tools"
if ! xcode-select -p &>/dev/null; then
    run_step "Xcode Command Line Tools" xcode-select --install
    echo "Press Enter after Xcode Command Line Tools installation completes..."
    read -r
else
    info "Xcode Command Line Tools already installed"
fi

# Step 2: Homebrew
step "Installing Homebrew"
if ! command -v brew &>/dev/null; then
    run_step "Homebrew install" /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon
    if [[ -f "/opt/homebrew/bin/brew" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    info "Homebrew already installed"
fi

# Step 3: Clone dotfiles
step "Cloning dotfiles"
if [ -d "$DOTFILES_DIR" ]; then
    info "Dotfiles directory exists, pulling latest..."
    run_step "Dotfiles pull" git -C "$DOTFILES_DIR" pull
else
    run_step "Dotfiles clone" git clone https://github.com/blakeyoder/dotfiles.git "$DOTFILES_DIR"
fi

cd "$DOTFILES_DIR"

# Step 4: Homebrew packages (with optional item prompts)
step "Installing Homebrew packages"

BREWFILE="$DOTFILES_DIR/Brewfile"
TEMP_BREWFILE=$(mktemp)
cp "$BREWFILE" "$TEMP_BREWFILE"

declare -a OPTIONAL_ITEMS=(
    'brew "python@3.13"|Python 3.13'
    'brew "postgresql@17"|PostgreSQL 17'
    'brew "redis"|Redis'
    'brew "awscli"|AWS CLI'
    'cask "iterm2"|iTerm2'
    'cask "claude-code"|Claude Code'
)

echo ""
info "Optional packages:"
for item in "${OPTIONAL_ITEMS[@]}"; do
    pattern="${item%%|*}"
    name="${item##*|}"
    if confirm "  Install $name?"; then
        sed -i '' "s|^# ${pattern}|${pattern}|" "$TEMP_BREWFILE"
    fi
done

echo ""
run_step "Homebrew bundle" brew bundle install --file="$TEMP_BREWFILE"
rm -f "$TEMP_BREWFILE"

# Step 5: Oh My Zsh + plugins
step "Installing Oh My Zsh and plugins"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    run_step "Oh My Zsh" env RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    info "Oh My Zsh already installed"
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    run_step "zsh-autosuggestions" git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
else
    info "zsh-autosuggestions already installed"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    run_step "zsh-syntax-highlighting" git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
else
    info "zsh-syntax-highlighting already installed"
fi

# Step 6: Symlinks
step "Creating symlinks"
run_step "Dotfile symlinks" "$DOTFILES_DIR/install.sh"

# Step 7: Vim plugins
step "Installing Vim plugins"
if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]; then
    run_step "Vundle clone" git clone https://github.com/VundleVim/Vundle.vim.git "$HOME/.vim/bundle/Vundle.vim"
    run_step "Vim plugins" vim +PluginInstall +qall
else
    info "Vundle already installed"
fi

# Step 8: NVM + secrets
step "Setting up NVM and secrets"
mkdir -p "$HOME/.nvm"

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

# Interactive post-install steps
if confirm "Install Node.js LTS via NVM now?"; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"
    [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
    run_step "Node.js LTS install" nvm install --lts
fi

if confirm "Install Claude Code configuration?"; then
    run_step "Claude Code config" "$DOTFILES_DIR/install-claude.sh"
fi

if [ -d "/Applications/iTerm.app" ] || [ -d "$HOME/Applications/iTerm.app" ]; then
    if confirm "Import iTerm2 profile?"; then
        if [ -f "$DOTFILES_DIR/com.googlecode.iterm2.plist" ]; then
            run_step "iTerm2 profile import" cp "$DOTFILES_DIR/com.googlecode.iterm2.plist" "$HOME/Library/Preferences/com.googlecode.iterm2.plist"
            info "iTerm2 profile imported. Restart iTerm2 to apply."
        else
            warn "iTerm2 profile not found at $DOTFILES_DIR/com.googlecode.iterm2.plist"
        fi
    fi
fi

echo ""
echo "Remaining manual steps:"
echo ""
echo "1. Restart your terminal or run: source ~/.zshrc"
echo ""
echo "2. Launch Neovim to install plugins:"
echo "   nvim"
echo ""
echo "3. Add your API keys to ~/.secrets"
echo ""
echo "4. Restart Karabiner if key mappings aren't working:"
echo "   launchctl kickstart -k gui/\$(id -u)/org.pqrs.karabiner.karabiner_console_user_server"
echo ""
