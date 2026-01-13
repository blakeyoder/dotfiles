# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme (disabled - using starship instead)
# ZSH_THEME="robbyrussell"

# History configuration
HIST_STAMPS="yyyy-mm-dd"
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY          # Share history between sessions
setopt HIST_IGNORE_ALL_DUPS   # Remove older duplicates
setopt HIST_REDUCE_BLANKS     # Remove extra whitespace
setopt HIST_IGNORE_SPACE      # Commands starting with space aren't saved
setopt HIST_VERIFY            # Show command before executing from history
setopt EXTENDED_HISTORY       # Save timestamps in history

# Completion options
setopt AUTO_CD              # cd by typing directory name
setopt CORRECT              # Spell correction for commands
setopt COMPLETE_IN_WORD     # Complete from both ends of word
zstyle ':completion:*' menu select  # Arrow-key driven completion

# Plugins - install external ones first:
# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
plugins=(git zsh-autosuggestions zsh-syntax-highlighting docker npm)

source $ZSH/oh-my-zsh.sh

# Editor
export EDITOR='nvim'
export VISUAL="$EDITOR"

# Cache homebrew prefix
export HOMEBREW_PREFIX="${HOMEBREW_PREFIX:-$(brew --prefix)}"

# Android SDK
export ANDROID_HOME=$HOME/Library/Android/sdk

# PATH configuration (consolidated)
typeset -U path  # Prevent duplicates
path=(
  /opt/homebrew/opt/postgresql@17/bin
  $HOME/.local/bin
  $HOME/.opencode/bin
  $ANDROID_HOME/emulator
  $ANDROID_HOME/platform-tools
  $path
)

# Lazy-load NVM for faster shell startup
export NVM_DIR="$HOME/.nvm"
# Add default node bin to PATH so Vim/ALE can find tsserver
export PATH="$NVM_DIR/versions/node/v24.7.0/bin:$PATH"
nvm() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  nvm "$@"
}
node() { unset -f node npm npx nvm; [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"; node "$@"; }
npm() { unset -f node npm npx nvm; [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"; npm "$@"; }
npx() { unset -f node npm npx nvm; [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"; npx "$@"; }

# Zoxide (smarter autojump replacement)
eval "$(zoxide init zsh)"
alias j="z"

# Google Cloud SDK
if [ -f '/Users/blake/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/blake/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/Users/blake/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/blake/google-cloud-sdk/completion.zsh.inc'; fi

# Github aliases
alias openpr='gh pr view --json url -q .url | xargs open'
alias cc='claude --dangerously-skip-permissions --append-system-prompt "$(cat ~/.auto-plan-mode.txt)"'

# Secrets (API keys, tokens) - not tracked in version control
[[ -f ~/.secrets ]] && source ~/.secrets

# Use Neovim as default
alias vim="nvim"
alias vi="nvim"

# Modern CLI replacements
alias cat="bat --paging=never"
alias ls="eza --icons --group-directories-first"
alias ll="eza -la --icons --group-directories-first"
alias la="eza -a --icons --group-directories-first"
alias tree="eza --tree --icons"

# fzf - fuzzy finder (Ctrl+R for history, Ctrl+T for files)
source <(fzf --zsh)

# Starship prompt
eval "$(starship init zsh)"
