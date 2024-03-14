# enable extended globbing
setopt extendedglob

# better history handling
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups
setopt inc_append_history

# allow [ or ] whereever you want
unsetopt nomatch

HISTSIZE=4096
SAVEHIST=4096
