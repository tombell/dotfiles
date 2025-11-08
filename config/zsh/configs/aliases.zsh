alias l="ls -lAh"
alias ll="ls -al"
alias la="ls -A"

alias e="nvim"

alias path='echo $PATH | tr -s ":" "\n"'

alias urepo='for d in *; do (cd $d && pwd && git pull && echo); done'
alias brepo='for d in *; do (cd "$d" && pwd && git branch && echo); done'
