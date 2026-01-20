# dotfiles

Blake's macOS development environment configuration.

## Fresh Install (New Machine)

Run the bootstrap script to set up everything automatically:

```bash
# One-liner for fresh macOS install
curl -fsSL https://raw.githubusercontent.com/blakeyoder/dotfiles/master/bootstrap.sh | bash
```

Or clone and run manually:

```bash
git clone https://github.com/blakeyoder/dotfiles.git ~/dotfiles
cd ~/dotfiles
./bootstrap.sh
```

The bootstrap script will:
- Install Xcode Command Line Tools
- Install Homebrew
- Install all dependencies from Brewfile
- Install Oh My Zsh and plugins
- Create symlinks for all dotfiles
- Install Vim/Neovim plugins

## Existing Machine (Update Only)

If you already have the repo cloned:

```bash
cd ~/dotfiles
git pull
./install.sh
```

## What's Included

| File | Description |
|------|-------------|
| `.zshrc` | Zsh configuration with modern CLI tools |
| `starship.toml` | Starship prompt configuration |
| `.aerospace.toml` | Aerospace tiling window manager config |
| `.gitconfig` | Git configuration |
| `.vimrc` | Vim configuration with Vundle plugins |
| `nvim/` | Neovim configuration with Lazy.nvim |
| `.tmux.conf` | Tmux configuration |
| `karabiner.json` | Karabiner-Elements key mappings |
| `claude/` | Claude Code configuration |
| `Brewfile` | Homebrew dependencies |

## Post-Install Setup

### iTerm2

Import the iTerm2 profile manually:

1. Open iTerm2 -> Preferences -> Profiles
2. Click "Other Actions" -> "Import JSON Profiles"
3. Select `com.googlecode.iterm2.plist`

### Secrets

Add your API keys to `~/.secrets`:

```bash
# ~/.secrets
export OPENAI_API_KEY="your-key"
export ANTHROPIC_API_KEY="your-key"
```

### Node.js

Install Node.js via NVM:

```bash
nvm install --lts
```

### Karabiner

Key mappings:
- Caps Lock -> Escape (tap) / Control (hold)
- Caps Lock -> Hyper key (Cmd+Ctrl+Opt+Shift)

Restart if needed:
```bash
launchctl kickstart -k gui/$(id -u)/org.pqrs.karabiner.karabiner_console_user_server
```

### Claude Code

Install Claude Code configuration:

```bash
./install-claude.sh
```

## Updating

Since dotfiles are symlinked, pull updates:

```bash
cd ~/dotfiles
git pull
```

Changes are reflected immediately (no reinstall needed).

## Key Tools

The setup uses these modern CLI tools:

| Tool | Replaces | Purpose |
|------|----------|---------|
| `eza` | `ls` | Modern file listing with icons |
| `bat` | `cat` | Syntax highlighting |
| `fd` | `find` | Fast file finder |
| `ripgrep` | `grep` | Fast search |
| `fzf` | - | Fuzzy finder (Ctrl+R, Ctrl+T) |
| `zoxide` | `cd` | Smart directory jumping |
| `starship` | - | Cross-shell prompt |
