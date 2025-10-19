alias l="ls -lAh"
alias ll="ls -al"
alias la="ls -A"

alias e="nvim"

alias path='echo $PATH | tr -s ":" "\n"'

alias d="cd $HOME/.dotfiles"
alias n="cd $HOME/.dotfiles/config/nvim"

alias urepo='for d in *; do (cd $d && pwd && git pull && echo); done'
alias brepo='for d in *; do (cd "$d" && pwd && git branch && echo); done'
