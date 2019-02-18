# give us access to ^Q
stty -ixon

# Handy keybindings
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward
