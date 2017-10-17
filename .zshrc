# Path to your oh-my-zsh installation.
export ZSH=/Users/blakeyoder/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

plugins=(bundler, osx, ruby, rake)

#source for autojump
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

# User configuration
export CLICOLOR=1
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

#avoid duplicates
export HISTCONTROL=ignoredups:erasedups
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# unlimited size:
setopt inc_append_history
setopt share_history

source $ZSH/oh-my-zsh.sh

# Example aliases
alias cl=clear
alias buddy=weechat

# -------------------------------------------------------------------
# Functions ported directly from .bashrc
# -------------------------------------------------------------------
# turn hidden files on/off in Finder
function hiddenOn() { defaults write com.apple.Finder AppleShowAllFiles YES ; }
function hiddenOff() { defaults write com.apple.Finder AppleShowAllFiles NO ; }

# postgres functions
function psqlstart() { /usr/local/pgsql/bin/pg_ctl -D /usr/local/pgsql/data -l logfile start ; }
function psqlstop() { /usr/local/pgsql/bin/pg_ctl stop ; }

# view man pages in Preview
function pman() { ps=`mktemp -t manpageXXXX`.ps ; man -t $@ > "$ps" ; open "$ps" ; }

alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"

#used for the python virtualenv
alias activate="source venv/bin/activate"
alias pyr="python manage.py run"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PYTHONDONTWRITEBYTECODE=1

# git aliases
alias ga='git add'
alias gaa='git add .'
alias gaaa='git add --all'
alias gau='git add --update'
alias gb='git branch'
alias gbd='git branch --delete '
alias gc='git commit'
alias gcm='git commit --message'
alias gcf='git commit --fixup'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcom='git checkout master'
alias gd='git diff'
alias gda='git diff HEAD'
alias gi='git init'
alias glg='git log --graph --oneline --decorate --all'
alias gld='git log --pretty=format:"%h %ad %s" --date=short --all'
alias gm='git merge --no-ff'
alias gma='git merge --abort'
alias gmc='git merge --continue'
alias gp='git pull'
alias gpr='git pull --rebase'
alias gr='git rebase'
alias gs='git status'
alias gss='git status --short'
alias gst='git stash'
alias gsta='git stash apply'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash save'
alias gpush='git push '
alias gtracked='git ls-tree -r master --name-only'
alias gcleanup="git fetch -p && for branch in `git branch -vv | grep ': gone]' | awk '{print $1}'`; do git branch -D $branch; done"

#git functions
function glf() { git log --all --grep="$1"; }

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
