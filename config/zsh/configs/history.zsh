setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups
setopt inc_append_history

HISTFILE=${ZDOTDIR:-$HOME}/.zhistory
HISTSIZE=4096
SAVEHIST=4096
