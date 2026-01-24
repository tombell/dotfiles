alias l='ls -lAh'
alias ll='ls -al'
alias la='ls -A'

alias e='nvim'

alias path='echo $PATH | tr -s ":" "\n"'

alias urepo='for d in *; do (cd $d && pwd && git pull && echo); done'
alias brepo='for d in *; do (cd "$d" && pwd && git branch && echo); done'
alias stashed='for d in *; do (cd "$d" && pwd && git stash list && echo); done'

if command -v bat >/dev/null 2>&1; then
  alias cat='bat --paging=never'
fi
