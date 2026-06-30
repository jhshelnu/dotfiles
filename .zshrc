# To use this file, add the following to `~/.zshrc`:
#
#   COMMON_ZSHRC="$HOME/.config/.zshrc"
#   if [[ -r "$COMMON_ZSHRC" ]]; then
#      source "$COMMON_ZSHRC"
#   fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# shell completions
autoload -Uz compinit && compinit
command -v jj      &>/dev/null && source <(COMPLETE=zsh jj)
command -v kubectl &>/dev/null && source <(kubectl completion zsh)
command -v op      &>/dev/null && source <(op completion zsh)
command -v docker  &>/dev/null && source <(docker completion zsh)
command -v rustup  &>/dev/null && source <(rustup completions zsh)

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting

alias q="exit"

export EDITOR=nvim

# VIM keybindings
bindkey -v # enable vim mode
export KEYTIMEOUT=1 # eliminate the delay when switching modes
bindkey '^A' beginning-of-line # preserve this keybind in insert mode
bindkey '^E' end-of-line # preserve this keybind in insert mode
bindkey -M vicmd '_' vi-beginning-of-line # map underscore to the beginning of the line in command mode

# setup starship if needed
if [[ -z "$STARSHIP_INITIALIZED" ]]; then
    eval "$(starship init zsh)"
    STARSHIP_INITIALIZED=1
fi
