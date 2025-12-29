# dotfiles

Blake's macOS development environment configuration.

## Quick Install

```bash
# Clone the repo
git clone https://github.com/blakeyoder/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Install dotfiles (creates symlinks)
./install.sh

# Install Claude Code config (optional)
./install-claude.sh
```

## Prerequisites

Install these via Homebrew:

```bash
# Core tools
brew install neovim starship zoxide bat eza fzf ripgrep fd

# Optional but recommended
brew install git tmux
```

## What's Included

| File | Description |
|------|-------------|
| `.zshrc` | Zsh configuration with modern CLI tools |
| `.gitconfig` | Git configuration |
| `.vimrc` | Vim configuration with Vundle plugins |
| `nvim/` | Neovim configuration with Lazy.nvim |
| `.tmux.conf` | Tmux configuration |
| `karabiner.json` | Karabiner-Elements key mappings |
| `claude/` | Claude Code configuration |

## Post-Install Setup

### Vim

```bash
# Install Vundle plugin manager
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install plugins
vim +PluginInstall +qall
```

### Neovim

Plugins auto-install on first launch via Lazy.nvim:

```bash
nvim
```

### Shell

The `.zshrc` expects Oh My Zsh:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### Secrets

Create `~/.secrets` for API keys and credentials:

```bash
# ~/.secrets
export OPENAI_API_KEY="your-key"
# ... other secrets
```

Add to `.zshrc`: `source ~/.secrets`

## Karabiner-Elements

After running `install.sh`, restart Karabiner:

```bash
launchctl kickstart -k gui/$(id -u)/org.pqrs.karabiner.karabiner_console_user_server
```

Key mappings:
- Caps Lock -> Escape (tap) / Control (hold)
- Caps Lock -> Hyper key (Cmd+Ctrl+Opt+Shift)

## Claude Code

See `claude/` directory for Claude Code configuration including:
- `CLAUDE.md` - Global instructions and development guidelines
- `settings.json` - MCP servers and allowed tools
- `commands/` - Custom slash commands
- `skills/` - Workflow enforcement skills
- `hooks/` - Automation hooks
- `agents/` - Custom agents

Install with: `./install-claude.sh`

## iTerm2

Import the iTerm2 profile:

1. Open iTerm2 -> Preferences -> Profiles
2. Click "Other Actions" -> "Import JSON Profiles"
3. Select `com.googlecode.iterm2.plist`

## Updating

Since dotfiles are symlinked, just pull updates:

```bash
cd ~/dotfiles
git pull
```

Changes are reflected immediately (no reinstall needed).
