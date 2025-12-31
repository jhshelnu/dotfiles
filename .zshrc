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

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting

# Set terminal tab title to current directory name
function set_win_title() {
    echo -ne "\033]0; $(basename "$PWD") \007"
}
precmd_functions+=(set_win_title)

alias q="exit"

# add starship hook
eval "$(starship init zsh)"
