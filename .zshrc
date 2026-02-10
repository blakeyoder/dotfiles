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

# Clean up stale zcompdump files from hostname changes (runs once, fast)
for f in ~/.zcompdump*; do
  [[ "$f" == ~/.zcompdump-${HOST}-${ZSH_VERSION}* ]] || rm -f "$f"
done

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

# Zoxide (smarter autojump replacement) - cached for fast startup
_zoxide_cache="$HOME/.cache/zsh/zoxide_init.zsh"
if [[ ! -f "$_zoxide_cache" || "$(whence -p zoxide)" -nt "$_zoxide_cache" ]]; then
  mkdir -p "$HOME/.cache/zsh"
  zoxide init zsh > "$_zoxide_cache"
  zcompile "$_zoxide_cache"
fi
source "$_zoxide_cache"
alias j="z"

# Google Cloud SDK - lazy-loaded on first use
_load_gcloud() {
  unset -f gcloud gsutil bq
  if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi
  if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi
}
gcloud() { _load_gcloud; gcloud "$@"; }
gsutil() { _load_gcloud; gsutil "$@"; }
bq() { _load_gcloud; bq "$@"; }

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

# fzf - fuzzy finder (Ctrl+R for history, Ctrl+T for files) - cached for fast startup
_fzf_cache="$HOME/.cache/zsh/fzf_init.zsh"
if [[ ! -f "$_fzf_cache" || "$(whence -p fzf)" -nt "$_fzf_cache" ]]; then
  mkdir -p "$HOME/.cache/zsh"
  fzf --zsh > "$_fzf_cache"
  zcompile "$_fzf_cache"
fi
source "$_fzf_cache"

# Starship prompt - cached for fast startup
_starship_cache="$HOME/.cache/zsh/starship_init.zsh"
if [[ ! -f "$_starship_cache" || "$(whence -p starship)" -nt "$_starship_cache" ]]; then
  mkdir -p "$HOME/.cache/zsh"
  starship init zsh > "$_starship_cache"
  zcompile "$_starship_cache"
fi
source "$_starship_cache"

# bun completions
[ -s "/Users/blake/.bun/_bun" ] && source "/Users/blake/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
